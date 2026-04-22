import 'package:flutter/material.dart';

import '../models/department_model.dart';
import '../services/api_colombia_service.dart';
import '../themes/app_theme.dart';

class DetalleDepartamentoView extends StatefulWidget {
  final String id;
  final dynamic department;

  const DetalleDepartamentoView({super.key, required this.id, this.department});

  @override
  State<DetalleDepartamentoView> createState() =>
      _DetalleDepartamentoViewState();
}

class _DetalleDepartamentoViewState extends State<DetalleDepartamentoView> {
  final ApiColombiaService _apiService = ApiColombiaService();
  late Future<DepartmentModel> _futureDepartment;

  @override
  void initState() {
    super.initState();
    _futureDepartment = _resolveInitialDepartment();
  }

  Future<DepartmentModel> _resolveInitialDepartment() {
    if (widget.department is DepartmentModel) {
      return Future<DepartmentModel>.value(
        widget.department as DepartmentModel,
      );
    }
    return _apiService.fetchDepartmentById(widget.id);
  }

  void _reload() {
    setState(() {
      _futureDepartment = _apiService.fetchDepartmentById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del departamento')),
      body: FutureBuilder<DepartmentModel>(
        future: _futureDepartment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
            return const Center(child: Text('No se pudo cargar el detalle'));
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
                _detailRow('Nombre', data.name),
                _detailRow('Descripción', data.description),
                const SizedBox(height: 12),
                _sectionTitle('Datos administrativos'),
                _detailRow('Capital', data.cityCapitalName),
                _detailRow('ID capital', data.cityCapitalId),
                _detailRow('Región', data.regionName),
                _detailRow('ID región', data.regionId),
                _detailRow('ID país', data.countryId),
                _detailRow('Prefijo telefónico', data.phonePrefix),
                const SizedBox(height: 12),
                _sectionTitle('Indicadores'),
                _detailRow('Municipios', data.municipalities),
                _detailRow('Superficie', data.surface),
                _detailRow('Población', data.population),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerCard(DepartmentModel data) {
    return Card(
      color: AppTheme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.map_outlined, size: 52, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              data.name.isNotEmpty ? data.name : 'Sin nombre',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data.regionName.isNotEmpty ? data.regionName : 'Sin región',
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
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
