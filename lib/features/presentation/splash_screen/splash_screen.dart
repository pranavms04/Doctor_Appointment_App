import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:doctor_appointment_app/features/core/theme/theme_constants.dart';
import 'package:doctor_appointment_app/features/presentation/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController pulseController;

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Fixed: Consolidated nested timers to cleanly match the 3-second screen lifecycle
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulse = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );

    return Scaffold(
      backgroundColor: ThemeConstants.cardColor, // Pulls clean base layout background from setup tokens
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: pulse,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor, // Linked cleanly to app branding color
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeConstants.primaryColor.withAlpha(75),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.medical_services_rounded,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                  ).animate().scale(duration: 700.ms, curve: Curves.elasticOut),

                  const SizedBox(height: 35),

                  Text(
                    "Doctor Appointment",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.textMainColor,
                    ),
                  )
                      .animate(delay: 700.ms)
                      .fade(duration: 600.ms)
                      .slideY(begin: .4),

                  const SizedBox(height: 10),

                  Text(
                    "Book • Consult • Care",
                    style: TextStyle(fontSize: 16, color: ThemeConstants.textMutedColor),
                  ).animate(delay: 1200.ms).fade(),

                  const SizedBox(height: 60),

                  /// Styled Custom Progress Pipeline Indication Layout
                  SizedBox(
                    width: 180,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(seconds: 2),
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: ThemeConstants.backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: value,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: ThemeConstants.statusConfirmed, // Swapped inline color for confirmed status token
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Text(
                "Powered by Healthcare",
                textAlign: TextAlign.center,
                style: TextStyle(color: ThemeConstants.textMutedColor.withAlpha(150)),
              ).animate(delay: 1800.ms).fade(),
            ),
          ],
        ),
      ),
    );
  }
}
