import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_project/pages/add_page/model/check_box_model/check_box_model.dart';
import 'package:test_project/pages/add_page/model/input_model/input_model.dart';

part 'question_main_model.g.dart';

@JsonSerializable()
class QuestionMainModel extends Equatable {
  final String? type;
  final String? question;
  final List<CheckBoxModel>? checkbox;
  final List<CheckBoxModel>? multiple;
  final List<CheckBoxModel>? select;
  final InputModel? input;

  const QuestionMainModel({
    this.type,
    this.question,
    this.checkbox,
    this.multiple,
    this.select,
    this.input,
  });

  factory QuestionMainModel.fromJson(Map<String, dynamic> json) {
    return _$QuestionMainModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuestionMainModelToJson(this);

  QuestionMainModel copyWith({
    String? type,
    String? question,
    List<CheckBoxModel>? checkbox,
    List<CheckBoxModel>? multiple,
    List<CheckBoxModel>? select,
    InputModel? input,
  }) {
    return QuestionMainModel(
      type: type ?? this.type,
      question: question ?? this.question,
      checkbox: checkbox ?? this.checkbox,
      multiple: multiple ?? this.multiple,
      select: select ?? this.select,
      input: input ?? this.input,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      type,
      question,
      checkbox,
      multiple,
      select,
      input,
    ];
  }
}
