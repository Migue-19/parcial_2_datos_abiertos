class DepartmentModel {
  final String id;
  final String name;
  final String description;
  final String cityCapitalId;
  final String cityCapitalName;
  final String municipalities;
  final String surface;
  final String population;
  final String phonePrefix;
  final String countryId;
  final String regionId;
  final String regionName;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.cityCapitalId,
    required this.cityCapitalName,
    required this.municipalities,
    required this.surface,
    required this.population,
    required this.phonePrefix,
    required this.countryId,
    required this.regionId,
    required this.regionName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: _asString(json['id']),
      name: _asString(json['name']),
      description: _asString(json['description']),
      cityCapitalId: _asString(json['cityCapitalId']),
      cityCapitalName: _asString((json['cityCapital'] as Map?)?['name']),
      municipalities: _asString(json['municipalities']),
      surface: _asString(json['surface']),
      population: _asString(json['population']),
      phonePrefix: _asString(json['phonePrefix']),
      countryId: _asString(json['countryId']),
      regionId: _asString(json['regionId']),
      regionName: _asString((json['region'] as Map?)?['name']),
    );
  }

  static String _asString(dynamic value) => value?.toString() ?? '';
}
