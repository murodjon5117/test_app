import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_enums.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/cubit/add_cubit.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/add_page/screens/checkbox_screen.dart';
import 'package:test_project/pages/add_page/screens/input_screen.dart';
import 'package:test_project/pages/add_page/screens/multiple_screen.dart';
import 'package:test_project/pages/add_page/screens/select_screen.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(),
      child: const AddPageContent(),
    );
  }
}

class AddPageContent extends StatefulWidget {
  const AddPageContent({super.key});

  @override
  State<AddPageContent> createState() => _AddPageContentState();
}

class _AddPageContentState extends State<AddPageContent> {
  final questionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  void _submit(AddState state) {
    setState(() => submitted = true);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String dialogText = context.read<AddCubit>().isMaybeAdd();
      if (dialogText.isEmpty) {
        QuestionMainModel model =
            context.read<AddCubit>().addQuestion(questionController.text);
        context.read<DashboardCubit>().addQuestion(model);
        context.pop();
      } else {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Error',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.black),
              ),
              content: Text(
                dialogText,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void showDialogForCheckbox(BuildContext context, AnswerType type) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final style = Theme.of(context).textTheme;

    bool submitted = false;
    void submit() {
      setState(() => submitted = true);
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        switch (type) {
          case AnswerType.checkbox:
            context.read<AddCubit>().addCheckbox(
                CheckBoxModel(answer: controller.text, correct: false));
            break;
          case AnswerType.multiple:
            context.read<AddCubit>().addMultiple(
                CheckBoxModel(answer: controller.text, correct: false));
            break;
          case AnswerType.select:
            context.read<AddCubit>().addSelect(
                CheckBoxModel(answer: controller.text, correct: false));
            break;
          case AnswerType.input:
            context.read<AddCubit>().setInput(controller.text);
            break;
          default:
            () {};
        }
        context.pop();
      }
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10)),
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s16),
              child: Form(
                key: formKey,
                autovalidateMode: submitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'The answer is incomplete';
                        }
                        return null;
                      },
                      minLines: 1,
                      maxLines: 2,
                      style: style.bodyLarge,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      cursorColor: AppColors.color2879F2,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Text of answer',
                        hintStyle: style.bodyLarge
                            ?.copyWith(color: Colors.black.withOpacity(0.5)),
                        fillColor: AppColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          borderSide: const BorderSide(
                              width: 0.5,
                              color: AppColors.circleDotColor), //<-- SEE HERE
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          borderSide: const BorderSide(
                              width: 0.5,
                              color: AppColors.color2879F2), //<-- SEE HERE
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    ElevatedButton(
                      onPressed: () {
                        submit();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.white,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width, AppSize.s50),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                        ),
                        elevation: AppSize.s0,
                      ),
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return BlocBuilder<AddCubit, AddState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add question'),
            actions: [
              IconButton(
                  onPressed: () => _submit(state),
                  icon: const Icon(Icons.done),
                  color: AppColors.color2879F2),
              const SizedBox(width: AppSize.s10)
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: const EdgeInsets.all(AppMargin.m16),
                padding: const EdgeInsets.all(AppSize.s16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                        width: AppSize.s1, color: AppColors.colorD9D9D9),
                    borderRadius: BorderRadius.circular(AppSize.s10)),
                child: Form(
                  key: formKey,
                  autovalidateMode: submitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: questionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The question is incomplete';
                          }
                          return null;
                        },
                        minLines: 1,
                        maxLines: 2,
                        style: style.bodyLarge,
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        cursorColor: AppColors.color2879F2,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Text of question',
                          hintStyle: style.bodyLarge
                              ?.copyWith(color: Colors.black.withOpacity(0.5)),
                          fillColor: AppColors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                            borderSide: const BorderSide(
                                width: 0.5,
                                color: AppColors.circleDotColor), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                            borderSide: const BorderSide(
                                width: 0.5,
                                color: AppColors.color2879F2), //<-- SEE HERE
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize
                                    .s10), // Set your desired border radius here
                                border: Border.all(
                                    color: AppColors.color2879F2, width: 0.5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s10,
                                  vertical: AppSize.s5),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: state.dropdownValue,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.color2879F2,
                                ),
                                elevation: 30,
                                style: style.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                underline: const SizedBox(),
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10),
                                onChanged: (String? value) {
                                  setState(() {
                                    context
                                        .read<AddCubit>()
                                        .changeDropdownValue(value!);
                                  });
                                },
                                dropdownColor: AppColors.colorDropDown,
                                items: state.answerTypesList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s10),
                          IconButton(
                              focusColor: AppColors.colorDropDown,
                              color: AppColors.color2879F2,
                              onPressed: () {
                                showDialogForCheckbox(context, state.type);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              switch (state.type) {
                AnswerType.checkbox =>
                  CheckboxScreen(checkboxList: state.checkboxList),
                AnswerType.multiple =>
                  MultipleScreen(multipleList: state.multipleList),
                AnswerType.input => InputScreen(inputModel: state.inputModel),
                AnswerType.select => SelectScreen(selectList: state.selectList),
              }
            ],
          ),
        );
      },
    );
  }
}
