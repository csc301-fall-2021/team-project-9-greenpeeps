
class Question{

  String id, text, type;
  List<String> answers, tags;
  List<double> values;
  // values is the numerical value of each answer in answers
  // all answers must be unique

  Question({required this.id, required this.text,
    required this.type, required this.answers, required this.values,
    required this.tags});

  String getId() => id;

  String getText() => text;

  String getType() => type;

  List<String> getAnswers() => answers;

  List<String> getTags() => tags;

  double getAnswerValue(String answer){
    int index = answers.indexOf(answer);
    return values[index];
  }

}



