class Weather {
  final int id;
  final String base;
  final String name;
  final int cod;

  const Weather({
    required this.id,
    required this.base,
    required this.name,
    required this.cod
});

  // factory Weather.fromJson(Map<String, dynamic> json) {}
}