import '../models/formula.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _formulaCollection =
    FirebaseFirestore.instance.collection('carbonFormulas');

Future<List<Formula>?> getFormulasFromStore() async {
  var snapshot = await _formulaCollection.get();

  try {
    List<Formula>? formulas = snapshot.docs
        .map((doc) => Formula(
            id: doc.id,
            formula: (doc.data() as Map<String, dynamic>)['formula'].toString(),
            prereqs: ((doc.data() as Map<String, dynamic>)['prereqs']
                    as List<dynamic>?)
                ?.map((data) => data.toString())
                .toList(),
            category:
                (doc.data() as Map<String, dynamic>)['category'].toString()))
        .toList();
    return formulas;
  } catch (exception) {
    return null;
  }
}
