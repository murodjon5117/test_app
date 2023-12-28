import 'package:flutter/material.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';

class InputScreen extends StatelessWidget {
  final InputModel inputModel;
  const InputScreen({super.key, required this.inputModel});

  @override
  Widget build(BuildContext context) {
    return (inputModel.answer == null)
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
            decoration: BoxDecoration(
                color: AppColors.white,
                border:
                    Border.all(width: AppSize.s1, color: AppColors.colorD9D9D9),
                borderRadius: BorderRadius.circular(AppSize.s10)),
            child: Row(children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.question_answer_rounded,
                    color: AppColors.color2879F2,
                  )),
              Expanded(child: Text(inputModel.answer ?? ''))
            ]),
          );
  }
}
