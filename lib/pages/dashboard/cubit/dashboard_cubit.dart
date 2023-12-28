import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_enums.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial()) {
    initial();
  }
  Future<void> initial() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<QuestionMainModel> myModels =
        jsonList.map((json) => QuestionMainModel.fromJson(json)).toList();
    emit(state.copyWith(allQuestions: myModels));
  }

  void _checkAvialable() {
    int available = 0;
    for (var element in state.allQuestions) {
      final type = AnswerType.values.byName(element.type!);
      switch (type) {
        case AnswerType.checkbox:
          available = available + getCheckboxAvilable(element);
          break;
        case AnswerType.multiple:
          available = available + getMultipleAvilable(element);
          break;
        case AnswerType.select:
          available = available + getSelectAvilable(element);
          break;
        case AnswerType.input:
          available = available + getInputAvilable(element);
          break;
        default:
      }
    }
    emit(state.copyWith(avialableToResult: available == 0));
  }

  int getCheckboxAvilable(QuestionMainModel model) {
    for (var element in model.checkbox!) {
      if (element.answerUser == true) return 0;
    }
    return 1;
  }

  int getInputAvilable(QuestionMainModel model) {
    if ((model.input?.answerUser ?? '').isNotEmpty) return 0;
    return 1;
  }

  int getSelectAvilable(QuestionMainModel model) {
    for (var element in model.select!) {
      if (element.answerUser == true) return 0;
    }
    return 1;
  }

  int getMultipleAvilable(QuestionMainModel model) {
    for (var element in model.multiple!) {
      if (element.answerUser == true) return 0;
    }
    return 1;
  }

  void addQuestion(QuestionMainModel question) {
    emit(state.copyWith(allQuestions: [...state.allQuestions, question]));
    _checkAvialable();
  }

  void setValueCheckbox(int mainIndex, int checkIndex, CheckBoxModel oldValue,
      QuestionMainModel oldMainModel) {
    if (oldValue.answerUser == true) return;
    final List<QuestionMainModel> updatedOuterItems =
        List.from(state.allQuestions);
    List<CheckBoxModel> updatedInnerItems =
        List.from(updatedOuterItems[mainIndex].checkbox ?? []);

    for (var i = 0; i < updatedInnerItems.length; i++) {
      if (i == checkIndex) {
        updatedInnerItems[checkIndex] = oldValue.copyWith(answerUser: true);
      } else {
        updatedInnerItems[i] = updatedInnerItems[i].copyWith(answerUser: false);
      }
    }
    updatedOuterItems[mainIndex] =
        oldMainModel.copyWith(checkbox: updatedInnerItems);
    emit(state.copyWith(allQuestions: updatedOuterItems));
    _checkAvialable();
  }

  String? getDropDownValue(int index) {
    return state.allQuestions[index].select!
        .firstWhere((element) => element.answerUser == true,
            orElse: () => const CheckBoxModel())
        .answer;
  }

  void setInput(int mainIndex, String input, InputModel oldModel,
      QuestionMainModel oldMainModel) {
    final List<QuestionMainModel> updatedItems = List.from(state.allQuestions);
    updatedItems[mainIndex] =
        oldMainModel.copyWith(input: oldModel.copyWith(answerUser: input));
    emit(state.copyWith(allQuestions: updatedItems));
    _checkAvialable();
  }

  String? getInput(int mainIndex) {
    return state.allQuestions[mainIndex].input?.answerUser;
  }

  void setValueSelect(int mainIndex, int checkIndex, CheckBoxModel oldValue,
      QuestionMainModel oldMainModel) {
    if (oldValue.answerUser == true) return;
    final List<QuestionMainModel> updatedOuterItems =
        List.from(state.allQuestions);
    List<CheckBoxModel> updatedInnerItems =
        List.from(updatedOuterItems[mainIndex].select ?? []);

    for (var i = 0; i < updatedInnerItems.length; i++) {
      if (i == checkIndex) {
        updatedInnerItems[checkIndex] = oldValue.copyWith(answerUser: true);
      } else {
        updatedInnerItems[i] = updatedInnerItems[i].copyWith(answerUser: false);
      }
    }
    updatedOuterItems[mainIndex] =
        oldMainModel.copyWith(select: updatedInnerItems);
    emit(state.copyWith(allQuestions: updatedOuterItems));
    _checkAvialable();
  }

  void setValueMultiple(int mainIndex, int checkIndex, CheckBoxModel oldValue,
      QuestionMainModel oldMainModel) {
    final List<QuestionMainModel> updatedOuterItems =
        List.from(state.allQuestions);
    List<CheckBoxModel> updatedInnerItems =
        List.from(updatedOuterItems[mainIndex].multiple ?? []);
    bool correct = oldValue.answerUser ?? false;
    updatedInnerItems[checkIndex] = oldValue.copyWith(answerUser: !correct);
    updatedOuterItems[mainIndex] =
        oldMainModel.copyWith(multiple: updatedInnerItems);
    emit(state.copyWith(allQuestions: updatedOuterItems));
    _checkAvialable();
  }

  void setValueDefaultMultiple(int mainIndex, QuestionMainModel oldMainModel) {
    final List<QuestionMainModel> updatedOuterItems =
        List.from(state.allQuestions);
    List<CheckBoxModel> updatedInnerItems =
        List.from(updatedOuterItems[mainIndex].multiple ?? []);
    for (var i = 0; i < updatedInnerItems.length; i++) {
      updatedInnerItems[i] = updatedInnerItems[i].copyWith(answerUser: false);
    }
    updatedOuterItems[mainIndex] =
        oldMainModel.copyWith(multiple: updatedInnerItems);
    emit(state.copyWith(allQuestions: updatedOuterItems));
  }

  void setValueDefaultCheckbox(int mainIndex, QuestionMainModel oldMainModel) {
    final List<QuestionMainModel> updatedOuterItems =
        List.from(state.allQuestions);
    List<CheckBoxModel> updatedInnerItems =
        List.from(updatedOuterItems[mainIndex].checkbox ?? []);
    for (var i = 0; i < updatedInnerItems.length; i++) {
      updatedInnerItems[i] = updatedInnerItems[i].copyWith(answerUser: false);
    }
    updatedOuterItems[mainIndex] =
        oldMainModel.copyWith(checkbox: updatedInnerItems);
    emit(state.copyWith(allQuestions: updatedOuterItems));
  }

  void setValueDefaultSelect(int mainIndex, QuestionMainModel oldMainModel) {
    final List<QuestionMainModel> updatedOuterItems =
        List.from(state.allQuestions);
    List<CheckBoxModel> updatedInnerItems =
        List.from(updatedOuterItems[mainIndex].select ?? []);
    for (var i = 0; i < updatedInnerItems.length; i++) {
      updatedInnerItems[i] = updatedInnerItems[i].copyWith(answerUser: false);
    }
    updatedOuterItems[mainIndex] =
        oldMainModel.copyWith(select: updatedInnerItems);
    emit(state.copyWith(allQuestions: updatedOuterItems));
  }

  void setDefaultInput(
      int mainIndex, InputModel oldModel, QuestionMainModel oldMainModel) {
    final List<QuestionMainModel> updatedItems = List.from(state.allQuestions);
    updatedItems[mainIndex] =
        oldMainModel.copyWith(input: oldModel.copyWith(answerUser: ''));
    emit(state.copyWith(allQuestions: updatedItems));
  }

  void setDefaultValue() {
    emit(state.copyWith(sentToResult: state.allQuestions));
    for (var i = 0; i < state.allQuestions.length; i++) {
      final type = AnswerType.values.byName(state.allQuestions[i].type!);
      switch (type) {
        case AnswerType.checkbox:
          setValueDefaultCheckbox(i, state.allQuestions[i]);
          break;
        case AnswerType.multiple:
          setValueDefaultMultiple(i, state.allQuestions[i]);
          break;
        case AnswerType.select:
          setValueDefaultSelect(i, state.allQuestions[i]);
          break;
        case AnswerType.input:
          setDefaultInput(
              i, state.allQuestions[i].input!, state.allQuestions[i]);
          break;
        default:
      }
    }
    _checkAvialable();
  }
}
