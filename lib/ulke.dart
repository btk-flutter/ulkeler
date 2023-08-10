class Ulke {
  String code;
  String name;
  String capital;
  String region;
  int population;
  String flag;
  String language;

  Ulke.fromMap(Map<String, dynamic> map)
      : code = map["cca2"] ?? "",
        name = map["name"]["common"] ?? "",
        capital = (map["capital"] as List<dynamic>).isNotEmpty
            ? map["capital"][0]
            : "",
        region = map["region"] ?? "",
        language = (map["languages"] as Map<String, dynamic>)
                .values
                .toList()
                .isNotEmpty
            ? (map["languages"] as Map<String, dynamic>).values.toList()[0]
            : "",
        population = map["population"] ?? "",
        flag = map["flags"]["png"] ?? "";
}
