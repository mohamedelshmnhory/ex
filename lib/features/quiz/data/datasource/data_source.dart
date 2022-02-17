import 'package:ex/features/quiz/data/models/question.dart';

class Data {
  static final List<Question> questionBank = [
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
