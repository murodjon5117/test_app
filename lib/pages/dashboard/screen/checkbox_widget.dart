import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

class CheckboxWidget extends StatelessWidget {
  final QuestionMainModel model;
  final int rootIndex;
  const CheckboxWidget(
      {super.key, required this.model, required this.rootIndex});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Row(children: [
            IconButton(
                padding: const EdgeInsets.all(AppSize.s8),
                constraints: const BoxConstraints(),
                onPressed: () {
                  context.read<DashboardCubit>().setValueCheckbox(
                      rootIndex,
                      index,
                      model.checkbox?[index] ?? const CheckBoxModel(),
                      model);
                },
                icon: Icon(
                  (model.checkbox![index].answerUser ?? false)
                      ? Icons.radio_button_checked_outlined
                      : Icons.radio_button_off_outlined,
                  color: AppColors.color2879F2,
                )),
            // const SizedBox(width: AppSize.s10),
            Expanded(child: Text(model.checkbox![index].answer ?? ''))
          ]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox();
        },
        itemCount: model.checkbox!.length);
  }
}
