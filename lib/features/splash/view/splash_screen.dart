import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/navigation/app_routes.dart';
import '../../../utils/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _welcomeFadeAnimation;
  late Animation<Offset> _welcomeSlideAnimation;
  late Animation<double> _welcomeScaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _welcomeFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _welcomeSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _welcomeScaleAnimation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 0.8,
              end: 1.1,
            ).chain(CurveTween(curve: Curves.elasticOut)),
            weight: 50,
          ),
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 1.1,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 50,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );

    _animationController.forward();
    _initApp();
  }

  Future<void> _initApp() async {
    // Start version check (DON’T await)
    // final versionFuture = VersionCheckService().checkVersion();

    // Wait only for splash delay
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Navigate first
    _navigateToNextScreen();

    // Now handle version result in background
    // versionFuture.then((versionResult) {
    //   if (versionResult != null && versionResult.updateAvailable) {
    //     // Use navigator key context (important)
    //     final context = LocalStorageKeyStrings.appNavKey.currentContext;

    //     if (context != null) {
    //       showDialog(
    //         context: context,
    //         barrierDismissible: !versionResult.forceUpdate,
    //         builder: (context) => VersionUpdateDialog(
    //           forceUpdate: versionResult.forceUpdate,
    //           storeUrl: versionResult.storeUrl,
    //           onSkip: () => Navigator.of(context).pop(),
    //         ),
    //       );
    //     }
    //   }
    // });
  }

  void _navigateToNextScreen() {
    context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.bgColor,
                  ),
                ),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(color: Colors.black.withValues(alpha: 0.1)),
              ),
              Center(
                child: FadeTransition(
                  opacity: _welcomeFadeAnimation,
                  child: SlideTransition(
                    position: _welcomeSlideAnimation,
                    child: ScaleTransition(
                      scale: _welcomeScaleAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text(
                          //   "Welcome",
                          //   style: TextStyle(
                          //     fontSize: 48,
                          //     fontWeight: FontWeight.bold,
                          //     color: AppColors.white,
                          //     letterSpacing: 2,
                          //     shadows: [
                          //       Shadow(
                          //         color: Colors.black.withValues(alpha: 0.5),
                          //         blurRadius: 10,
                          //         offset: const Offset(0, 2),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const Icon(
                            Icons.home_work_outlined,
                            color: AppColors.white,
                            size: 96,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
