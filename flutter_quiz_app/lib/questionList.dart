import './Question.dart';

class questionList {
  int _questionIndex = 0;

  List<Question> _questions = [
    Question("Titanic gelmiş geçmiş en büyük gemidir", false),
    Question("Dünyadaki tavuk sayısı insan sayısından fazladır", true),
    Question("Kelebeklerin ömrü bir gündür", false),
    Question("Dünya düzdür", false),
    Question("Kaju fıstığı aslında bir meyvenin sapıdır", true),
    Question("Fatih Sultan Mehmet hiç patates yememiştir", true)
  ];
  String getQuestion() {
    return _questions[_questionIndex].question;
  }

  bool getQuestionAnswer() {
    return _questions[_questionIndex].answer;
  }

  void increaseQuestionIndex() {
    if (_questionIndex < _questions.length - 1) {
      _questionIndex++;
    }
  }

  bool quizIsFinished() {
    if (_questionIndex + 1 >= _questions.length) {
      return true;
    } else {
      return false;
    }
  }

  void rebootIndex() {
    _questionIndex = 0;
  }
}
