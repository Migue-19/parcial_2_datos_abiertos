class ItemModel {
  final String id;
  final String year;
  final String departmentCode;
  final String departamento;
  final String secretariaCode;
  final String secretaria;
  final String municipalityCode;
  final String municipio;
  final String codigoDane;
  final String nombre;
  final String sectorCode;
  final String sector;
  final String characterCode;
  final String caracter;
  final String calendarCode;
  final String calendario;
  final String direccion;
  final String rector;
  final String totalMatricula;
  final String cantidadSedes;

  ItemModel({
    required this.id,
    required this.year,
    required this.departmentCode,
    required this.departamento,
    required this.secretariaCode,
    required this.secretaria,
    required this.municipalityCode,
    required this.municipio,
    required this.codigoDane,
    required this.nombre,
    required this.sectorCode,
    required this.sector,
    required this.characterCode,
    required this.caracter,
    required this.calendarCode,
    required this.calendario,
    required this.direccion,
    required this.rector,
    required this.totalMatricula,
    required this.cantidadSedes,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final codigoDane = _asString(json['codigo_dane'] ?? json['id'] ?? '');

    return ItemModel(
      id: codigoDane,
      year: _asString(json['a_o'] ?? json['anio'] ?? json['year']),
      departmentCode: _asString(json['cod_dane_departamento']),
      departamento: _asString(json['departamento']),
      secretariaCode: _asString(json['cod_secretaria']),
      secretaria: _asString(json['secretaria']),
      municipalityCode: _asString(json['cod_dane_municipio']),
      municipio: _asString(json['municipio']),
      codigoDane: codigoDane,
      nombre: _asString(json['nombre_establecimiento'] ?? json['nombre']),
      sectorCode: _asString(json['cod_sector']),
      sector: _asString(json['sector']),
      characterCode: _asString(json['cod_caracter']),
      caracter: _asString(json['caracter']),
      calendarCode: _asString(json['cod_calendario']),
      calendario: _asString(json['calendario']),
      direccion: _asString(json['direccion']),
      rector: _asString(json['rector']),
      totalMatricula: _asString(json['total_matricula']),
      cantidadSedes: _asString(json['cantidad_sedes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'a_o': year,
      'cod_dane_departamento': departmentCode,
      'departamento': departamento,
      'cod_secretaria': secretariaCode,
      'secretaria': secretaria,
      'cod_dane_municipio': municipalityCode,
      'municipio': municipio,
      'codigo_dane': codigoDane,
      'nombre_establecimiento': nombre,
      'cod_sector': sectorCode,
      'sector': sector,
      'cod_caracter': characterCode,
      'caracter': caracter,
      'cod_calendario': calendarCode,
      'calendario': calendario,
      'direccion': direccion,
      'rector': rector,
      'total_matricula': totalMatricula,
      'cantidad_sedes': cantidadSedes,
    };
  }

  static String _asString(dynamic value) => value?.toString() ?? '';
}