import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

class InputWidget extends StatefulWidget {
  final int rootIndex;
  final QuestionMainModel model;
  const InputWidget({super.key, required this.model, required this.rootIndex});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final answerController = TextEditingController();

  @override
  void initState() {
    answerController.text =
        context.read<DashboardCubit>().getInput(widget.rootIndex) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
      child: TextFormField(
        controller: answerController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'The answer is incomplete';
          }
          return null;
        },
        onChanged: (value) {
          context.read<DashboardCubit>().setInput(widget.rootIndex, value,
              widget.model.input ?? const InputModel(), widget.model);
        },
        style: style.bodyLarge,
        autofocus: false,
        keyboardType: TextInputType.text,
        cursorColor: AppColors.color2879F2,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Answer of question',
          hintStyle:
              style.bodyLarge?.copyWith(color: Colors.black.withOpacity(0.5)),
          fillColor: AppColors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: const BorderSide(
                width: 0.5, color: AppColors.color2879F2), //<-- SEE HERE
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: const BorderSide(
                width: 0.5, color: AppColors.color2879F2), //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}
