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
  
  6) Push the changes

## Publish the App with netlify

1) Make sure this folder is in a github repository (or a supported alternative).
2) Connect the repository with Your netlify account according to the instructions on their site.
3) Deploy settings: Make sure the `base directory` is the folder with the `pubspec.yaml` file in it. Use the following build command:
```
if cd flutter; then git pull && cd ..; else git clone https://github.com/flutter/flutter.git; fi && flutter/bin/flutter config --enable-web && flutter/bin/flutter build web --release
```
4) Publish. It should automatically update the site when you update the repository. For connecting a domain and https read the instructions on the netlify website.

## Colors & Text

To change the colors used in the application you will need to change the color codes in `colors.dart` inside the `lib/` folder.
There the colors are specified with either RGB or hexadecimal values.

To change the texts on the homepage you will need to change the file `home_page_data.dart` in the directory `lib/screen/`.
The text there uses specific syntax to mark bold, italics, newlines, and such, read more about how to apply those on the [plugin page](https://pub.dev/packages/simple_rich_text).
