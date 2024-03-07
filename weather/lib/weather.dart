class Weather {
  final int id;
  final String base;
  final String name;
  final int cod;

  Weather({
    required this.id,
    required this.base,
    required this.name,
    required this.cod});

  factory Weather.fromJson(Map<String,dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'base': String base,
        'name': String name,
        'cod': int cod,
    } => Weather(
        id: id,
        base: base,
        name: name,
        cod: cod,
      ),
    _ => throw const FormatException('Failed to load weather'),
    };
  }


    // factory Weather.fromJson(Map<String, dynamic> json) {
    //   return Weather(
    //       id: json['id'],
    //       base: json['base'],
    //       name: json['name'],
    //       cod: json['cod']
    //   );
    // }
}