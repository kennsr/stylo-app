import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_event.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/menu_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/style_preference_chips.dart';
import '../../../../core/theme/theme_ext.dart';

class ProfilePage extends StatefulWidget {
   const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add( ProfileFetch());
  }

  void _showStylePreferences(BuildContext context, ProfileLoaded state) {
    showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) => BlocProvider.value(
        value: context.read<ProfileBloc>(),
        child: StylePreferenceChips(
          preferences: state.stylePreferences,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Profil Kamu'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return  Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(
              child: Padding(
                padding:  EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64, color: Colors.red[300]),
                     SizedBox(height: 16),
                    Text(state.message, textAlign: TextAlign.center),
                     SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ProfileBloc>().add( ProfileFetch()),
                      child:  Text('Coba Lagi Dong'),
                    ),
                  ],
                ),
              ),
            );
          }

          final loadedState =
              state is ProfileLoaded ? state : null;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (loadedState != null)
                  ProfileHeader(user: loadedState.user)
                else
                  const _ProfileHeaderPlaceholder(),
                 Divider(height: 1),
                 SizedBox(height: 8),
                _MenuSection(
                  title: 'Aktivitas',
                  children: [
                    MenuTile(
                      icon: Icons.receipt_long_outlined,
                      title: 'Pesanan Saya',
                      onTap: () => context.go('/orders'),
                    ),
                    MenuTile(
                      icon: Icons.favorite_border_rounded,
                      title: 'Wishlist Saya',
                      onTap: () => context.push('/profile/wishlist'),
                    ),
                  ],
                ),
                _MenuSection(
                  title: 'Akun',
                  children: [
                    MenuTile(
                      icon: Icons.edit_outlined,
                      title: 'Edit Profil',
                      onTap: () => context.go('/profile/edit'),
                    ),
                    MenuTile(
                      icon: Icons.style_outlined,
                      title: 'Preferensi Gaya',
                      onTap: loadedState != null
                          ? () => _showStylePreferences(context, loadedState)
                          : null,
                    ),
                    MenuTile(
                      icon: Icons.accessibility_new_outlined,
                      title: 'Fit Profile',
                      onTap: () => context.push('/fit-profile'),
                    ),
                  ],
                ),
                _MenuSection(
                  title: 'Pengaturan',
                  children: [
                    BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, themeMode) {
                        return MenuTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Mode Gelap',
                          trailing: Switch(
                            value: themeMode == ThemeMode.dark,
                            onChanged: (_) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            activeThumbColor: AppColors.accent,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                _MenuSection(
                  children: [
                    MenuTile(
                      icon: Icons.logout,
                      title: 'Keluar',
                      isDestructive: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title:  Text('Keluar'),
                            content:  Text(
                                'Apakah kamu yakin ingin keluar dari akun?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child:  Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  context
                                      .read<AuthBloc>()
                                      .add( AuthLogoutRequested());
                                },
                                child: Text(
                                  'Keluar',
                                  style: TextStyle(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                 SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _MenuSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding:  EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.secondaryTextColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
        Card(
          margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _ProfileHeaderPlaceholder extends StatelessWidget {
  const _ProfileHeaderPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
          ),
           SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 120, height: 16, color: Colors.grey[200]),
               SizedBox(height: 8),
              Container(
                  width: 180, height: 12, color: Colors.grey[200]),
            ],
          ),
        ],
      ),
    );
  }
}
