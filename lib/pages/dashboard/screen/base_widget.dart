import 'package:flutter/material.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_enums.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';
import 'package:test_project/pages/dashboard/screen/checkbox_widget.dart';
import 'package:test_project/pages/dashboard/screen/input_widget.dart';
import 'package:test_project/pages/dashboard/screen/multiple_widget.dart';
import 'package:test_project/pages/dashboard/screen/select_widget.dart';

class BaseWidget extends StatelessWidget {
  final QuestionMainModel model;
  final int index;
  const BaseWidget({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(width: AppSize.s1, color: AppColors.colorD9D9D9),
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
            AnswerType.checkbox =>
              CheckboxWidget(rootIndex: index, model: model),
            AnswerType.multiple =>
              MultipleWidget(model: model, rootIndex: index),
            AnswerType.select => SelectWidget(model: model, rootIndex: index),
            AnswerType.input => InputWidget(model: model, rootIndex: index)
          }
        ],
      ),
    );
  }
}
