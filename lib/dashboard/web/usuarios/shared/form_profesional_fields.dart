import 'package:flutter/material.dart';

/// Profesional-specific sidebar content. For the current design, profesionales
/// do not link to Acudiente/Adolescente in the sidebar panel, so this renders
/// an empty placeholder. Kept as a widget for parity with the other role
/// components and future extensibility.
class ProfesionalSidebarFields extends StatelessWidget {
  const ProfesionalSidebarFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
