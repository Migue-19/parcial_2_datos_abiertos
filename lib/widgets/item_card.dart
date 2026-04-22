import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../themes/app_theme.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final leadingText = item.nombre.isNotEmpty ? item.nombre[0].toUpperCase() : '?';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          child: Text(
            leadingText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          item.nombre.isNotEmpty ? item.nombre : 'Sin nombre',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${item.departamento.isNotEmpty ? item.departamento : 'Sin departamento'} • ${item.municipio.isNotEmpty ? item.municipio : 'Sin municipio'}',
        ),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.primaryColor),
        onTap: onTap,
      ),
    );
  }
}