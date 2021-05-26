# DAT257 Laser Disc

# Important links
Here is our trello board: [trello](https://trello.com/b/mKugQJYh/självskattningstool-för-hast)

Final report: [final report](https://github.com/callec/DAT257_Laser_Disc/blob/main/Documentation/Team%20Reflections/Final_report_LaserDisc.pdf)

Folder with documentation: [`./Documentation`](https://github.com/callec/DAT257_Laser_Disc/tree/main/Documentation), the reflections and protocols are in different folders so browse through them and check.

Here are our meeting protocols: [google drive folder](https://drive.google.com/drive/folders/1uzpQzz05D-v1rGTBSolIAGP39Z83LgL7?usp=sharing)

Gitinspector: we did not manage to get gitinspector working and it doesn't have support for dart so please look at [github insights](https://github.com/callec/DAT257_Laser_Disc/graphs/contributors) instead.

Technical documentation: [google drive document](https://docs.google.com/document/d/1T82xsCrSuuGY0ROaK10LhsoE4vVVMOoqwufwu2DMPbw/edit?usp=sharing)

## The code
To see the project files you would visit [`./hast_app/hast_app/`](https://github.com/callec/DAT257_Laser_Disc/tree/main/hast_app/hast_app), and more specifically the `lib/` folder within it. The tests are in `tests/models/`, and the quizzes are in `assets/quizzes/`.

## Running the app
To test the app in production, use this link: [https://gifted-beaver-3438ca.netlify.app/#/](https://gifted-beaver-3438ca.netlify.app/#/?q=reflectionquiz). To test the different quizzes you would add `?q=filename` to the end of the link. The quizzes we have at the moment are `reflectionquiz`, `example`, and `example2`.

To run on macos or linux: Take down the repo to your machine and make sure you have flutter and chrome installed. Then from the folder with `pubspec.yaml` ([./hast_app/hast_app/](https://github.com/callec/DAT257_Laser_Disc/tree/main/hast_app/hast_app)) run the command `flutter run -d chrome`. 

To run on windows: The team members that use Windows have installed flutter and then used Android studio, imported the project there and ran `main.dart` with chrome specified as device.
