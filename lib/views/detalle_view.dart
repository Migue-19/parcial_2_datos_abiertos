import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../services/api_service.dart';
import '../themes/app_theme.dart';

class DetalleView extends StatefulWidget {
  final String id;
  final dynamic item;

  const DetalleView({super.key, required this.id, this.item});

  @override
  State<DetalleView> createState() => _DetalleViewState();
}

class _DetalleViewState extends State<DetalleView> {
  final ApiService _apiService = ApiService();
  late Future<ItemModel> _futureItem;

  @override
  void initState() {
    super.initState();
    _futureItem = _resolveInitialItem();
  }

  Future<ItemModel> _resolveInitialItem() {
    if (widget.item is ItemModel) {
      return Future<ItemModel>.value(widget.item as ItemModel);
    }
    return _apiService.fetchItemById(widget.id);
  }

  void _reload() {
    setState(() {
      _futureItem = _apiService.fetchItemById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del registro'),
      ),
      body: FutureBuilder<ItemModel>(
        future: _futureItem,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No se pudo cargar el detalle:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return const Center(
              child: Text('No se pudo cargar el detalle'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _headerCard(data),
                const SizedBox(height: 16),
                _sectionTitle('Información general'),
                _detailRow('ID', data.id),
                _detailRow('Año', data.year),
                _detailRow('Nombre', data.nombre),
                _detailRow('Código DANE', data.codigoDane),
                _detailRow('Rector', data.rector),
                const SizedBox(height: 12),
                _sectionTitle('Ubicación'),
                _detailRow('Departamento', data.departamento),
                _detailRow('Código departamento', data.departmentCode),
                _detailRow('Secretaría', data.secretaria),
                _detailRow('Código secretaría', data.secretariaCode),
                _detailRow('Municipio', data.municipio),
                _detailRow('Código municipio', data.municipalityCode),
                _detailRow('Dirección', data.direccion),
                const SizedBox(height: 12),
                _sectionTitle('Características'),
                _detailRow('Sector', data.sector),
                _detailRow('Código sector', data.sectorCode),
                _detailRow('Carácter', data.caracter),
                _detailRow('Código carácter', data.characterCode),
                _detailRow('Calendario', data.calendario),
                _detailRow('Código calendario', data.calendarCode),
                _detailRow('Total matrícula', data.totalMatricula),
                _detailRow('Cantidad de sedes', data.cantidadSedes),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerCard(ItemModel data) {
    return Card(
      color: AppTheme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.info_outline,
              size: 52,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              data.nombre.isNotEmpty ? data.nombre : 'Sin nombre',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data.departamento.isNotEmpty
                  ? '${data.departamento} • ${data.municipio}'
                  : data.municipio,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        subtitle: Text(
          value.isNotEmpty ? value : 'No disponible',
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}