import 'package:flutter/material.dart';
import 'package:frontend/models/card.dart';
import 'package:frontend/pages/WAMD_page.dart';
import 'package:frontend/pages/add_target_page.dart';
import 'package:frontend/pages/card_details_page.dart';
import 'package:frontend/pages/budget_details.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/job_details_page.dart';
import 'package:frontend/pages/loyalty_page.dart';
import 'package:frontend/pages/main_page.dart';
import 'package:frontend/pages/more_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/service_page.dart';
import 'package:frontend/pages/request_link_page.dart';
import 'package:frontend/pages/setup_budget_page.dart';
import 'package:frontend/pages/signin_page.dart';
import 'package:frontend/pages/steps_page.dart';
import 'package:frontend/pages/students_form.dart';
import 'package:frontend/pages/targets_page.dart';
import 'package:frontend/pages/transaction_page.dart';
import 'package:frontend/pages/transfer_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:frontend/providers/card_provider.dart';
import 'package:frontend/providers/extra_provider.dart';
// import 'package:frontend/providers/goals_provider.dart';
import 'package:frontend/providers/targets_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        // ChangeNotifierProvider<GoalsProvider>(create: (_) => GoalsProvider()),
        ChangeNotifierProvider<VCardsProvider>(create: (_) => VCardsProvider()),
        ChangeNotifierProvider<TargetsProvider>(create: (_) => TargetsProvider()),
        ChangeNotifierProvider<BudgetProvider>(create: (_) => BudgetProvider()),
        ChangeNotifierProvider<ExtraProvider>(create: (_) => ExtraProvider()),
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
    initialLocation: '/signin', // Main page
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
        builder: (context, state) => const AddTargetPage(),
      ),
      GoRoute(path: '/service', builder: (context, state) => const ServicePage()),
      GoRoute(path: '/more', builder: (context, state) => const SettingsPage()),

      GoRoute(path: '/loyalty', builder: (context, state) => LoyaltyPage()),

      GoRoute(
          path: '/cardDetails', builder: (context, state) => CardDetailsPage(card: state.extra as VCard,)),
      GoRoute(
          path: '/student_form',
          builder: (context, state) => const UniversitySelectionPage()),
      GoRoute(
        path: '/setupBudget',
        builder: (context, state) => SetupBudgetPage(edit: state.extra as bool,),
      ),
      GoRoute(
        path: '/transfer',
        builder: (context, state) => TransferPage(),
      ),
      GoRoute(
        path: '/budgetDetails',
        builder: (context, state) => BudgetDetails(),
      ),
      GoRoute(
        path: '/link',
        builder: (context, state) => RequestLinkPage(),
      ),
      GoRoute(
        path: '/wamd',
        builder: (context, state) => WamdPage(),
      ),
      GoRoute(
        path: '/jobDetails',
        builder: (context, state) => JobDetailsPage(index: state.extra as int,),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        path: '/transactions',
        builder: (context, state) => TransactionPage(),
      ),
      // GoRoute(
      //   path: '/main',
      //   builder: (context, state) => MainPage(index: state.extra as int),
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
