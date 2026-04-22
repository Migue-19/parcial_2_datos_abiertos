import 'package:flutter/material.dart';

import '../models/department_model.dart';
import '../themes/app_theme.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentModel department;
  final VoidCallback onTap;

  const DepartmentCard({
    super.key,
    required this.department,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final firstLetter = department.name.isNotEmpty
        ? department.name[0].toUpperCase()
        : '?';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          child: Text(
            firstLetter,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          department.name.isNotEmpty ? department.name : 'Sin nombre',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          department.regionName.isNotEmpty
              ? '${department.regionName} • Capital: ${department.cityCapitalName.isNotEmpty ? department.cityCapitalName : 'No disponible'}'
              : 'Capital: ${department.cityCapitalName.isNotEmpty ? department.cityCapitalName : 'No disponible'}',
        ),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.primaryColor),
        onTap: onTap,
      ),
    );
  }
}
