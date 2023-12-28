import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_enums.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';
import 'package:test_project/pages/result/cubit/result_cubit.dart';
import 'package:test_project/pages/result/screen/result_checkbox_widget.dart';
import 'package:test_project/pages/result/screen/result_input_screen.dart';
import 'package:test_project/pages/result/screen/result_multiple_widget.dart';
import 'package:test_project/pages/result/screen/result_select_widget.dart';

class ResultBaseWidget extends StatelessWidget {
  final QuestionMainModel model;
  final int index;
  const ResultBaseWidget({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
              width: AppSize.s1,
              color: context.read<ResultCubit>().getResult(model)
                  ? Colors.green
                  : Colors.red),
          borderRadius: BorderRadius.circular(AppSize.s10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
            child: Text(
              '${index + 1}. ${model.question ?? ''}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: AppSize.s10),
          switch (AnswerType.values.byName(model.type!)) {
            AnswerType.checkbox => ResultCheckboxWidget(model: model),
            AnswerType.multiple => ResultMultipleWidget(model: model),
            AnswerType.select => ResultSelectWidget(model: model),
            AnswerType.input => ResultInputScreen(model: model)
          }
        ],
      ),
    );
  }
}
