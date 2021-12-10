import 'package:math_expressions/math_expressions.dart';
import 'package:green_peeps_app/models/formula.dart';
import 'package:green_peeps_app/models/response.dart';
import 'package:green_peeps_app/services/formula_firestore.dart';
import 'package:green_peeps_app/services/response_firestore.dart';
import 'package:green_peeps_app/services/userdata_firestore.dart';

void updateCarbonCalculations() async {
  List<Formula>? formulas = await getFormulasFromStore();
  List<Response>? responses = await getResponses();
  if (formulas == null || responses == null) {
    return;
  } else {
    for (Formula formula in formulas) {
      if (checkPrereqs(formula, responses)) {
        double carbonValue = parseFormula(formula, responses);
        setCarbonValue(formula.category, carbonValue);
      }
    }
  }
}

bool checkPrereqs(Formula formula, List<Response> responses) {
  List<String> answeredQuestions =
      responses.map((response) => response.qID).toList();
  bool prereqsMet = true;
  for (String prereq in formula.prereqs ?? []) {
    if (!answeredQuestions.contains(prereq)) {
      prereqsMet = false;
      break;
    }
  }
  return prereqsMet;
}

double parseFormula(Formula formula, List<Response> responses) {
  Expression expression = Parser().parse(formula.formula);
  ContextModel cm = ContextModel();
  for (Response response in responses) {
    cm.bindVariable(Variable(response.qID),
        Number(response.value ?? double.tryParse(response.answer) ?? 0));
  }
  return expression.evaluate(EvaluationType.REAL, cm);
}
