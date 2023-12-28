// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_box_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBoxModel _$CheckBoxModelFromJson(Map<String, dynamic> json) =>
    CheckBoxModel(
      answer: json['answer'] as String?,
      correct: json['correct'] as bool?,
      answerUser: json['answer_user'] as bool?,
    );

Map<String, dynamic> _$CheckBoxModelToJson(CheckBoxModel instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'correct': instance.correct,
      'answer_user': instance.answerUser,
    };
