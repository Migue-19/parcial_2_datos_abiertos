import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/department_model.dart';
import '../services/api_colombia_service.dart';
import '../themes/app_theme.dart';
import '../widgets/department_card.dart';

class ListadoDepartamentosView extends StatefulWidget {
  const ListadoDepartamentosView({super.key});

  @override
  State<ListadoDepartamentosView> createState() =>
      _ListadoDepartamentosViewState();
}

class _ListadoDepartamentosViewState extends State<ListadoDepartamentosView> {
  final ApiColombiaService _apiService = ApiColombiaService();
  late Future<List<DepartmentModel>> _futureDepartments;

  @override
  void initState() {
    super.initState();
    _futureDepartments = _apiService.fetchDepartments();
  }

  void _reload() {
    setState(() {
      _futureDepartments = _apiService.fetchDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos de Colombia'),
        actions: [
          IconButton(
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: FutureBuilder<List<DepartmentModel>>(
        future: _futureDepartments,
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
                      'Error: ${snapshot.error}',
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

          final departments = snapshot.data ?? [];
          if (departments.isEmpty) {
            return const Center(child: Text('No se encontraron departamentos'));
          }

          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                return DepartmentCard(
                  department: department,
                  onTap: () => context.goNamed(
                    'detalleDepartamento',
                    pathParameters: {'id': department.id},
                    extra: department,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
