import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/item_model.dart';

class ApiService {
  Future<List<ItemModel>> fetchItems({int limit = 20, int offset = 0}) async {
    final uri = Uri.parse(AppConfig.fullUrl).replace(
      queryParameters: {
        r'$limit': limit.toString(),
        r'$offset': offset.toString(),
      },
    );

    try {
      final response = await http.get(uri, headers: AppConfig.defaultHeaders);

      if (response.statusCode == 200) {
        return _parseList(response.body);
      }
      if (response.statusCode == 404) {
        throw Exception('Recurso no encontrado (404)');
      }
      if (response.statusCode == 500) {
        throw Exception('Error interno del servidor (500)');
      }
      throw Exception('Error HTTP: ${response.statusCode}');
    } catch (error) {
      throw Exception('Error de conexión al obtener listado: $error');
    }
  }

  Future<ItemModel> fetchItemById(String id) async {
    final uri = Uri.parse(AppConfig.fullUrl).replace(
      queryParameters: {
        r'$where': "codigo_dane='$id'",
        r'$limit': '1',
      },
    );

    try {
      final response = await http.get(uri, headers: AppConfig.defaultHeaders);

      if (response.statusCode == 200) {
        final items = _parseList(response.body);
        if (items.isEmpty) {
          // Si no encuentra por codigo_dane, intenta buscar por nombre_establecimiento
          return await _fetchByNombre(id);
        }
        return items.first;
      }
      if (response.statusCode == 404) {
        throw Exception('Recurso no encontrado (404)');
      }
      if (response.statusCode == 500) {
        throw Exception('Error interno del servidor (500)');
      }
      throw Exception('Error HTTP: ${response.statusCode}');
    } catch (error) {
      throw Exception('Error al obtener detalle: $error');
    }
  }

  Future<ItemModel> _fetchByNombre(String id) async {
    final uri = Uri.parse(AppConfig.fullUrl).replace(
      queryParameters: {
        r'$where': "nombre_establecimiento='$id'",
        r'$limit': '1',
      },
    );
    final response = await http.get(uri, headers: AppConfig.defaultHeaders);
    if (response.statusCode == 200) {
      final items = _parseList(response.body);
      if (items.isEmpty) {
        throw Exception('Registro no encontrado para: $id');
      }
      return items.first;
    }
    throw Exception('Error HTTP: ${response.statusCode}');
  }

  List<ItemModel> _parseList(String responseBody) {
    final decoded = json.decode(responseBody);

    if (decoded is! List) {
      throw Exception('La respuesta de la API no es una lista válida');
    }

    return decoded
        .map((item) => ItemModel.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }
}