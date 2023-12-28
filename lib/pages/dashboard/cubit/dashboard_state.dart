part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final List<QuestionMainModel> allQuestions;
  final List<QuestionMainModel> sentToResult;
  final bool avialableToResult;
  const DashboardState(
      {required this.allQuestions,
      required this.sentToResult,
      required this.avialableToResult});

  factory DashboardState.initial() {
    return const DashboardState(
        allQuestions: [], sentToResult: [], avialableToResult: false);
  }
  @override
  List<Object> get props => [allQuestions, sentToResult, avialableToResult];

  @override
  bool get stringify => true;

  DashboardState copyWith({
    List<QuestionMainModel>? allQuestions,
    List<QuestionMainModel>? sentToResult,
    bool? avialableToResult,
  }) {
    return DashboardState(
      allQuestions: allQuestions ?? this.allQuestions,
      sentToResult: sentToResult ?? this.sentToResult,
      avialableToResult: avialableToResult ?? this.avialableToResult,
    );
  }
}
