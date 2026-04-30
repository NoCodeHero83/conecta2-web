import '/tamizajes/shared/tamizajes_constants.dart';
import '/tamizajes/shared/widgets/tamizaje_page_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Header de la página Tamizajes Manuales con botón "Nuevo tamizaje".
class TamizajesManualesHeader extends StatelessWidget {
  const TamizajesManualesHeader({
    super.key,
    required this.onNuevo,
  });

  final VoidCallback onNuevo;

  @override
  Widget build(BuildContext context) {
    return TamizajePageHeader(
      titulo: 'Tamizajes Manuales',
      icon: Icons.assignment_outlined,
      trailing: ElevatedButton.icon(
        onPressed: onNuevo,
        icon: const Icon(Icons.add, size: 18.0),
        label: const Text('Nuevo tamizaje'),
        style: ElevatedButton.styleFrom(
          backgroundColor: kNavy,
          foregroundColor: Colors.white,
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          textStyle:
              GoogleFonts.inter(fontSize: 13.0, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0,
        ),
      ),
    );
  }
}
