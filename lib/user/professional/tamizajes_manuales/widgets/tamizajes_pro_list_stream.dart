import '/backend/backend.dart';
import '/tamizajes/shared/tamizaje_service.dart';
import '/tamizajes/shared/tamizaje_utils.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import '/tamizajes/shared/widgets/tamizaje_empty_state.dart';
import '/tamizajes/shared/widgets/tamizaje_paginador.dart';
import 'tamizaje_card_mobile.dart';
import 'package:flutter/material.dart';

/// Widget que consume los streams de Firestore y muestra la lista de tamizajes
/// filtrada, ordenada y paginada para el profesional.
class TamizajesProListStream extends StatefulWidget {
  const TamizajesProListStream({
    super.key,
    required this.profesionalRef,
    required this.busqueda,
    required this.ordenDescendente,
    required this.paginaActual,
    required this.onCambiarPagina,
  });

  final DocumentReference profesionalRef;
  final String busqueda;
  final bool ordenDescendente;
  final int paginaActual;
  final ValueChanged<int> onCambiarPagina;

  @override
  State<TamizajesProListStream> createState() =>
      _TamizajesProListStreamState();
}

class _TamizajesProListStreamState extends State<TamizajesProListStream> {
  late final Stream<List<UsersRecord>> _adolescentesStream;
  late final Stream<List<RespuestasRecord>> _respuestasStream;

  @override
  void initState() {
    super.initState();
    _adolescentesStream =
        TamizajeService.adolescentesAsignados(widget.profesionalRef);
    _respuestasStream = TamizajeService.todasLasRespuestas();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
      stream: _adolescentesStream,
      builder: (context, asignSnap) {
        if (asignSnap.hasError) {
          return const _MobileEmptyState(
            icon: Icons.error_outline,
            mensaje: 'Error al cargar asignaciones',
          );
        }
        if (asignSnap.connectionState == ConnectionState.waiting &&
            !asignSnap.hasData) {
          return const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kNavy),
              ),
            ),
          );
        }

        final asignados = asignSnap.data ?? <UsersRecord>[];
        if (asignados.isEmpty) {
          return const _MobileEmptyState(
            icon: Icons.group_off_outlined,
            mensaje: 'No tiene adolescentes asignados',
          );
        }

        final asignadosByRef = TamizajeService.buildAsignadosMap(asignados);

        return StreamBuilder<List<RespuestasRecord>>(
          stream: _respuestasStream,
          builder: (context, snap) {
            if (snap.hasError) {
              return const _MobileEmptyState(
                icon: Icons.error_outline,
                mensaje: 'Error al cargar tamizajes',
              );
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kNavy),
                  ),
                ),
              );
            }

            // Filtrar, buscar, ordenar
            var tamizajes = TamizajeService.filtrarPorAsignados(
                snap.data ?? [], asignadosByRef);
            tamizajes = TamizajeService.filtrarPorBusqueda(
                tamizajes, widget.busqueda, asignadosByRef);
            TamizajeService.ordenarPorFecha(tamizajes,
                descendente: widget.ordenDescendente);

            if (tamizajes.isEmpty) {
              return const _MobileEmptyState(
                icon: Icons.inbox_outlined,
                mensaje: 'No hay tamizajes que coincidan',
              );
            }

            // Paginar
            final result =
                TamizajeService.paginar(tamizajes, widget.paginaActual);

            return Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: result.pagina.length,
                  itemBuilder: (context, index) {
                    final r = result.pagina[index];
                    final adolescente = asignadosByRef[adolescenteRef(r)];
                    return TamizajeCardMobile(
                      respuesta: r,
                      adolescente: adolescente,
                    );
                  },
                ),
                if (result.totalPaginas > 1)
                  TamizajePaginador(
                    paginaActual: widget.paginaActual,
                    totalPaginas: result.totalPaginas,
                    totalRegistros: tamizajes.length,
                    onCambiarPagina: widget.onCambiarPagina,
                    style: PaginadorStyle.mobile,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

/// Empty state específico del estilo mobile (con hint "Nuevo").
class _MobileEmptyState extends StatelessWidget {
  const _MobileEmptyState({required this.icon, required this.mensaje});
  final IconData icon;
  final String mensaje;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: TamizajeEmptyState(
        icon: icon,
        mensaje: mensaje,
        submensaje: 'Pulse "Nuevo" para crear un tamizaje',
      ),
    );
  }
}
