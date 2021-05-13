import 'package:hast_app/models/quiz_model.dart';

/// This class is responsible for calculating the total score after a Quiz
/// and displaying the appropriate conclusion

class ResultModel{

  late QuizModel quizModel;

  bool get finished => quizModel.finished;

  //TODO DO NOT DISPLAY RESULT IF ALL QUESTION HAVEN'T BEEN ANSWERED
  int get score {
    var questions = quizModel.questions;
    int totalScore = 0;

    // To calculate the points accordingly we first multiply the alternative with 3
    // (to divide into 0, 3, 6 or 9.) Then we use the sub alternative to get a
    // score between (1 to 3), resulting in we get a unique result for each question (1 to 12)
    for(var question in questions){
      totalScore += (question.chosenSubAlternative + 1) + (question.chosenAlternative * 3);
    }
    return totalScore;
  }

  /// Divide the total score into 4 different intervals
  /// Get the conclusion text based on which interval the score lands
  String get text {
    var resultTextList = quizModel.resultList;
    int s = this.score;
    int index;

    int interval = ((quizModel.numberOfQuestions * 12) / 4) as int;

    if (s <= interval) {
      index = 0;
    } else if (s <= 2*interval) {
      index = 1;
    } else if (s <= 3*interval) {
      index = 2;
    } else {
      index = 3;
    }
    return resultTextList[index];
  }
}