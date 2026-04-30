import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Read-only personal information grid for a patient.
class PacienteInfoSection extends StatelessWidget {
  const PacienteInfoSection({super.key, required this.user});

  final UsersRecord user;

  @override
  Widget build(BuildContext context) {
    final lastConnected = dateTimeFormat(
      "yMMMd",
      user.lastconnectedday,
      locale: FFLocalizations.of(context).languageCode,
    );
    final created = dateTimeFormat(
      "yMMMd",
      user.createdTime,
      locale: FFLocalizations.of(context).languageCode,
    );

    return SingleChildScrollView(
      primary: false,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _row(context, [
            _Field(title: 'Tipo de usuario', value: user.rol),
            _Field(title: 'Nombres y Apellidos', value: user.displayName),
          ]),
          _row(context, [
            _Field(title: 'Correo electrónico', value: user.email),
            _Field(title: 'Celular', value: user.phoneNumber),
          ]),
          _row(context, [
            _Field(title: 'Documento de identidad', value: user.identidad),
            _Field(title: 'Dirección', value: user.address),
          ]),
          _row(context, [
            _Field(title: 'Último día conectado', value: lastConnected),
            _Field(title: 'Fecha de registro', value: created),
          ]),
        ].divide(const SizedBox(height: 16.0)),
      ),
    );
  }

  Widget _row(BuildContext context, List<Widget> children) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: children
          .map<Widget>((c) => Expanded(child: c))
          .toList()
          .divide(const SizedBox(width: 8.0)),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyMedium.override(
            font: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontStyle: bodyMedium.fontStyle,
            ),
            color: const Color(0x7E1F2129),
            fontSize: 14.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w500,
            fontStyle: bodyMedium.fontStyle,
          ),
        ),
        Text(
          valueOrDefault<String>(value, 'null'),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: bodyMedium.override(
            font: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontStyle: bodyMedium.fontStyle,
            ),
            fontSize: 16.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w500,
            fontStyle: bodyMedium.fontStyle,
          ),
        ),
      ],
    );
  }
}
