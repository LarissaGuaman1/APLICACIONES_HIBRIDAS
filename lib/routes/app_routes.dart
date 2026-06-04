import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/review_form_screen.dart';
import '../screens/my_reviews_screen.dart';
import '../screens/recommended_books_screen.dart';
import '../screens/about_screen.dart';
import '../screens/not_found_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String review = '/review';
  static const String myReviews = '/my-reviews';
  static const String recommended = '/recommended';
  static const String about = '/about';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case review:
        return MaterialPageRoute(
          builder: (_) => const ReviewFormScreen(),
        );

      case myReviews:
        return MaterialPageRoute(
          builder: (_) => const MyReviewsScreen(),
        );

      case recommended:
        return MaterialPageRoute(
          builder: (_) => const RecommendedBooksScreen(),
        );

      case about:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
        );
    }
  }
}