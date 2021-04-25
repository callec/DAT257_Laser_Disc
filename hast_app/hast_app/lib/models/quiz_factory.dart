import 'package:hast_app/common/question.dart';

class QuestionFactory {
  static List<QuestionContent> createStandardQuiz() {
    
    List<QuestionContent> questionList = [];
    int question_number = 0;

    String question_title = 'Lifestyle and Work Assessment';

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
        number: 1,
        question: question1_text,
        alternatives: [option1_1, option1_2, option1_3, option1_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );
//            question1_text, option1_1, option1_2, option1_3, option1_4));

    // Add question 2 text
    questionList.insert(
      1,
      new QuestionContent(
        number: 2,
        question: question2_text,
        alternatives: [option2_1, option2_2, option2_3, option2_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );

    // Add question 3 text
    questionList.insert(
      2,
      new QuestionContent(
        number: 3,
        question: question1_text,
        alternatives: [option1_1, option1_2, option1_3, option1_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );

    // Add question 4 text
    questionList.insert(
      3,
      new QuestionContent(
        number: 4,
        question: question2_text,
        alternatives: [option2_1, option2_2, option2_3, option2_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );
    // Add question 5 text
    questionList.insert(
      4,
      new QuestionContent(
        number: 5,
        question: question1_text,
        alternatives: [option1_1, option1_2, option1_3, option1_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );
    // Add question 6 text
    questionList.insert(
      5,
      new QuestionContent(
        number: 6,
        question: question2_text,
        alternatives: [option2_1, option2_2, option2_3, option2_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );
    // Add question 7 text
    questionList.insert(
      6,
      new QuestionContent(
        number: 7,
        question: question1_text,
        alternatives: [option1_1, option1_2, option1_3, option1_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );
    // Add question 8 text
    questionList.insert(
      7,
      new QuestionContent(
        number: 8,
        question: question2_text,
        alternatives: [option2_1, option2_2, option2_3, option2_4],
        subAlternatives: [subOption1, subOption2, subOption3],
      )
    );
    return questionList;
  }
}
