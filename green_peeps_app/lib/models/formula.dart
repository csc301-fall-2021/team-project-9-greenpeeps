class Formula {
  final String id;
  final List<String>? prereqs;
  final String formula;
  final String category;

  Formula(
      {required this.id,
      required this.prereqs,
      required this.formula,
      required this.category});
}
