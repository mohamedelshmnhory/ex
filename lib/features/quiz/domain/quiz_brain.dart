
import 'package:ex/features/quiz/models/question.dart';

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

  bool get isFinished {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

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

  final List<Question> _questionBank = [
    Question(
        answers: ['7', '9', '4', '2'],
        questionText: '5 + 2 ?',
        questionAnswer: '7'),
    Question(
        answers: ['20', '5', '8', '7'],
        questionText: '5 + 15 ?',
        questionAnswer: '20'),
    Question(
        answers: ['11', '2', '5', '8'],
        questionText: '9 + 2 ?',
        questionAnswer: '11'),
    Question(
        answers: ['22', '5', '6', '8'],
        questionText: '20 + 2 ?',
        questionAnswer: '22'),
    Question(
        answers: ['10', '2', '5', '8'],
        questionText: '5 + 5 ?',
        questionAnswer: '10'),
  ];
}
