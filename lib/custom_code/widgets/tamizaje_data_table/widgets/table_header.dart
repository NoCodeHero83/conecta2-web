// Header/cell presentational widgets for TamizajeDataTable.

import 'package:flutter/material.dart';

Widget buildHeaderCell(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 12,
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget buildBodyCell(String text) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(8),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: Colors.black87),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

Widget buildLeyendaColor(String texto, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 16,
        height: 16,
        color: color,
      ),
      const SizedBox(width: 4),
      Text(
        texto,
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    ],
  );
}

Color obtenerColorRiesgoParaUI(String nivelRiesgo) {
  switch (nivelRiesgo.toLowerCase()) {
    case 'sin alarma':
      return const Color(0xFFD3D3D3);
    case 'bajo':
      return const Color(0xFFC8E6C9);
    case 'moderado':
      return const Color(0xFFFFF9C4);
    case 'alto':
      return const Color(0xFFFFCDD2);
    default:
      return Colors.white;
  }
}
