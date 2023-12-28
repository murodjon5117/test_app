// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionMainModel _$QuestionMainModelFromJson(Map<String, dynamic> json) =>
    QuestionMainModel(
      type: json['type'] as String?,
      question: json['question'] as String?,
      checkbox: (json['checkbox'] as List<dynamic>?)
          ?.map((e) => CheckBoxModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      multiple: (json['multiple'] as List<dynamic>?)
          ?.map((e) => CheckBoxModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      select: (json['select'] as List<dynamic>?)
          ?.map((e) => CheckBoxModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      input: json['input'] == null
          ? null
          : InputModel.fromJson(json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionMainModelToJson(QuestionMainModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'question': instance.question,
      'checkbox': instance.checkbox,
      'multiple': instance.multiple,
      'select': instance.select,
      'input': instance.input,
    };
