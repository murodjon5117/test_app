import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'input_model.g.dart';

@JsonSerializable()
class InputModel extends Equatable {
  final String? answer;
  @JsonKey(name: 'answer_user')
  final String? answerUser;

  const InputModel({this.answer, this.answerUser});

  factory InputModel.fromJson(Map<String, dynamic> json) {
    return _$InputModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InputModelToJson(this);

  InputModel copyWith({
    String? answer,
    String? answerUser,
  }) {
    return InputModel(
      answer: answer ?? this.answer,
      answerUser: answerUser ?? this.answerUser,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [answer, answerUser];
}
