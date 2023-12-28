import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_routes.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:test_project/pages/dashboard/screen/base_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Questions',
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              ListView.separated(
                  key: listKey,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppPadding.p16),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return BaseWidget(
                      model: state.allQuestions[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: AppSize.s16);
                  },
                  itemCount: state.allQuestions.length),
              state.allQuestions.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16),
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: state.avialableToResult
                              ? AppColors.color2879F2
                              : AppColors.primaryText,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width, AppSize.s50),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          elevation: AppSize.s0,
                        ),
                        onPressed: () {
                          if (state.avialableToResult) {
                            context.read<DashboardCubit>().setDefaultValue();
                            listKey = GlobalKey<AnimatedListState>();
                            setState(() {});
                            context.pushNamed(AppRoutes.resultRoute);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: AppColors.white,
                                  fontSize: AppSize.s14,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
              const SizedBox(height: AppSize.s32)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.white,
            child: const Icon(Icons.add_rounded),
            onPressed: () {
              context.pushNamed(AppRoutes.addRoute);
            },
          ),
        );
      },
    );
  }
}
