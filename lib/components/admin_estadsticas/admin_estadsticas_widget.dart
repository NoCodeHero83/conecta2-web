import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../admin_estadsticas2_model.dart';
import 'common/app_card.dart';
import 'common/section_title.dart';
import 'helpers/stats_calculator.dart';
import 'widgets/chart_alertas_edad.dart';
import 'widgets/chart_alertas_genero.dart';
import 'widgets/chart_distribucion_niveles.dart';
import 'widgets/chart_grado.dart';
import 'widgets/chart_heatmap.dart';
import 'widgets/chart_por_edad.dart';
import 'widgets/chart_por_genero.dart';
import 'widgets/rango_fechas_selector.dart';
import 'widgets/selector_colegio.dart';
import 'widgets/selector_encuesta.dart';
import 'widgets/selector_tipo_tamizaje.dart';
import 'widgets/stats_filters.dart';
import 'widgets/stats_kpi_cards.dart';

export '../admin_estadsticas2_model.dart';

class AdminEstadsticas2Widget extends StatefulWidget {
  const AdminEstadsticas2Widget({super.key});

  @override
  State<AdminEstadsticas2Widget> createState() =>
      _AdminEstadsticas2WidgetState();
}

class _AdminEstadsticas2WidgetState extends State<AdminEstadsticas2Widget> {
  late AdminEstadsticas2Model _model;

  TamizajeTipo _tipoSeleccionado = TamizajeTipo.todas;
  DateTimeRange? _rangoFechas;
  DocumentReference? _encuestaSeleccionada;
  Future<StatsAggregates>? _statsFuture;
  bool _mostrarVistaGeneral = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminEstadsticas2Model());
    _refreshStats();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _refreshStats() {
    _statsFuture = loadStats(
      _tipoSeleccionado,
      colegio: _model.filtroColegio.isEmpty ? null : _model.filtroColegio,
      rango: _rangoFechas,
      encuestaRef: _encuestaSeleccionada,
    );
  }

  @override
  void dispose() {
    _model.dropDownTamizajValueController?.reset();
    _model.dropDownTamizajValue = null;
    _model.textFieldColegioValueController?.reset();
    _model.textFieldColegioValue = null;
    _model.dropDownNivelValueController?.reset();
    _model.dropDownNivelValue = null;
    _model.dropDownSustanciaValueController?.reset();
    _model.dropDownSustanciaValue = null;

    _model.maybeDispose();
    super.dispose();
  }

  void _onFiltersChanged() => safeSetState(_refreshStats);

  void _onTipoChanged(TamizajeTipo tipo) {
    setState(() {
      _tipoSeleccionado = tipo;
      _encuestaSeleccionada = null;
      _refreshStats();
    });
  }

  void _onEncuestaChanged(DocumentReference? ref) {
    setState(() {
      _encuestaSeleccionada = ref;
      _refreshStats();
    });
  }

  void _onRangoChanged(DateTimeRange? rango) {
    setState(() {
      _rangoFechas = rango;
      _refreshStats();
    });
  }

  void _onColegioChanged(String? colegio) {
    setState(() {
      _model.filtroColegio = colegio ?? '';
      _model.textFieldColegioValue = colegio;
      _refreshStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(color: theme.primaryBackground),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: 28),
              const SectionTitle(
                title: 'Reportes por tipo de tamizaje',
                subtitle:
                    'Distribución de alertas por género, edad y nivel de severidad.',
              ),
              const SizedBox(height: 16),
              _buildReportesToolbar(),
              const SizedBox(height: 20),
              _buildStatsSection(),
              const SizedBox(height: 40),
              Divider(color: theme.alternate, height: 1),
              const SizedBox(height: 20),
              _buildVistaGeneralToggle(),
              if (_mostrarVistaGeneral) _buildVistaGeneral(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportesToolbar() {
    final colegioSel =
        _model.filtroColegio.isEmpty ? null : _model.filtroColegio;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SelectorTipoTamizaje(
          selected: _tipoSeleccionado,
          onChanged: _onTipoChanged,
        ),
        RangoFechasSelector(
          rango: _rangoFechas,
          onChanged: _onRangoChanged,
        ),
        SelectorColegio(
          seleccionado: colegioSel,
          onChanged: _onColegioChanged,
        ),
        SelectorEncuesta(
          tipo: _tipoSeleccionado,
          seleccionada: _encuestaSeleccionada,
          onChanged: _onEncuestaChanged,
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return FutureBuilder<StatsAggregates>(
      future: _statsFuture,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        final stats = snap.data ?? StatsAggregates.empty(_tipoSeleccionado);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsKpiCards(stats: stats),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 980;
                if (!wide) {
                  return Column(
                    children: [
                      ChartPorGenero(stats: stats),
                      const SizedBox(height: 16),
                      ChartPorEdad(stats: stats),
                      const SizedBox(height: 16),
                      ChartDistribucionNiveles(stats: stats),
                    ],
                  );
                }
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: ChartPorGenero(stats: stats)),
                        const SizedBox(width: 16),
                        Expanded(child: ChartPorEdad(stats: stats)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: ChartDistribucionNiveles(stats: stats)),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildVistaGeneral() {
    final items = <Widget>[
      StatsFilters(model: _model, onChanged: _onFiltersChanged),
      ChartAlertasEdad(model: _model),
      ChartAlertasGenero(model: _model),
      ChartGrado(model: _model),
      ChartHeatmap(model: _model),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const SectionTitle(
          title: 'Vista general',
          subtitle: 'Filtros adicionales por nivel de riesgo y sustancia.',
        ),
        const SizedBox(height: 16),
        for (final item in items) ...[
          AppCard(child: item),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildVistaGeneralToggle() {
    final theme = FlutterFlowTheme.of(context);
    return InkWell(
      onTap: () =>
          setState(() => _mostrarVistaGeneral = !_mostrarVistaGeneral),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _mostrarVistaGeneral
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: theme.accent2,
            ),
            const SizedBox(width: 6),
            Text(
              _mostrarVistaGeneral
                  ? 'Ocultar vista general'
                  : 'Ver vista general',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.accent2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final titleLarge = FlutterFlowTheme.of(context).titleLarge;
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Estadísticas',
              style: titleLarge.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle: titleLarge.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: AuthUserStreamWidget(
                          builder: (context) => ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: _userPhoto(currentUserPhoto),
                          ),
                        ),
                      ),
                      AuthUserStreamWidget(
                        builder: (context) => Text(
                          currentUserDisplayName,
                          style: bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: bodyMedium.fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ].divide(const SizedBox(width: 25.0)),
          ),
        ],
      ),
    );
  }

  Widget _userPhoto(String url) {
    if (url.isEmpty) {
      return Image.asset(
        'assets/images/User.png',
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      imageUrl: url,
      width: 30,
      height: 30,
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => Image.asset(
        'assets/images/User.png',
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      ),
    );
  }
}
