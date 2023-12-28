import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';
import 'package:test_project/pages/result/cubit/result_cubit.dart';

class ResultMultipleWidget extends StatelessWidget {
  final QuestionMainModel model;
  const ResultMultipleWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Color color =
              context.read<ResultCubit>().checkboxColor(model.multiple![index]);

          return Row(children: [
            IconButton(
                padding: const EdgeInsets.all(AppSize.s8),
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: Icon(
                  color == Colors.blue
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: color,
                )),
            // const SizedBox(width: AppSize.s10),
            Expanded(child: Text(model.multiple![index].answer ?? ''))
          ]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox();
        },
        itemCount: model.multiple!.length);
  }
}
