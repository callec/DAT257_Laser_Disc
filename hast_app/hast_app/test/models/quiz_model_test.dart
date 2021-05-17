import 'package:flutter_test/flutter_test.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/models/quiz_model.dart';

void main() {
  group('QuizModel', ()
  {
    TestWidgetsFlutterBinding.ensureInitialized();
    late QuizModel _q;

    setUp(() {
      _q = new QuizModel();
    });

    test('QuizModel shall have a QuizContent after startup', () {
      // the question variable is initialised to [], becomes a list of questions
      // when the quiz is loaded.
      expect(_q.questions.length > 0, true);
    });

    test('`setQuestion` sets the quiz to the specified number', () {
      var _oldNumber = _q.currentNumber;
      _q.setQuestion(2);

      expect(_oldNumber, 0);
      expect(_q.currentNumber, 2);
    });

    test('`currentQuestion` gets a question', () {
      expect(_q.currentQuestion.runtimeType, QuestionContent);
    });

    test('`nextQuestion()` moves the current number forward 1 step', () {
      var _oldNumber = _q.currentNumber;
      _q.nextQuestion();

      expect(_oldNumber < _q.currentNumber, true);
    });

    test('`prevQuestion()` moves the current number backward 1 step', () {
      var _oldNumber = _q.currentNumber;
      _q.prevQuestion();

      // test 0, it shouldn't be possible to go below it.
      expect(_oldNumber, 0);
      _q.prevQuestion();
      expect(_oldNumber, _q.currentNumber);

      // test n+1 -> n
      _q.nextQuestion();
      _oldNumber = _q.currentNumber;
      _q.prevQuestion();
      expect(_oldNumber > _q.currentNumber, true);
    });

    test('`setSubAlternative` sets subAlternative', () {
      _q.setSubAlternative(1);
      expect(_q.currentQuestion.chosenSubAlternative, 1);

      // make sure selection of the same resets
      _q.setSubAlternative(1);
      expect(_q.currentQuestion.chosenSubAlternative, -1);
    });

    /*test('`reset()` resets the progress', () async {
      int _oldNumber;

      _q.nextQuestion();
      _oldNumber = _q.currentNumber;

      _q._reset();
      // android studio tells me this await is unnecessary, however it emulates
      // how the app is run and the test fails without it.
      await _q.loading == false;
      expect(_q.currentNumber != _oldNumber, true);
    });*/
  });
}