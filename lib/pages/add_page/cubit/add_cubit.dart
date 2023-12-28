import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resource/app_enums.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';
import 'package:test_project/pages/dashboard/model/question_main_model/question_main_model.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddState.initial()) {
    final List<String> answerTypesList =
        AnswerType.values.map((e) => e.name).toList();
    final String dropdownValue = answerTypesList.first;
    emit(state.copyWith(
      answerTypesList: answerTypesList,
      dropdownValue: dropdownValue,
    ));
  }
  void changeDropdownValue(String value) {
    final type = AnswerType.values.byName(value);
    emit(state.copyWith(dropdownValue: value, type: type));
  }

  String isMaybeAdd() {
    switch (state.type) {
      case AnswerType.checkbox:
        if (state.checkboxList.isEmpty) {
          return 'Add answer';
        } else {
          if (isEmptyTrueCheckboxList()) {
            return 'Mark the correct answer';
          } else {
            return '';
          }
        }
      case AnswerType.multiple:
        if (state.multipleList.isEmpty) {
          return 'Add answer';
        } else {
          if (isEmptyTrueMultipleList()) {
            return 'Mark the correct answer';
          } else {
            return '';
          }
        }
      case AnswerType.select:
        if (state.selectList.isEmpty) {
          return 'Add answer';
        } else {
          if (isEmptyTrueSelectList()) {
            return 'Mark the correct answer';
          } else {
            return '';
          }
        }
      case AnswerType.input:
        if (state.inputModel.answer == null) {
          return 'Add answer';
        } else {
          return '';
        }
      default:
        return '';
    }
  }

  bool isEmptyTrueCheckboxList() {
    bool isEmptyTrue = true;
    for (var i = 0; i < state.checkboxList.length; i++) {
      if (state.checkboxList[i].correct == true) {
        isEmptyTrue = false;
      }
    }
    return isEmptyTrue;
  }

  bool isEmptyTrueMultipleList() {
    bool isEmptyTrue = true;
    for (var i = 0; i < state.multipleList.length; i++) {
      if (state.multipleList[i].correct == true) {
        isEmptyTrue = false;
      }
    }
    return isEmptyTrue;
  }

  bool isEmptyTrueSelectList() {
    bool isEmptyTrue = true;
    for (var i = 0; i < state.selectList.length; i++) {
      if (state.selectList[i].correct == true) {
        isEmptyTrue = false;
      }
    }
    return isEmptyTrue;
  }

  QuestionMainModel addQuestion(String question) {
    return QuestionMainModel(
        question: question,
        type: state.dropdownValue,
        checkbox: state.checkboxList,
        multiple: state.multipleList,
        select: state.selectList,
        input: state.inputModel);
  }

  void addCheckbox(CheckBoxModel model) {
    emit(state.copyWith(checkboxList: [...state.checkboxList, model]));
  }

  void addMultiple(CheckBoxModel model) {
    emit(state.copyWith(multipleList: [...state.multipleList, model]));
  }

  void addSelect(CheckBoxModel model) {
    emit(state.copyWith(selectList: [...state.selectList, model]));
  }

  void setInput(String input) {
    emit(state.copyWith(inputModel: InputModel(answer: input)));
  }

  void setValueCheckbox(int checkIndex, CheckBoxModel oldValue) {
    if (oldValue.correct == true) return;
    final List<CheckBoxModel> updatedItems = List.from(state.checkboxList);
    for (var i = 0; i < updatedItems.length; i++) {
      if (i == checkIndex) {
        updatedItems[checkIndex] = oldValue.copyWith(correct: true);
      } else {
        updatedItems[i] = updatedItems[i].copyWith(correct: false);
      }
    }
    emit(state.copyWith(checkboxList: updatedItems));
  }

  void removeIndexCheckbox(int index) {
    List<CheckBoxModel> updatedList = List.from(state.checkboxList);
    updatedList.removeAt(index);
    emit(state.copyWith(checkboxList: updatedList));
  }
  void removeIndexMultiple(int index) {
    List<CheckBoxModel> updatedList = List.from(state.multipleList);
    updatedList.removeAt(index);
    emit(state.copyWith(multipleList: updatedList));
  }
  void removeIndexSelect(int index) {
    List<CheckBoxModel> updatedList = List.from(state.selectList);
    updatedList.removeAt(index);
    emit(state.copyWith(selectList: updatedList));
  }

  void setValueSelect(int selectIndex, CheckBoxModel oldValue) {
    if (oldValue.correct == true) return;
    final List<CheckBoxModel> updatedItems = List.from(state.selectList);
    for (var i = 0; i < updatedItems.length; i++) {
      if (i == selectIndex) {
        updatedItems[selectIndex] = oldValue.copyWith(correct: true);
      } else {
        updatedItems[i] = updatedItems[i].copyWith(correct: false);
      }
    }
    emit(state.copyWith(selectList: updatedItems));
  }

  void setValueMultiple(int multipleIndex, CheckBoxModel oldValue) {
    final List<CheckBoxModel> updatedItems = List.from(state.multipleList);
    bool correct = oldValue.correct!;
    updatedItems[multipleIndex] = oldValue.copyWith(correct: !correct);
    emit(state.copyWith(multipleList: updatedItems));
  }
}
