import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/item_model.dart';
import '../services/api_service.dart';
import '../themes/app_theme.dart';
import '../widgets/item_card.dart';

class ListadoView extends StatefulWidget {
  const ListadoView({super.key});

  @override
  State<ListadoView> createState() => _ListadoViewState();
}

class _ListadoViewState extends State<ListadoView> {
  final ApiService _apiService = ApiService();
  late Future<List<ItemModel>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = _apiService.fetchItems(limit: 20);
  }

  void _reload() {
    setState(() {
      _futureItems = _apiService.fetchItems(limit: 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de datos'),
        actions: [
          IconButton(
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: _futureItems,
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

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(
              child: Text('No se encontraron datos'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemCard(
                  item: item,
                  onTap: () => context.goNamed(
                    'detalle',
                    pathParameters: {'id': item.id},
                    extra: item,
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