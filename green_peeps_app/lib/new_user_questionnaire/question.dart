
class Question{

  String id, text, type;
  List<String> answers, tags;

  Question({required this.id, required this.text,
    required this.type, required this.answers, required this.tags});

  String getId() => id;

  String getText() => text;

  String getType() => type;

  List<String> getAnswers() => answers;

  List<String> getTags() => tags;

}



