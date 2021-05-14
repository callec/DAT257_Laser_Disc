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
    late QuizModel _q1;
    late QuizModel _q2;
    final _random = Random();

    setUp(() {
      _r = new ResultModel();
      _r2 = new ResultModel();
      _q1 = new QuizModel();
      _q2 = new QuizModel();
      
      _r.setModel(_q1);
      _r2.setModel(_q2);
    });

    test('`score` gives the correct score', () {
      // the algorithm to calculate score is as follows:
      //   (subAlt + 1) + (alt * 3)
      // this is done to get unique points for each pair of alt + subAlt.

      int _score = 0;
      // answer all questions
      for (int i = 0; i < _q1.numberOfQuestions; ++i) {
        var _alt = _random.nextInt(3);
        var _sub = _random.nextInt(3);

        _q1.setAlternative(_alt);
        _q1.setSubAlternative(_sub);

        _score += (1+_sub) + (_alt*3);

        if (i == _q1.numberOfQuestions-1) break;
        _q1.nextQuestion();
      }

      expect(_r.score, _score);
    });

    /*test('`text` gives different text depending on score', () {
      // TODO don't like initialising two ResultModels, separate setup? how?
      // first ResultModel
      for (int i = 0; i < _q1.numberOfQuestions; ++i) {
        _q1.setAlternative(0);
        _q1.setSubAlternative(0);

        if (i == _q1.numberOfQuestions-1) break;
        _q1.nextQuestion();
      }

      // second ResultModel
      _q2.reset();
      for (int i = 0; i < _q2.numberOfQuestions; ++i) {
        _q2.setAlternative(2);
        _q2.setSubAlternative(2);

        if (i == _q2.numberOfQuestions-1) break;
        _q2.nextQuestion();
      }

      expect(_r.text != _r2.text, true);
    });*/
  });
}