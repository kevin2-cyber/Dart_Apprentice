class Weather {
  final int id;
  final String base;
  final String name;
  final int cod;
  final String description;

  const Weather({
    required this.id,
    required this.base,
    required this.name,
    required this.cod,
    required this.description
});

  // factory Weather.fromJson(Map<String, dynamic> json) {}
}