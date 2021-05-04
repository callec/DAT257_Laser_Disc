/// A single Question is represented by this class.
class QuestionContent {
  final int number;
  final String question;
  final List<String> alternatives;
  final List<String> subAlternatives;
  int _chAlt = -1;
  int _chSAlt = -1;

  int get chosenAlternative => this._chAlt;
  set chosenAlternative(int n) => this._chAlt = n;
  int get chosenSubAlternative => this._chSAlt;
  set chosenSubAlternative(int n) => this._chSAlt = n;

  QuestionContent(
    this.number,
    this.question,
    this.alternatives,
    this.subAlternatives,
  );
}
