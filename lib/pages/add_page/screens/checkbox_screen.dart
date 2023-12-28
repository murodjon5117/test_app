import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/cubit/add_cubit.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';

class CheckboxScreen extends StatefulWidget {
  final List<CheckBoxModel> checkboxList;
  const CheckboxScreen({super.key, required this.checkboxList});

  @override
  State<CheckboxScreen> createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<CheckboxScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.checkboxList.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
            decoration: BoxDecoration(
                color: AppColors.white,
                border:
                    Border.all(width: AppSize.s1, color: AppColors.colorD9D9D9),
                borderRadius: BorderRadius.circular(AppSize.s10)),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Row(children: [
                    IconButton(
                        padding: const EdgeInsets.all(AppSize.s8),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context.read<AddCubit>().setValueCheckbox(
                              index, widget.checkboxList[index]);
                        },
                        icon: Icon(
                          (widget.checkboxList[index].correct ?? false)
                              ? Icons.radio_button_checked_outlined
                              : Icons.radio_button_off_outlined,
                          color: AppColors.color2879F2,
                        )),
                    Expanded(
                        child: Text(widget.checkboxList[index].answer ?? '')),
                    IconButton(
                        padding: const EdgeInsets.all(AppSize.s8),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context.read<AddCubit>().removeIndexCheckbox(index);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: AppSize.s24,
                          color: AppColors.error,
                        )),
                  ]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                itemCount: widget.checkboxList.length),
          );
  }
}
