part of 'result_cubit.dart';

class ResultState extends Equatable {
  final List<QuestionMainModel> resultList;
  final int trueCount;
  const ResultState( {required this.resultList, required this.trueCount});

  factory ResultState.initial() {
    return const ResultState(resultList: [], trueCount: 0);
  }

  @override
  List<Object> get props => [resultList,trueCount];

  @override
  bool get stringify => true;

  ResultState copyWith({
    List<QuestionMainModel>? resultList,
    int? trueCount,
  }) {
    return ResultState(
      resultList: resultList ?? this.resultList,
      trueCount: trueCount ?? this.trueCount,
    );
  }
}
