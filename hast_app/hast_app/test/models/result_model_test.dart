import 'package:flutter_test/flutter_test.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'dart:math';

void main() {
  group('ResultModel', ()
  {
    TestWidgetsFlutterBinding.ensureInitialized();
    late ResultModel _r;
    late ResultModel _r2;
    final _random = Random();

    setUp(() {
      _r = new ResultModel();
      _r2 = new ResultModel();
      _r.quizModel = new QuizModel();
      _r2.quizModel = new QuizModel();
    });

    test('`score` gives the correct score', () {
      // the algorithm to calculate score is as follows:
      //   (subAlt + 1) + (alt * 3)
      // this is done to get unique points for each pair of alt + subAlt.

      int _score = 0;
      // answer all questions
      for (int i = 0; i < _r.quizModel.numberOfQuestions; ++i) {
        var _alt = _random.nextInt(3);
        var _sub = _random.nextInt(3);

        _r.quizModel.setAlternative(_alt);
        _r.quizModel.setSubAlternative(_sub);

        _score += (1+_sub) + (_alt*3);

        if (i == _r.quizModel.numberOfQuestions-1) break;
        _r.quizModel.nextQuestion();
      }

      expect(_r.score, _score);
    });

    test('`text` gives different text depending on score', () {
      // TODO don't like initialising two ResultModels, separate setup? how?
      // first ResultModel
      for (int i = 0; i < _r.quizModel.numberOfQuestions; ++i) {
        _r.quizModel.setAlternative(0);
        _r.quizModel.setSubAlternative(0);

        if (i == _r.quizModel.numberOfQuestions-1) break;
        _r.quizModel.nextQuestion();
      }

      // second ResultModel
      _r2.quizModel.reset();
      for (int i = 0; i < _r2.quizModel.numberOfQuestions; ++i) {
        _r2.quizModel.setAlternative(2);
        _r2.quizModel.setSubAlternative(2);

        if (i == _r2.quizModel.numberOfQuestions-1) break;
        _r2.quizModel.nextQuestion();
      }

      print(_r.text);
      print(_r2.text);
      expect(_r.text != _r2.text, true);
    });
  });
}