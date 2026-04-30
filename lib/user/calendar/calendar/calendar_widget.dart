import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/calendario/calendario_widget.dart';
import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_model.dart';
export 'calendar_model.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  static String routeName = 'Calendar';
  static String routePath = '/calendar';

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: wrapWithModel(
                  model: _model.headerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: HeaderWidget(
                    showIconBack: false,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 75.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 80.0, 0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Lorem ipsum dolor sit amet consectetur. Vulputate imperdiet. Lorem ipsum dolor sit amet consectetur. Vulputate imperdiet.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font: GoogleFonts.readexPro(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: wrapWithModel(
                                                model: _model.calendarioModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: CalendarioWidget(
                                                  inputDate:
                                                      getCurrentTimestamp,
                                                  initialSelectedDate:
                                                      getCurrentTimestamp,
                                                  userRef:
                                                      currentUserReference!,
                                                  onSelectDateAction:
                                                      (selectedDate) async {
                                                    _model.selectedDate =
                                                        selectedDate;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Upcoming reminders section
                                    FutureBuilder<List<RemindersRecord>>(
                                      future: queryRemindersRecordOnce(
                                        queryBuilder: (q) => q
                                            .where('user',
                                                isEqualTo:
                                                    currentUserReference)
                                            .where('due_date',
                                                isGreaterThanOrEqualTo:
                                                    DateTime.now())
                                            .orderBy('due_date'),
                                      ),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return SizedBox.shrink();
                                        }
                                        final upcomingReminders =
                                            snapshot.data!;
                                        return Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Recordatorios',
                                                style:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Color(
                                                              0xFF1A237E),
                                                          fontSize: 18.0,
                                                          letterSpacing:
                                                              0.0,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                              SizedBox(height: 8.0),
                                              ...upcomingReminders
                                                  .take(5)
                                                  .map(
                                                (reminder) => Padding(
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              8.0),
                                                  child: Container(
                                                    width:
                                                        double.infinity,
                                                    decoration:
                                                        BoxDecoration(
                                                      color: Color(
                                                          0xFFE8EAF6),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  12.0),
                                                      border: Border.all(
                                                        color: Color(
                                                            0xFF1A237E),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  10.0,
                                                                  12.0,
                                                                  10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .notifications_outlined,
                                                            color: Color(
                                                                0xFF1A237E),
                                                            size: 20.0,
                                                          ),
                                                          SizedBox(
                                                              width: 8.0),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  reminder
                                                                      .title,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font:
                                                                            GoogleFonts.outfit(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle:
                                                                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color:
                                                                            Color(0xFF1A237E),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle:
                                                                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                                if (reminder
                                                                    .hasDueDate())
                                                                  Text(
                                                                    dateTimeFormat(
                                                                      "MMMEd",
                                                                      reminder
                                                                          .dueDate!,
                                                                      locale:
                                                                          FFLocalizations.of(context).languageCode,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF5C6BC0),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                          fontStyle:
                                                                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                        ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
