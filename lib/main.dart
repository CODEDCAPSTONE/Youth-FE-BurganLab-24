import 'package:flutter/material.dart';
import 'package:frontend/pages/add_target_page.dart';
import 'package:frontend/pages/card_details_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/loyalty_page.dart';
import 'package:frontend/pages/more_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/service_page.dart';
import 'package:frontend/pages/signin_page.dart';
import 'package:frontend/pages/steps_page.dart';
import 'package:frontend/pages/students_form.dart';
import 'package:frontend/pages/targets_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<GoalsProvider>(create: (_) => GoalsProvider()),
        // ChangeNotifierProvider<RealstockProvider>(
        //     create: (_) => RealstockProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // primaryTextTheme: TextTheme()
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    initialLocation: '/home', // Main page
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => RegisterPage(),
      // ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/steps',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: StepsPage()),
      ),
      GoRoute(
        path: '/targets',
        builder: (context, state) => TargetsPage(),
      ),
      GoRoute(
        path: '/addTarget',
        builder: (context, state) => AddTargetPage(),
      ),
      GoRoute(path: '/service', builder: (context, state) => ServicePage()),
      GoRoute(path: '/more', builder: (context, state) => SettingsPage()),

      GoRoute(path: '/loyalty', builder: (context, state) => LoyaltyPage()),

      GoRoute(
          path: '/cardDetails', builder: (context, state) => CardDetailsPage()),
      GoRoute(
          path: '/student_form',
          builder: (context, state) => UniversitySelectionPage())
      // ),
      //  GoRoute(
      //   path: '/edit',
      //   builder: (context, state) => EditgoalPage(
      //     index: state.extra as int,
      //   ),
      // ),
      //  GoRoute(
      //   path: '/edit',
      //   builder: (context, state) => EditgoalPage(
      //     index: state.extra as int,
      //   ),
      // ),
      //  GoRoute(
      //   path: '/edit',
      //   builder: (context, state) => EditgoalPage(
      //     index: state.extra as int,
      //   ),
      // ),
    ],
  );
}
