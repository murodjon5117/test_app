import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:test_project/pages/result/cubit/result_cubit.dart';
import 'package:test_project/pages/result/screen/result_base_widget.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultCubit(),
      child: const ResultPageContent(),
    );
  }
}

class ResultPageContent extends StatefulWidget {
  const ResultPageContent({super.key});

  @override
  State<ResultPageContent> createState() => _ResultPageContentState();
}

class _ResultPageContentState extends State<ResultPageContent> {
  @override
  void initState() {
    final list = context.read<DashboardCubit>().state.sentToResult;
    context.read<ResultCubit>().addAll(list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Result'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  margin: const EdgeInsets.all(AppSize.s16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(width: AppSize.s1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  padding: const EdgeInsets.all(AppSize.s16),
                  child: Text(
                    'You got ${state.trueCount} correct out of ${state.resultList.length} tests.',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.color2879F2),
                  )),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p16,
                        right: AppPadding.p16,
                        bottom: AppPadding.p16),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ResultBaseWidget(
                        model: state.resultList[index],
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: AppSize.s16);
                    },
                    itemCount: state.resultList.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
