# Enterprise Session Management Implementation

## Overview

The Stylo app now has enterprise-level session persistence that keeps users logged in across app restarts, with proper token expiry handling and automatic refresh capabilities.

---

## Session Configuration

### Industry-Standard Timing Parameters

```dart
class SessionConfig {
  /// Maximum session age: 30 days
  /// - Instagram, Facebook, TikTok use 30-90 days
  /// - Banking apps use 7-30 days
  /// - E-commerce typically uses 30 days
  static const maxSessionAge = Duration(days: 30);
  
  /// Token refresh threshold: 5 minutes before expiry
  /// - Prevents sudden logouts during active sessions
  /// - Gives buffer time for refresh operations
  static const refreshThreshold = Duration(minutes: 5);
  
  /// Minimum time between refresh attempts: 1 minute
  /// - Prevents API abuse/rate limiting
  /// - Reduces server load from rapid retries
  static const minRefreshInterval = Duration(minutes: 1);
}
```

---

## How It Works

### 1. **Login/Register Flow**

When a user logs in or registers:

```dart
// Token is cached with expiry timestamp
await localDataSource.cacheSessionToken(
  result.token,
  expiresAt: DateTime.now().add(const Duration(days: 30)),
);

// Last login time is recorded
await localDataSource.cacheLastLoginTime(DateTime.now());
```

**Stored Data:**
- `stylo_session_token` - The JWT/auth token
- `stylo_token_expiry` - When the token expires (ISO8601)
- `stylo_last_login` - When the user last logged in (ISO8601)

---

### 2. **App Startup Flow**

When the app starts:

```dart
// 1. Check if session is valid
final sessionValid = await localDataSource.isSessionValid();

// Validates:
// - Token exists
// - Token hasn't expired
// - Last login is within 30 days

// 2. If valid → auto-login user
// 3. If invalid → show login screen
```

---

### 3. **Session Validation**

A session is considered valid if ALL conditions are met:

1. ✅ Token exists and is not empty
2. ✅ Current time < token expiry time (if expiry is set)
3. ✅ Last login was within the last 30 days

```dart
Future<bool> isSessionValid({Duration? maxAge}) async {
  final token = await getSessionToken();
  if (token == null || token.isEmpty) return false;

  final expiry = await getTokenExpiry();
  if (expiry != null && DateTime.now().isAfter(expiry)) {
    return false; // Token expired
  }

  final lastLogin = await getLastLoginTime();
  if (lastLogin != null) {
    final age = DateTime.now().difference(lastLogin);
    final allowedAge = maxAge ?? SessionConfig.maxSessionAge;
    if (age > allowedAge) {
      return false; // Session too old
    }
  }

  return true;
}
```

---

### 4. **Token Refresh (Future Enhancement)**

When the token is approaching expiry (< 5 minutes remaining):

```dart
// Automatically detected during getCurrentUser()
if (await localDataSource.shouldRefreshToken()) {
  if (await localDataSource.canRefreshToken()) {
    // Rate limit check passed
    await localDataSource.cacheLastRefreshTime(DateTime.now());
    
    // TODO: Call backend refresh endpoint
    // final newToken = await apiClient.refreshToken();
    // await cacheSessionToken(newToken, expiresAt: ...);
  }
}
```

**Note:** Your backend needs to support token refresh for this to work fully.

---

### 5. **Logout Flow**

When user logs out:

```dart
// All session data is cleared
await localDataSource.clearSession();

// Clears:
// - stylo_session_token
// - stylo_token_expiry
// - stylo_last_login
// - stylo_last_refresh
// - Legacy token keys
```

---

## Data Storage

All session data is stored in **SharedPreferences** with the following keys:

| Key | Type | Purpose |
|-----|------|---------|
| `stylo_session_token` | String | Current auth token |
| `stylo_token_expiry` | String (ISO8601) | Token expiration timestamp |
| `stylo_last_login` | String (ISO8601) | Last successful login time |
| `stylo_last_refresh` | String (ISO8601) | Last token refresh attempt |

---

## Security Considerations

### Current Implementation

✅ **Good:**
- Tokens are persisted across app restarts
- Session has maximum age limit (30 days)
- Token expiry is validated
- Rate limiting on refresh attempts
- Session cleared on logout

⚠️ **Recommendations for Production:**

1. **Encrypted Storage**
   ```dart
   // Use flutter_secure_storage instead of SharedPreferences
   final secureStorage = FlutterSecureStorage();
   await secureStorage.write(key: 'token', value: token);
   ```

2. **Biometric Authentication**
   - Add fingerprint/Face ID for sensitive operations
   - Use `local_auth` package

3. **Certificate Pinning**
   - Prevent man-in-the-middle attacks
   - Use `dio` with certificate pinning

4. **Short-lived Access Tokens + Refresh Tokens**
   - Access token: 15-60 minutes
   - Refresh token: 30 days (stored securely)
   - Refresh endpoint rotates refresh tokens

---

## SessionManager Service

A dedicated service for session operations:

```dart
final sessionManager = sl<SessionManager>();

// Check if user has valid session
final isValid = await sessionManager.hasValidSession();

// Get time remaining until expiry
final timeRemaining = await sessionManager.getSessionTimeRemaining();

// Get session age
final age = await sessionManager.getSessionAge();

// Debug info
final info = await sessionManager.getSessionInfo();
```

---

## Testing the Implementation

### Test Scenarios

1. **Normal Login → Quit App → Reopen**
   - ✅ User should still be logged in
   - ✅ Session should be valid

2. **Wait 30+ Days → Reopen App**
   - ✅ User should be logged out (session expired)
   - ✅ Login screen should show

3. **Manual Logout → Reopen App**
   - ✅ User should be logged out
   - ✅ No session data should exist

4. **Token Expires While App is Open**
   - ✅ Next API call should fail with 401
   - ✅ User should be redirected to login

5. **Environment Change (Mock → Dev)**
   - ✅ Session should be cleared
   - ✅ User should log in again

---

## Backend Integration Requirements

To fully utilize this session management system, your backend should:

### 1. **JWT Token Structure**

```json
{
  "user": { "id": "...", "name": "...", "email": "..." },
  "token": "jwt_token_here",
  "expires_at": "2026-04-11T00:00:00Z"  // Optional but recommended
}
```

### 2. **Token Refresh Endpoint** (Optional but Recommended)

```
POST /auth/refresh
Headers: Authorization: Bearer <refresh_token>
Response: { "token": "new_access_token", "expires_at": "..." }
```

### 3. **Token Expiry Handling**

- Return `401 Unauthorized` when token is expired
- Include `WWW-Authenticate` header with error details

---

## Migration from Legacy System

The implementation maintains **backward compatibility**:

- Old `AppConstants.tokenKey` still works
- New session methods are additive
- Gradual migration is supported

To fully migrate:

1. Update login/register to use `cacheSessionToken()` ✅ (Done)
2. Update `getCurrentUser()` to use `getSessionToken()` ✅ (Done)
3. Update logout to use `clearSession()` ✅ (Done)
4. Remove legacy token methods (after testing)

---

## Files Modified

```
lib/features/auth/
├── data/
│   ├── datasources/
│   │   └── auth_local_data_source.dart    ← Enhanced with session methods
│   └── repositories/
│       └── auth_repository_impl.dart      ← Updated to use session management
└── domain/
    └── services/
        └── session_manager.dart           ← NEW: Dedicated session service

lib/app/
└── di/
    └── injection_container.dart           ← Registered SessionManager
```

---

## Summary

✅ **Implemented:**
- Session persists across app restarts (30 days)
- Automatic session validation on app start
- Token expiry tracking
- Session age limits
- Rate-limited token refresh (ready for backend support)
- Clean logout (all session data cleared)
- Environment-aware session clearing

🔧 **Next Steps:**
1. Test on real devices
2. Consider adding encrypted storage (flutter_secure_storage)
3. Implement backend token refresh endpoint
4. Add session analytics (track session duration, failures, etc.)

---

**Generated:** 2026-03-12  
**Author:** Enterprise Session Management Implementation
