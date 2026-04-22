import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/department_model.dart';

class ApiColombiaService {
  Future<List<DepartmentModel>> fetchDepartments() async {
    final uri = Uri.parse(AppConfig.apiColombiaDepartmentUrl);

    try {
      final response = await http.get(uri, headers: AppConfig.defaultHeaders);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is! List) {
          throw Exception('La respuesta no es una lista válida');
        }
        return decoded
            .map(
              (item) => DepartmentModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            )
            .toList();
      }
      if (response.statusCode == 404) {
        throw Exception('Recurso no encontrado (404)');
      }
      if (response.statusCode == 500) {
        throw Exception('Error interno del servidor (500)');
      }
      throw Exception('Error HTTP: ${response.statusCode}');
    } catch (error) {
      throw Exception('Error de conexión al obtener departamentos: $error');
    }
  }

  Future<DepartmentModel> fetchDepartmentById(String id) async {
    final uri = Uri.parse('${AppConfig.apiColombiaDepartmentUrl}/$id');

    try {
      final response = await http.get(uri, headers: AppConfig.defaultHeaders);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is! Map<String, dynamic>) {
          throw Exception('La respuesta no es un objeto válido');
        }
        return DepartmentModel.fromJson(decoded);
      }
      if (response.statusCode == 404) {
        throw Exception('Departamento no encontrado (404)');
      }
      if (response.statusCode == 500) {
        throw Exception('Error interno del servidor (500)');
      }
      throw Exception('Error HTTP: ${response.statusCode}');
    } catch (error) {
      throw Exception('Error al obtener detalle del departamento: $error');
    }
  }
}
