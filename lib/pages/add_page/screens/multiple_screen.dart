import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_values.dart';
import 'package:test_project/pages/add_page/cubit/add_cubit.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';

class MultipleScreen extends StatelessWidget {
  final List<CheckBoxModel> multipleList;
  const MultipleScreen({super.key, required this.multipleList});

  @override
  Widget build(BuildContext context) {
    return multipleList.isEmpty
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
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context
                              .read<AddCubit>()
                              .setValueMultiple(index, multipleList[index]);
                        },
                        icon: Icon(
                          (multipleList[index].correct ?? false)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppColors.color2879F2,
                        )),
                    Expanded(child: Text(multipleList[index].answer ?? '')),
                    IconButton(
                        padding: const EdgeInsets.all(AppSize.s8),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context.read<AddCubit>().removeIndexMultiple(index);
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
                itemCount: multipleList.length),
          );
  }
}
