import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '../common/filter_pill.dart';
import '../helpers/stats_calculator.dart';

typedef EncuestaItem = ({String titulo, DocumentReference ref});

/// Dropdown to pick a specific encuesta within the currently selected
/// [TamizajeTipo]. Hidden when the list is empty or tipo is "todas".
class SelectorEncuesta extends StatefulWidget {
  const SelectorEncuesta({
    super.key,
    required this.tipo,
    required this.seleccionada,
    required this.onChanged,
  });

  final TamizajeTipo tipo;
  final DocumentReference? seleccionada;
  final ValueChanged<DocumentReference?> onChanged;

  @override
  State<SelectorEncuesta> createState() => _SelectorEncuestaState();
}

class _SelectorEncuestaState extends State<SelectorEncuesta> {
  List<EncuestaItem> _items = [];
  bool _cargando = false;
  TamizajeTipo? _tipoActual;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  @override
  void didUpdateWidget(SelectorEncuesta old) {
    super.didUpdateWidget(old);
    if (old.tipo != widget.tipo) _cargar();
  }

  Future<void> _cargar() async {
    if (widget.tipo == TamizajeTipo.todas) {
      setState(() {
        _items = [];
        _tipoActual = widget.tipo;
      });
      return;
    }
    setState(() => _cargando = true);
    final result = await loadEncuestasByTipo(widget.tipo);
    if (!mounted) return;
    setState(() {
      _items = result;
      _tipoActual = widget.tipo;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_tipoActual == TamizajeTipo.todas || _items.isEmpty) {
      return const SizedBox.shrink();
    }
    final theme = FlutterFlowTheme.of(context);

    return FilterPill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: _cargando
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : DropdownButtonHideUnderline(
                child: DropdownButton<DocumentReference?>(
                  value: widget.seleccionada,
                  hint: Text(
                    'Tamizaje específico',
                    style: filterPillLabelStyle(context),
                  ),
                  isDense: true,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        'Todos',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryText,
                        ),
                      ),
                    ),
                    ..._items.map(
                      (e) => DropdownMenuItem(
                        value: e.ref,
                        child: Text(
                          e.titulo,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: theme.primaryText,
                          ),
                        ),
                      ),
                    ),
                  ],
                  onChanged: widget.onChanged,
                ),
              ),
      ),
    );
  }
}
