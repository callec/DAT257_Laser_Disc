/// A single Question is represented by this class.
class QuestionContent {
  final int number;
  final String question;
  final List<String> alternatives;
  final List<String> subAlternatives;
  int _chAlt;
  int _chSAlt;

  int get chosenAlternative => this._chAlt == null ? -1 : this._chAlt;
  set chosenAlternative(int n) => this._chAlt = n;
  int get chosenSubAlternative => this._chSAlt == null ? -1 : this._chSAlt;
  set chosenSubAlternative(int n) => this._chSAlt = n;

  QuestionContent({
    this.number,
    this.question,
    this.alternatives,
    this.subAlternatives,
  });
}
