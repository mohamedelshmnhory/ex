import 'package:ex/features/quiz/data/models/question.dart';

import '../data/datasource/data_source.dart';

class QuizBrain {
  int _questionNumber = 0;
  String? answer = '';

  QuizBrain() {
    _shuffle();
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String get getQuestionText {
    return _questionBank[_questionNumber].questionText;
  }

  int get getQuestionsLength {
    return _questionBank.length;
  }

  List<String> get getQuestionAnswers {
    return _questionBank[_questionNumber].answers;
  }

  String getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool get isFinished => _questionNumber >= _questionBank.length - 1;

  void reset() {
    _shuffle();
    _questionNumber = 0;
  }

  void _shuffle() {
    _questionBank.shuffle();
    for (var element in _questionBank) {
      element.answers.shuffle();
    }
  }

  final List<Question> _questionBank = Data.questionBank;
}
