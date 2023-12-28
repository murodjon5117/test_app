import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_enums.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultState.initial());

  void addAll(List<QuestionMainModel> list) {
    emit(state.copyWith(resultList: list));
    getResultCount();
  }

  Color checkboxColor(CheckBoxModel model) {
    if (model.answerUser == true && model.correct == true) {
      return Colors.green;
    } else if (model.answerUser == true && model.correct == false) {
      return Colors.red;
    } else if (model.answerUser == false && model.correct == true) {
      return Colors.green;
    } else if (model.answerUser == false && model.correct == false) {
      return Colors.blue;
    } else {
      return Colors.blue;
    }
  }

  Color inputColor(InputModel model) {
    if (model.answerUser == model.answer) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  bool getResult(QuestionMainModel model) {
    final type = AnswerType.values.byName(model.type!);
    switch (type) {
      case AnswerType.checkbox:
        return checkboxResult(model);
      case AnswerType.multiple:
        return multipleResult(model);
      case AnswerType.select:
        return selectResult(model);
      case AnswerType.input:
        return inputResult(model);
      default:
        return false;
    }
  }

  void getResultCount() {
    int count = 0;
    for (var element in state.resultList) {
      if (getResult(element)) {
        count = count + 1;
      }
    }
    emit(state.copyWith(trueCount: count));
  }

  bool checkboxResult(QuestionMainModel model) {
    bool result = false;
    for (var element in model.checkbox!) {
      if ((element.answerUser == true) && (element.correct == true)) {
        return true;
      }
    }
    return result;
  }

  bool inputResult(QuestionMainModel model) {
    bool result = false;
    if (model.input?.answer == model.input?.answerUser) {
      result = true;
    }
    return result;
  }

  bool multipleResult(QuestionMainModel model) {
    bool result = true;
    for (var element in model.multiple!) {
      if (((element.answerUser == true) && (element.correct == false)) ||
          (element.answerUser == false) && (element.correct == true)) {
        return false;
      }
    }
    return result;
  }

  bool selectResult(QuestionMainModel model) {
    bool result = false;
    for (var element in model.select!) {
      if ((element.answerUser == true) && (element.correct == true)) {
        return true;
      }
    }
    return result;
  }
}
