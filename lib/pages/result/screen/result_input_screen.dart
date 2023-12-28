import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';
import 'package:test_project/pages/result/cubit/result_cubit.dart';

class ResultInputScreen extends StatelessWidget {
  final QuestionMainModel model;
  const ResultInputScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Color color = context
        .read<ResultCubit>()
        .inputColor(model.input ?? const InputModel());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: const Icon(
                Icons.question_answer_rounded,
                color: Colors.green,
              )),
          Expanded(child: Text(model.input?.answer ?? ''))
        ]),
        color == Colors.red
            ? Row(children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: Icon(
                      Icons.question_answer_rounded,
                      color: color,
                    )),
                Expanded(child: Text(model.input?.answerUser ?? ''))
              ])
            : const SizedBox(),
      ],
    );
  }
}
