import 'package:flutter/material.dart';
import './questionList.dart';

const Icon trueIcon = Icon(Icons.mood, color: Colors.green);
const Icon falseIcon = Icon(Icons.mood_bad, color: Colors.red);

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: QuestionPage(),
          ),
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Widget> moods = [];
  questionList list_of_questions = questionList();

  void buttonFunction(bool flag) {
    if (list_of_questions.quizIsFinished() == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("CONGRATULATIONS!!!"),
              actions: [
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        moods = [];
                        list_of_questions.rebootIndex();
                      });
                    },
                    child: Text("AGAIN"))
              ],
            );
          });
    } else {
      bool questionAnswer = list_of_questions.getQuestionAnswer();
      setState(() {
        if (questionAnswer == flag) {
          moods.add(trueIcon);
        } else {
          moods.add(falseIcon);
        }
        list_of_questions.increaseQuestionIndex();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20.0),
                  color: Color(0xffFFFFFA),
                ),
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text(
                    list_of_questions.getQuestion(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
        Wrap(
          children: moods,
          spacing: 5,
          runSpacing: 2,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: RaisedButton(
                      onPressed: () {
                        buttonFunction(false);
                      },
                      padding: EdgeInsets.all(12),
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Icon(Icons.thumb_down, size: 30.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: RaisedButton(
                      padding: EdgeInsets.all(12),
                      textColor: Colors.white,
                      color: Colors.green[400],
                      child: Icon(Icons.thumb_up, size: 30.0),
                      onPressed: () {
                        buttonFunction(true);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
