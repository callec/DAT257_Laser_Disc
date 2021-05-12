# DAT257_projekt

## Start Quiz
1) Open the page where the program is hosted

         myexamplewebsite(dot)com/

2) Grab the URL and add the following to the end off the it:

         ?q=example
      It should look like this:

         myexamplewebsite(dot)com/?q=example

      This will load the file "example.json", that constains an example Quiz.

3) Follow the Insturctions below, [Add new Quizzes](#addQuiz), if you want to create your own Quiz.

4) To access a Quiz change the URL to:

         myexamplewebsite(dot)com/?q=[Name of file]

5) Now you should see your own Quiz

## Add new Quizzes <a name= "addQuiz"></a>
1) Open the project and navigate to ["hast_app/hast_app/assets/quizzes"](https://github.com/callec/DAT257_projekt/tree/ID14_multiple_quizzes/hast_app/hast_app/assets/quizzes).
2) Copy the file "example.json" and give it an appropriate name like "life_reflection.json" or "my_cool_quiz.json".
3) Open the file you just created using any text editor. Example: Notepad, Notepad++, Atom, etc.
4) Start editing the file (**only change the text within quotation marks**)
   * quizTitle: This is the title for the whole Quiz
   * quizInfo: Information text regarding the specific Quiz
   * subAltText: Sub alternative question.

         "subAltText": "Is your situation worse, better, or exactly as the statement directly above describes?"

   * subAlternatives: The 3 different sub alternatives to choose from. Each alternative is seperated by a comma.   

         "subAlternatives": ["Worse", "Exactly", "Better"]

   * resultText: This is the different texts displayed depending on the total score.



         "resultText": [      
                "0 - 1/4 of total score",
                "1/4 - 2/4 of total score",
                "2/4 - 3/4 of total score",
                "3/4  - 4/4 of total score"
              ]

   * questions: These are the questions presented in the Quiz. In "example.json" there are 8 questions, you can add or remove additional questions (careful going over 10)

            "questions": [
              {
                "question": "THIS IS THE FIRST QUESTIONS TITLE",
                "alternatives": [
                  "Alt 1",
                  "Alt 2",
                  "Alt 3",
                  "Alt 4"
                ]
              },
              {
                "question": "THIS IS THE SECOND QUESTIONS TITLE",
                "alternatives": [
                  "Alt 1",
                  "Alt 2",
                  "Alt 3",
                  "Alt 4"
                ]
              }
            ]
      * question: This is the title
      * alternatives: These are the 4 different alternatives

                {
                  "question": "THIS IS THE QUESTIONS TITLE",
                  "alternatives": [
                    "Alt 1",
                    "Alt 2",
                    "Alt 3",
                    "Alt 4"
                  ]
                },
  5) Once you have added all the text to your file, save the file to the [quizzes folder](https://github.com/callec/DAT257_projekt/tree/ID14_multiple_quizzes/hast_app/hast_app/assets/quizzes). (Same location as "example.json")
  6) Navigate to the ["hast_app/hast_app"](https://github.com/callec/DAT257_projekt/tree/ID14_multiple_quizzes/hast_app/hast_app) folder.
  7) Open the the file "pubspec.yaml" with a text editor of your choice.
  8) Scroll to the bottom of the document and add the new path.

              - assets/quizzes/[Name of file].json

  9) Recompile the code and publish the new version
