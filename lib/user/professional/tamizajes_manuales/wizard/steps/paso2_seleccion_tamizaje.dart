import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Wizard step 2: select which tamizaje to apply.
class PasoSeleccionTamizaje extends StatefulWidget {
  const PasoSeleccionTamizaje({super.key, required this.onSeleccionado});
  final ValueChanged<EncuestasRecord> onSeleccionado;

  @override
  State<PasoSeleccionTamizaje> createState() => _PasoSeleccionTamizajeState();
}

class _PasoSeleccionTamizajeState extends State<PasoSeleccionTamizaje> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seleccionar tamizaje',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.primaryText,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            onChanged: (v) => setState(() => _filtro = v),
            style: GoogleFonts.inter(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Buscar tamizaje...',
              hintStyle:
                  GoogleFonts.inter(color: theme.secondaryText, fontSize: 14),
              prefixIcon:
                  Icon(Icons.search, size: 20, color: theme.secondaryText),
              filled: true,
              fillColor: theme.secondaryBackground,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: StreamBuilder<List<EncuestasRecord>>(
              stream: queryEncuestasRecord(
                queryBuilder: (q) => q
                    .where('tipo', isEqualTo: 'Tamizajes')
                    .where('Publicado', isEqualTo: true),
              ),
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline,
                            size: 48, color: Colors.red.shade300),
                        const SizedBox(height: 8),
                        Text(
                          'Error al cargar tamizajes',
                          style: GoogleFonts.inter(
                            color: theme.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (snap.connectionState == ConnectionState.waiting &&
                    !snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF265294)),
                    ),
                  );
                }
                final data = snap.data ?? [];
                final filtrados = data.where((e) {
                  final t = e.titulo.toLowerCase();
                  return t.contains(_filtro.toLowerCase());
                }).toList();
                if (filtrados.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            data.isEmpty
                                ? Icons.assignment_outlined
                                : Icons.search_off,
                            size: 48,
                            color: theme.alternate),
                        const SizedBox(height: 8),
                        Text(
                          data.isEmpty
                              ? 'No hay tamizajes publicados'
                              : 'Sin coincidencias',
                          style: GoogleFonts.inter(
                            color: theme.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: filtrados.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final e = filtrados[i];
                    return _TamizajeCard(
                      encuesta: e,
                      theme: theme,
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

class _TamizajeCard extends StatelessWidget {
  const _TamizajeCard({
    required this.encuesta,
    required this.theme,
    required this.onTap,
  });
  final EncuestasRecord encuesta;
  final FlutterFlowTheme theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.secondaryBackground,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE5A1).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.assignment,
                    color: Color(0xFF265294), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      encuesta.titulo,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: theme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      encuesta.descripcion.isNotEmpty
                          ? encuesta.descripcion
                          : '${encuesta.preguntas.length} preguntas',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: theme.secondaryText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF265294).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${encuesta.preguntas.length}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF265294),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right,
                  color: theme.secondaryText, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
