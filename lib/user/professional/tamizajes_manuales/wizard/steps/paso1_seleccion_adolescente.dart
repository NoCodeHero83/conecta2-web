import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/registrar_adolescente_sheet.dart';

/// Wizard step 1: select (or register) an adolescent.
class PasoSeleccionAdolescente extends StatefulWidget {
  const PasoSeleccionAdolescente({super.key, required this.onSeleccionado});
  final ValueChanged<UsersRecord> onSeleccionado;

  @override
  State<PasoSeleccionAdolescente> createState() =>
      _PasoSeleccionAdolescenteState();
}

class _PasoSeleccionAdolescenteState extends State<PasoSeleccionAdolescente> {
  String _filtro = '';

  Future<void> _abrirRegistrarNuevo() async {
    final nuevo = await showModalBottomSheet<UsersRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BottomSheetRegistrarAdolescente(),
    );
    if (nuevo != null) widget.onSeleccionado(nuevo);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final profesionalRef = currentUserReference;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u00bfA qui\u00e9n est\u00e1s encuestando?',
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
              hintText: 'Buscar adolescente...',
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
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _abrirRegistrarNuevo,
              icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
              label: Text(
                'Registrar nuevo adolescente',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 14),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF265294),
                side: const BorderSide(color: Color(0xFF265294)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: profesionalRef == null
                ? Center(
                    child:
                        Text('Sin sesi\u00f3n', style: theme.bodyMedium))
                : StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(
                      queryBuilder: (q) => q.where(
                        'Profesionales.Ref',
                        isEqualTo: profesionalRef,
                      ),
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
                                'Error al cargar adolescentes',
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
                      final filtrados = data.where((u) {
                        final n = u.displayName.toLowerCase();
                        return n.contains(_filtro.toLowerCase());
                      }).toList();
                      if (filtrados.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                  data.isEmpty
                                      ? Icons.people_outline
                                      : Icons.search_off,
                                  size: 48,
                                  color: theme.alternate),
                              const SizedBox(height: 8),
                              Text(
                                data.isEmpty
                                    ? 'No hay adolescentes asignados'
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
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, i) {
                          final u = filtrados[i];
                          return _AdolescenteCard(
                            user: u,
                            theme: theme,
                            onTap: () => widget.onSeleccionado(u),
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

class _AdolescenteCard extends StatelessWidget {
  const _AdolescenteCard({
    required this.user,
    required this.theme,
    required this.onTap,
  });
  final UsersRecord user;
  final FlutterFlowTheme theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initial = user.displayName.isNotEmpty
        ? user.displayName[0].toUpperCase()
        : '?';
    return Material(
      color: theme.secondaryBackground,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    const Color(0xFF265294).withValues(alpha: 0.12),
                child: Text(
                  initial,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF265294),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName.isNotEmpty
                          ? user.displayName
                          : user.email,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: theme.primaryText,
                      ),
                    ),
                    if (user.email.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          user.email,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: theme.secondaryText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.secondaryText, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
