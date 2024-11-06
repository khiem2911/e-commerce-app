class Country {
  const Country({required this.name, required this.capital});
  final String name;
  final List<dynamic> capital;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name']['common'] ?? '', capital: json['capital'] ?? []);
  }
}
