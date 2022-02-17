import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../domain/quiz_brain.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  String answer = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) => showEnterNameDialog);
  }

  @override
  Widget build(BuildContext context) {
    return userName.isEmpty
        ? const SizedBox()
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                shrinkWrap: true,
                itemCount: quizBrain.getQuestionAnswers.length,
                itemBuilder: (c, i) {
                  List<String> answers = quizBrain.getQuestionAnswers;
                  return SizedBox(
                    height: 35,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      horizontalTitleGap: 5,
                      title: Text(answers[i]),
                      leading: Radio<String>(
                        value: answers[i],
                        groupValue: answer,
                        onChanged: (String? value) {
                          setState(() {
                            answer = value!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              DialogButton(
                onPressed: () {
                  if (answer.isNotEmpty) {
                    checkAnswer(answer);
                    answer = '';
                  }
                },
                child: Text(
                  quizBrain.isFinished ? 'Done' : "next",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              SafeArea(
                child: Row(
                  children: scoreKeeper,
                ),
              )
            ],
          );
  }

  int scoreCount = 0;
  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = quizBrain.getCorrectAnswer();
    if (userPickedAnswer == correctAnswer) {
      scoreCount++;
      scoreKeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      scoreKeeper.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
    setState(() {
      if (quizBrain.isFinished == true) {
        showFinishDialog(userName).then((value) {
          quizBrain.reset();
          scoreKeeper = [];
          scoreCount = 0;
          showEnterNameDialog;
        });
        userName = '';
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  Future<bool?> showFinishDialog(name) {
    return Alert(
      context: context,
      title: 'Finished!\nWell done, $name',
      desc: 'Your Score is $scoreCount/${quizBrain.getQuestionsLength}',
    ).show();
  }

  Future<bool?> get showEnterNameDialog {
    return Alert(
        context: context,
        style:
            const AlertStyle(isCloseButton: false, isOverlayTapDismiss: false),
        content: TextField(
          decoration: const InputDecoration(
            icon: Icon(Icons.account_circle),
            labelText: 'Student name',
          ),
          onChanged: (v) {
            userName = v;
          },
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (userName.isNotEmpty) {
                setState(() {
                  Navigator.pop(context);
                });
              }
            },
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
