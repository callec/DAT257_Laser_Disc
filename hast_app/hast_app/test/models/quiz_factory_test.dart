import 'package:flutter_test/flutter_test.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/models/quiz_factory.dart';

void main() {
  group('QuizFactory', () {
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('Make sure that the file loads', () async {
      // if `getJson()` runs successfully consider the test complete.
      await QuizFactory.getJson("ReflectionQuiz");
    });

    test('Assert that the Factory returns a QuizContent', () async {
      var q = await QuizFactory.createQuiz("ReflectionQuiz");
      expect(q.runtimeType, QuizContent);
    });
  });
}