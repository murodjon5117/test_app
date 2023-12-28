import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_box_model.g.dart';

@JsonSerializable()
class CheckBoxModel extends Equatable {
  final String? answer;
  final bool? correct;
  @JsonKey(name: 'answer_user')
  final bool? answerUser;

  const CheckBoxModel({this.answer, this.correct, this.answerUser});

  factory CheckBoxModel.fromJson(Map<String, dynamic> json) {
    return _$CheckBoxModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckBoxModelToJson(this);

  CheckBoxModel copyWith({
    String? answer,
    bool? correct,
    bool? answerUser,
  }) {
    return CheckBoxModel(
      answer: answer ?? this.answer,
      correct: correct ?? this.correct,
      answerUser: answerUser ?? this.answerUser,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [answer, correct, answerUser];
}
