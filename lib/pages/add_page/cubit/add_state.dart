part of 'add_cubit.dart';

class AddState extends Equatable {
  final List<CheckBoxModel> checkboxList;
  final List<CheckBoxModel> multipleList;
  final List<CheckBoxModel> selectList;
  final InputModel inputModel;
  final List<String> answerTypesList;
  final AnswerType type;
  final String dropdownValue;
  const AddState(
      {required this.checkboxList,
      required this.multipleList,
      required this.selectList,
      required this.inputModel,
      required this.answerTypesList,
      required this.dropdownValue,
      required this.type});

  factory AddState.initial() {
    return const AddState(
        checkboxList: [],
        multipleList: [],
        selectList: [],
        inputModel: InputModel(),
        answerTypesList: [],
        dropdownValue: '',
        type: AnswerType.checkbox);
  }

  @override
  List<Object> get props => [
        checkboxList,
        multipleList,
        selectList,
        inputModel,
        answerTypesList,
        dropdownValue,
        type
      ];

  @override
  bool get stringify => true;

  AddState copyWith({
    List<CheckBoxModel>? checkboxList,
    List<CheckBoxModel>? multipleList,
    List<CheckBoxModel>? selectList,
    InputModel? inputModel,
    List<String>? answerTypesList,
    String? dropdownValue,
    AnswerType? type,
  }) {
    return AddState(
      checkboxList: checkboxList ?? this.checkboxList,
      multipleList: multipleList ?? this.multipleList,
      selectList: selectList ?? this.selectList,
      inputModel: inputModel ?? this.inputModel,
      answerTypesList: answerTypesList ?? this.answerTypesList,
      dropdownValue: dropdownValue ?? this.dropdownValue,
      type: type ?? this.type,
    );
  }
}
