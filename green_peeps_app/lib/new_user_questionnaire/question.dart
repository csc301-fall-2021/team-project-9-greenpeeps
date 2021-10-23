import 'package:tuple/tuple.dart';

class Question{

  String id, text;
  int fieldType, type;
  // fieldType can be {'MC', 'Num', 'Drop'} for multiple choice or numeric
  // 0: Numerical
  // 1: Multiple choice
  // 2: Dropdown
  // type can be {'Branching', 'Modifier', 'BaseValue' }
  // 0: Branching
  // 1: BaseValue
  // 2: Modifier
  List<String> tags;
  Map<String, Tuple2<String, List<String>>> answers;
  // {answer: value, followup qID}


  Question({required this.id, required this.text, required this.fieldType,
    required this.type, required this.answers, required this.tags});

  String getId() => id;

  String getText() => text;

  int getFieldType() => fieldType;

  int getType() => type;

  Set<String> getAnswers(){
    var answersList = <String>{};
    answers.forEach((k, v) => answersList.add(k));
    return answersList;
  }


  List<String> getTags() => tags;

}



