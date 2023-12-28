import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_router.dart';
import 'package:test_project/core/resource/app_theme.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(create: (context) => DashboardCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TestProject',
        theme: getApplicationTheme(),
        routerConfig: router,
      ),
    );
  }
}
