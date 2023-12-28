import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/core/resource/app_routes.dart';
import 'package:test_project/pages/add_page/add_page.dart';
import 'package:test_project/pages/dashboard/dashboard_page.dart';
import 'package:test_project/pages/result/result_page.dart';

const String dashboardPath = '/dashboard';
const String addPath = '/add';
const String resultPath = '/result';

GoRouter router = GoRouter(
  initialLocation: dashboardPath,
  routes: [
    GoRoute(
      path: dashboardPath,
      name: AppRoutes.dashboardRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      path: addPath,
      name: AppRoutes.addRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const AddPage();
      },
    ),
    GoRoute(
      path: resultPath,
      name: AppRoutes.resultRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const ResultPage();
      },
    ),
  ],
);
