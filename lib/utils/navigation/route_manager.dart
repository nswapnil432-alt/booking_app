import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../features/home/view/home_screen.dart';





import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/login/view/login_screen.dart';
import '../../features/signup/view/signup_screen.dart';
import '../constants/local_storage_key_strings.dart';
import 'app_routes.dart';


class AppRouter {
  // Define routes
  static final GoRouter router = GoRouter(
    navigatorKey: LocalStorageKeyStrings.appNavKey,
    initialLocation: AppRoutes.defaultLocation,
    // observers: [AnalyticsService.instance.getAnalyticsObserver()],
    routes: [
      GoRoute(
        path: AppRoutes.defaultLocation,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage(const SplashScreen()),
      ),
     
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => hcCustomTransitionPage(HomeScreen()),
      ),
       GoRoute(
        path: AppRoutes.onbordingScreen,
        pageBuilder: (context, state) => hcCustomTransitionPage(const OnboardingScreen()),
      ),
       GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => hcCustomTransitionPage(const LoginScreen()),
      ),
       GoRoute(
        path: AppRoutes.signUp,
        pageBuilder: (context, state) => hcCustomTransitionPage(const SignupScreen()),
      ),

     
     
     
     
     

      
    
     

      
    
      
     
    ],
  );
}

CustomTransitionPage<dynamic> hcCustomTransitionPage(
  Widget widget, {
  bool opaque = true,
}) {
  return CustomTransitionPage(
    child: widget,
    opaque: opaque,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
