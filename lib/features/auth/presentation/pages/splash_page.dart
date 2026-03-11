import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../core/theme/theme_ext.dart';

class SplashPage extends StatefulWidget {
   const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add( AuthCheckStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthUnauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'stylo',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                      letterSpacing: -1,
                    ),
                  ),
                   SizedBox(height: 10),
                  Container(
                    width: 40,
                    height: 2,
                    color: AppColors.accent,
                  ),
                   SizedBox(height: 12),
                  Text(
                    'Fashion, Reimagined.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor:
                         AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
