// Generates a test PDF populated with hard-coded dummy data that mirrors the
// Niños de Papel reference report (MARITZA REGINO MONTERROSA). Useful for
// visual QA of the branded layout without needing real Firestore data.

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'builders/pdf_factores_alerta.dart';
import 'builders/pdf_footer.dart';
import 'builders/pdf_header.dart';
import 'builders/pdf_observaciones.dart';
import 'builders/pdf_tamizajes_section.dart';
import 'builders/pdf_user_info.dart';

const String _kLoremObservaciones =
    'Lorem ipsum dolor sit amet consectetur. Urna ornare consectetur justo '
    'pharetra scelerisque. Lacus at eget ipsum phasellus. Massa nulla nisl '
    'at nulla. Cursus fermentum justo massa purus. Vitae cras ligula nibh '
    'egestas facilisi enim. Sit accumsan nam nibh tortor. Dignissim '
    'pharetra pretium mi sit pretium ac sed. Amet pellentesque id sit '
    'neque nam turpis tempus sit blandit.';

Map<String, dynamic> _datosPersonalesPrueba() => <String, dynamic>{
      'nombres': 'MARITZA',
      'apellidos': 'REGINO MONTERROSA',
      'tipoIdentificacion': 'TARJETA DE IDENTIDAD',
      'numeroIdentificacion': '1062977427',
      'edad': '13',
      'genero': 'FEMENINO',
      'municipio': '20 DE JULIO',
      'barrio': '20 DE JULIO',
      'telefono': '3248928885',
      'email': 'NO REGISTRADO',
      'eps': 'CAJACOPI',
      'ocupacion': 'Adolescente',
      'estadoCivil': 'NO ESPECIFICADO',
      'colegio': 'NO REGISTRADO',
      'grado': 'NO REGISTRADO',
      'rol': 'Adolescente',
      'acudienteNombre': 'MARLIS MONTERROSA RUIZ',
      'acudienteTelefono': 'NO REGISTRADO',
      'acudienteCorreo': 'NO REGISTRADO',
      'acudienteParentesco': 'NO REGISTRADO',
      'fechaCreacion': DateTime.now(),
      'ultimaConexion': DateTime.now(),
    };

List<ResultadoTamizaje> _resultadosPrueba() {
  return <ResultadoTamizaje>[
    ResultadoTamizaje(
      titulo: 'CUESTIONARIO DE DEPRESIÓN INFANTIL (CDI)',
      nivelRiesgo: 'SEVERO',
      puntaje: 27,
      subPuntajes: const {'DISFORIA': 15, 'AUTOESTIMA NEGATIVA': 12},
      estado: 'VÁLIDA',
      escalaLabel: 'ESCALA DE DEPRESIÓN:',
      escalaSubtitulo: 'Pc. 96, depresión severa',
      ideacionSuicida: false,
      impactoImportante: false,
      tipoKey: 'cdi',
    ),
    ResultadoTamizaje(
      titulo: 'TEST DE ANSIEDAD DE HAMILTON',
      nivelRiesgo: 'ALTO',
      puntaje: 45,
      subPuntajes: const {},
      estado: 'VÁLIDA',
      escalaLabel: 'ESCALA DE ANSIEDAD:',
      escalaSubtitulo: 'Ansiedad Grave (o Severa)',
      ideacionSuicida: false,
      impactoImportante: false,
      tipoKey: 'hamilton',
    ),
    ResultadoTamizaje(
      titulo: 'ESCALA DE AUTOESTIMA ROSEMBERG',
      nivelRiesgo: 'N/A',
      puntaje: 26,
      subPuntajes: const {},
      estado: 'VÁLIDA',
      escalaLabel: 'ESCALA DE AUTOESTIMA:',
      escalaSubtitulo: 'Autoestima Media',
      ideacionSuicida: false,
      impactoImportante: false,
      tipoKey: 'rosemberg',
    ),
    ResultadoTamizaje(
      titulo: 'SRQ SELF REPORT QUESTIONARE',
      nivelRiesgo: 'SEVERO',
      puntaje: 14,
      subPuntajes: const {
        'SECCIÓN 1': 11,
        'SECCIÓN 2': 3,
        'DEPRESIÓN': 9,
        'ANGUSTIA': 3,
        'PSICOSIS': 2,
        'EPILEPSIA': 0,
        'ALCOHOLISMO': 2,
        'IDEACIÓN SUICIDA': 1,
      },
      estado: 'VÁLIDA',
      escalaLabel: '',
      escalaSubtitulo: '',
      ideacionSuicida: true,
      impactoImportante: true,
      tipoKey: 'srq',
    ),
    ResultadoTamizaje(
      titulo: 'INVENTARIO DE DEPRESIÓN DE BECK (BDI-2)',
      nivelRiesgo: 'ALTO',
      puntaje: 30,
      subPuntajes: const {},
      estado: 'VÁLIDA',
      escalaLabel: 'ESCALA DE DEPRESIÓN:',
      escalaSubtitulo: 'sintomatología depresiva grave',
      ideacionSuicida: true,
      impactoImportante: false,
      tipoKey: 'bdi',
    ),
  ];
}

List<FactorAlerta> _factoresPrueba() {
  return const [
    // Column 1
    FactorAlerta('CONSUMO DE SUSTANCIAS', false),
    FactorAlerta('IDEACIÓN SUICIDA', true),
    FactorAlerta('INTENTO SUICIDA', false),
    FactorAlerta('VIOLENCIA ECONÓMICA', false),
    FactorAlerta('ALTERACIÓN DE PROCESOS COGNITIVOS', false),
    // Column 2
    FactorAlerta('TRANSTORNOS MENTALES', false),
    FactorAlerta('AFECTACIÓN EMOCIONAL', true),
    FactorAlerta('VIOLENCIA INTRAFAMILIAR', false),
    FactorAlerta('ABANDONO FAMILIAR', false),
    FactorAlerta('ALTERACIÓN DE CONDUCTA MOTORA', false),
    // Column 3
    FactorAlerta('TRANSTORNOS MENTALES', false),
    FactorAlerta('CONFLICTO ARMADO', false),
    FactorAlerta('VIOLENCIA SEXUAL', true),
    FactorAlerta('VIOLENCIA INFANTIL', false),
  ];
}

Future<Uint8List> _construirPDFPrueba() async {
  // Fuente Inter para soportar Unicode (• acentos ñ etc.)
  final interRegular = await PdfGoogleFonts.interRegular();
  final interBold = await PdfGoogleFonts.interBold();
  final interItalic = await PdfGoogleFonts.interItalic();

  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(
      base: interRegular,
      bold: interBold,
      italic: interItalic,
    ),
  );

  final datosPersonales = _datosPersonalesPrueba();
  final resultados = _resultadosPrueba();
  final factores = _factoresPrueba();

  final body = <pw.Widget>[
    buildPatientHeaderBlock(datosPersonales),
    pw.SizedBox(height: 6),
    buildContactoBlock(datosPersonales),
    pw.SizedBox(height: 26),
    ...buildTamizajeCards(resultados),
    pw.SizedBox(height: 30),
    buildFactoresAlertaSection(factores: factores),
    pw.SizedBox(height: 34),
    buildObservacionesSection(_kLoremObservaciones),
    pw.SizedBox(height: 68),
    buildSignatureFooter('Gerardo Alejandro Bueno'),
  ];

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 24,
      ),
      header: (pw.Context context) => buildBrandedPageHeader(),
      build: (pw.Context context) => body
          .map((w) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 32),
                child: w,
              ))
          .toList(),
    ),
  );

  return pdf.save();
}

/// Generates a dummy individual report PDF matching the Niños de Papel
/// reference exactly (MARITZA REGINO MONTERROSA) and shows it with the
/// system print dialog.
Future<void> generarPDFPrueba() async {
  final bytes = await _construirPDFPrueba();
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => bytes,
  );
}
