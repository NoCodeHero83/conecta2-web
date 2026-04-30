import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '../common/filter_pill.dart';

class RangoFechasSelector extends StatelessWidget {
  const RangoFechasSelector({
    super.key,
    required this.rango,
    required this.onChanged,
  });

  final DateTimeRange? rango;
  final ValueChanged<DateTimeRange?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return FilterPill(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _pick(context),
            borderRadius: BorderRadius.circular(FilterPill.radius),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: theme.secondaryText),
                  const SizedBox(width: 8),
                  Text(_label(), style: filterPillLabelStyle(context)),
                ],
              ),
            ),
          ),
          if (rango != null) ...[
            const SizedBox(width: 4),
            InkWell(
              onTap: () => onChanged(null),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.close,
                    size: 16, color: theme.secondaryText),
              ),
            ),
          ],
          const SizedBox(width: 6),
        ],
      ),
    );
  }

  String _label() {
    final r = rango;
    if (r == null) return 'Todas las fechas';
    final fmt = DateFormat('dd/MM/yy');
    return '${fmt.format(r.start)} — ${fmt.format(r.end)}';
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final theme = FlutterFlowTheme.of(context);
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange: rango ??
          DateTimeRange(
            start: DateTime(now.year, now.month - 1, now.day),
            end: now,
          ),
      helpText: 'Seleccionar rango de fechas',
      cancelText: 'Cancelar',
      confirmText: 'Aplicar',
      saveText: 'Guardar',
      // On desktop/web the default is a full-screen sheet. Force a
      // normal-sized modal centered on the viewport.
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.accent2,
              onPrimary: Colors.white,
              surface: theme.primaryBackground,
              onSurface: theme.primaryText,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 540,
                maxHeight: 620,
              ),
              child: Dialog(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                insetPadding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          ),
        );
      },
    );
    if (result != null) onChanged(result);
  }
}
