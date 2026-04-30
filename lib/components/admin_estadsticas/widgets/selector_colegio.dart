import 'package:flutter/material.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../common/filter_pill.dart';

class SelectorColegio extends StatelessWidget {
  const SelectorColegio({
    super.key,
    required this.seleccionado,
    required this.onChanged,
  });

  final String? seleccionado;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return StreamBuilder<List<ColegiosRecord>>(
      stream: queryColegiosRecord(),
      builder: (context, snapshot) {
        final items = <DropdownMenuItem<String?>>[
          const DropdownMenuItem(value: null, child: Text('Todas las sedes')),
          ...?snapshot.data?.map(
            (c) => DropdownMenuItem<String?>(
              value: c.nombre,
              child: Text(c.nombre),
            ),
          ),
        ];
        return FilterPill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school_outlined,
                    size: 16, color: theme.secondaryText),
                const SizedBox(width: 8),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    value: seleccionado,
                    hint: Text('Todas las sedes',
                        style: filterPillLabelStyle(context)),
                    icon: Icon(Icons.keyboard_arrow_down_rounded,
                        color: theme.secondaryText),
                    style: filterPillLabelStyle(context),
                    borderRadius: BorderRadius.circular(8),
                    items: items,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
