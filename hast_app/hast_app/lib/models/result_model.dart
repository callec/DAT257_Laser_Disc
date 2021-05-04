import 'package:hast_app/models/quiz_model.dart';

class ResultModel{

  late QuizModel quizModel;

  int get score {
    var questions = quizModel.questions;
    int totalScore = 0;
    for(var question in questions){
      totalScore += (question.chosenSubAlternative + 1) + (question.chosenAlternative * 3);
    }
    return totalScore;
  }

  String get text {
    var resultTextList = quizModel.resultList;
    int s = this.score;
    int index;

    if (s <= 30) {
      index = 0;
    } else if (s <= 60) {
      index = 1;
    } else if (s <= 90) {
      index = 2;
    } else {
      index = 3;
    }
    return resultTextList[index];
  }
}