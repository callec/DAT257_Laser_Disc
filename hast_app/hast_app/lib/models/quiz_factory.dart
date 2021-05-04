import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/common/quiz_content.dart';

class QuestionFactory {
  static QuizContent createStandardQuiz() {
    List<QuestionContent> questionList = [];

    String question_title = 'Lifestyle and Work Assessment';
    List<String> resultText = [
      'Perhaps you feel a little down or \‘feel\’ like a failure. Life is hard,'
          ' most things feel like it is a struggle. We know that from here it'
          ' is difficult for you to get your head above water and see the '
          'possibilities for yourself and your life. In our signature '
          'programme, we create the conditions for our clients to operate from'
          ' a place of strength, calm, clarity, creativity and resilience for'
          ' both the short term and the long term, as we believe that without'
          ' unleashing these and our other human capacities, hard work, or'
          ' external productivity tools, no matter how sophisticated, will'
          ' never be enough.',
      'A lot of hard work, but no leverage, very little traction or results. '
          'Sometimes it is just all a little too frustrating. Thriving — both'
          ' professionally and personally — isn’t about requiring the external'
          ' world around us to be exactly as we want it to be. It’s about '
          'creating pathways of connection to our inner resources, those '
          'treasures inside us that enable us to handle whatever the external '
          'world throws our way. In our signature programme, we help you access'
          ' your amazing inner capacities, unleash them and leverage them to '
          'create great results at work and a life you thrive in. ',
      'You are conventionally ‘successful’! Cool! You do well enough at work '
          'and in life, but I am guessing you feel that there is more to life, '
          'more that is possible for you, and yet this is a little out of '
          'reach. Our signature and highly acclaimed programme will unleash '
          'your inner capacities for insight, wisdom, clarity, creativity and '
          'peace of mind, and support you to experience an inspired life where '
          'you consistently live your best self. ',
      'Congratulations, you are already living an inspired life and being your'
          ' best self, most of the time! If you want to go deeper or support '
          'yourself to stay in a space of thriving, we would love to share our '
          'special mastermind programme which combines unleashing your '
          'capacities in the professional business, corporate or academic '
          'worlds so all areas of your life, relationships and work, '
          'consistently thrive. '
    ];

    String question1_text = 'Reactivity vs. finding \'the space\'';

    String option1_1 = 'You often overreact to other people, since you are '
        'often treated unfairly. Sometimes you feel the world is against you.';

    String option1_2 = 'You see that you react in ways that don’t work in many '
        'situations. You don’t feel good about it, but you have no idea how to '
        'change your behaviour.';

    String option1_3 = 'You often catch yourself when you overreact, you find '
        '‘the space’, and from there you can create a more balanced response.';

    String option1_4 =
        'As you let your reactions be instead of trying to change them,'
        ' you often get insights and see new possibilities.';

    String question2_title = 'Lifestyle and Work Assessment';

    String question2_text = 'Relaxed or Stressed';

    String option2_1 = 'You are very stressed. You notice your physical health '
        'is suffering. You are not sure how long you can keep this up without going'
        ' into Burnout.';

    String option2_2 =
        'You are stressed most days; you are frequently anxious or worried and you '
        'are not sure what to do to change things for the better. Sometimes, you '
        'might feel a little better, but stress comes back very quickly.';

    String option2_3 =
        'You have reached a place where you feel relaxed a lot of the time, even if'
        ' you feel stressed now and again. You are alert for when you have '
        'stressful thinking and can move relatively easily beyond stress into '
        'relaxation.';

    String option2_4 =
        'You are relaxed, yet responsive to what happens in life and you seem to be'
        ' able to handle big and small challenges with grace and ease. Others '
        'wonder how you can be so productive and yet so relaxed.';

    // fråga HAST ifall dessa ska vara konstanta
    // Vad betyder egentligen graderingen som görs i fas två
    String subOption1 = 'Alternative 1';
    String subOption2 = 'Alternative 2';
    String subOption3 = 'Alternative 3';

    String nextButton = "Next";

    // Add question 1 text
    questionList.insert(
        0,
        new QuestionContent(
          1,
          question1_text,
          [option1_1, option1_2, option1_3, option1_4],
          [subOption1, subOption2, subOption3],
        ));
//            question1_text, option1_1, option1_2, option1_3, option1_4));

    // Add question 2 text
    questionList.insert(
        1,
        new QuestionContent(
          2,
          question2_text,
          [option2_1, option2_2, option2_3, option2_4],
          [subOption1, subOption2, subOption3],
        ));

    // Add question 3 text
    questionList.insert(
        2,
        new QuestionContent(
          3,
          question1_text,
          [option1_1, option1_2, option1_3, option1_4],
          [subOption1, subOption2, subOption3],
        ));

    // Add question 4 text
    questionList.insert(
        3,
        new QuestionContent(
          4,
          question2_text,
          [option2_1, option2_2, option2_3, option2_4],
          [subOption1, subOption2, subOption3],
        ));
    // Add question 5 text
    questionList.insert(
        4,
        new QuestionContent(
          5,
          question1_text,
          [option1_1, option1_2, option1_3, option1_4],
          [subOption1, subOption2, subOption3],
        ));
    // Add question 6 text
    questionList.insert(
        5,
        new QuestionContent(
          6,
          question2_text,
          [option2_1, option2_2, option2_3, option2_4],
          [subOption1, subOption2, subOption3],
        ));
    // Add question 7 text
    questionList.insert(
        6,
        new QuestionContent(
          7,
          question1_text,
          [option1_1, option1_2, option1_3, option1_4],
          [subOption1, subOption2, subOption3],
        ));
    // Add question 8 text
    questionList.insert(
        7,
        new QuestionContent(
          8,
          question2_text,
          [option2_1, option2_2, option2_3, option2_4],
          [subOption1, subOption2, subOption3],
        ));
    return QuizContent(question_title, resultText, questionList);
  }
}
