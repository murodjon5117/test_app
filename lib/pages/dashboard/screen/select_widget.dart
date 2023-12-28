import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

class SelectWidget extends StatefulWidget {
  final QuestionMainModel model;
  final int rootIndex;
  const SelectWidget({super.key, required this.model, required this.rootIndex});

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  String? dropdownValue;
  List<String> selectList = [];
  @override
  void initState() {
    for (var element in widget.model.select!) {
      selectList.add(element.answer!);
    }
    dropdownValue =
        context.read<DashboardCubit>().getDropDownValue(widget.rootIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              border: Border.all(color: AppColors.color2879F2, width: 0.5),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s10, vertical: AppSize.s5),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Select'),
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.color2879F2,
              ),
              elevation: 30,
              style: style.bodyLarge,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(AppSize.s10),
              onChanged: (String? value) {
                CheckBoxModel selectModel = widget.model.select!.singleWhere(
                    (element) => element.answer == value!,
                    orElse: () => const CheckBoxModel());
                int index = state.allQuestions[widget.rootIndex].select!
                    .indexWhere((element) => element == selectModel);
                context.read<DashboardCubit>().setValueSelect(widget.rootIndex,
                    index, selectModel, state.allQuestions[widget.rootIndex]);
                setState(() {
                  dropdownValue = context
                      .read<DashboardCubit>()
                      .getDropDownValue(widget.rootIndex);
                });
              },
              dropdownColor: AppColors.colorDropDown,
              items: selectList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
