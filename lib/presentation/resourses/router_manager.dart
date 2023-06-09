import 'package:flu_proj/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:flu_proj/presentation/login/view/loginView.dart';
import 'package:flu_proj/presentation/main/main/view/main_view.dart';
import 'package:flu_proj/presentation/resourses/strings_manager.dart';
import 'package:flu_proj/presentation/spalsh/spalsh_view.dart';
import 'package:flu_proj/presentation/verification/view/verification_view.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../register/registerView/register_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String verificationRoute = "/verification";
  static const String forgotPasswordRoute = "/forgotPasword";
  static const String mainRoute = "/main";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.verificationRoute:
        initVerificationModule();
        return MaterialPageRoute(builder: (_) => const VerificationView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
