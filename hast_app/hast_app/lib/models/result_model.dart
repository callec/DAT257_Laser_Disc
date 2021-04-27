

import 'package:flutter/cupertino.dart';
import 'package:hast_app/models/quiz_model.dart';

class ResultModel{

  QuizModel quizModel;



  int get score {
    var questions = quizModel.questions;
    int totalScore = 0;
    for(var question in questions){
      totalScore += question.chosenSubAlternative;
    }
    return totalScore;
  }
}