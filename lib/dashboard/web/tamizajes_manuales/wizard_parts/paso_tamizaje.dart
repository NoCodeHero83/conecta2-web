part of '../wizard_tamizaje_manual.dart';

class _PasoSeleccionTamizaje extends StatefulWidget {
  const _PasoSeleccionTamizaje({
    required this.onSeleccionado,
    required this.onAtras,
  });

  final ValueChanged<EncuestasRecord> onSeleccionado;
  final VoidCallback onAtras;

  @override
  State<_PasoSeleccionTamizaje> createState() => _PasoSeleccionTamizajeState();
}

class _PasoSeleccionTamizajeState extends State<_PasoSeleccionTamizaje> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.onAtras,
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Atrás',
              ),
              const SizedBox(width: 8),
              Text(
                'Elegir tamizaje a aplicar',
                style: theme.titleMedium.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w700),
                  letterSpacing: 0.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (v) => setState(() => _filtro = v),
            decoration: InputDecoration(
              hintText: 'Buscar tamizaje…',
              prefixIcon: const Icon(Icons.search, size: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.alternate),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<List<EncuestasRecord>>(
              stream: queryEncuestasRecord(
                queryBuilder: (q) => q
                    .where('tipo', isEqualTo: 'Tamizajes')
                    .where('Publicado', isEqualTo: true),
              ),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final filtrados = snap.data!.where((e) {
                  final t = e.titulo.toLowerCase();
                  return t.contains(_filtro.toLowerCase());
                }).toList();
                if (filtrados.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay tamizajes publicados',
                      style: theme.bodyMedium,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: filtrados.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final e = filtrados[i];
                    return ListTile(
                      leading: const Icon(Icons.assignment,
                          color: Color(0xFF265294)),
                      title: Text(
                        e.titulo,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        e.descripcion.isNotEmpty
                            ? e.descripcion
                            : '${e.preguntas.length} preguntas',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => widget.onSeleccionado(e),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Paso 3 — formulario de aplicación del tamizaje
// ─────────────────────────────────────────────────────────────────────────────

