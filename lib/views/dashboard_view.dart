import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../themes/app_theme.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F9FF),
              Color(0xFFE9F0FF),
              AppTheme.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: AppTheme.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(Icons.public, size: 64, color: Colors.white),
                        const SizedBox(height: 16),
                        Text(
                          'Datos Abiertos de Colombia',
                          textAlign: TextAlign.center,
                          style: textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Explora instituciones educativas del país desde la API pública de Datos Abiertos del Gobierno de Colombia.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: const [
                    _StatCard(
                      icon: Icons.source,
                      title: 'Fuente',
                      value: 'datos.gov.co',
                    ),
                    _StatCard(
                      icon: Icons.data_object,
                      title: 'Formato',
                      value: 'JSON REST',
                    ),
                    _StatCard(
                      icon: Icons.school,
                      title: 'Dataset',
                      value: 'Instituciones',
                    ),
                    _StatCard(
                      icon: Icons.map,
                      title: 'API Colombia',
                      value: 'Departamentos',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '¿Qué puedes hacer?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Consultar instituciones educativas (datos.gov.co) y departamentos (api-colombia.com), con estados de carga/error/datos y navegación por go_router.',
                          style: TextStyle(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => context.goNamed('listado'),
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Ver listado de instituciones'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => context.goNamed('listadoDepartamentos'),
                  icon: const Icon(Icons.location_city),
                  label: const Text('Ver listado de departamentos'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
