// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PreguntasEncuestaStruct extends FFFirebaseStruct {
  PreguntasEncuestaStruct({
    String? pregunta,
    String? tipo,
    String? respuestaLarga,
    int? nPregunta,
    List<String>? respuestaSelection,
    List<String>? respuestasSeleccionUnica,
    String? respuestaSUnicaCorrecta,
    AtributosStruct? atributos,
    List<AtributosStruct>? respuestaTamizaje,
    String? sustancia,
    List<ValorCondicionanteStruct>? respuestaCondicionante,
    bool? ocultarRespuesta,
    String? variable,
    int? numeroPregunta,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _pregunta = pregunta,
        _tipo = tipo,
        _respuestaLarga = respuestaLarga,
        _nPregunta = nPregunta,
        _respuestaSelection = respuestaSelection,
        _respuestasSeleccionUnica = respuestasSeleccionUnica,
        _respuestaSUnicaCorrecta = respuestaSUnicaCorrecta,
        _atributos = atributos,
        _respuestaTamizaje = respuestaTamizaje,
        _sustancia = sustancia,
        _respuestaCondicionante = respuestaCondicionante,
        _ocultarRespuesta = ocultarRespuesta,
        _variable = variable,
        _numeroPregunta = numeroPregunta,
        super(firestoreUtilData);

  // "Pregunta" field.
  String? _pregunta;
  String get pregunta => _pregunta ?? '';
  set pregunta(String? val) => _pregunta = val;

  bool hasPregunta() => _pregunta != null;

  // "Tipo" field.
  String? _tipo;
  String get tipo => _tipo ?? '';
  set tipo(String? val) => _tipo = val;

  bool hasTipo() => _tipo != null;

  // "Respuesta_larga" field.
  String? _respuestaLarga;
  String get respuestaLarga => _respuestaLarga ?? '';
  set respuestaLarga(String? val) => _respuestaLarga = val;

  bool hasRespuestaLarga() => _respuestaLarga != null;

  // "NPregunta" field.
  int? _nPregunta;
  int get nPregunta => _nPregunta ?? 0;
  set nPregunta(int? val) => _nPregunta = val;

  void incrementNPregunta(int amount) => nPregunta = nPregunta + amount;

  bool hasNPregunta() => _nPregunta != null;

  // "RespuestaSelection" field.
  List<String>? _respuestaSelection;
  List<String> get respuestaSelection => _respuestaSelection ?? const [];
  set respuestaSelection(List<String>? val) => _respuestaSelection = val;

  void updateRespuestaSelection(Function(List<String>) updateFn) {
    updateFn(_respuestaSelection ??= []);
  }

  bool hasRespuestaSelection() => _respuestaSelection != null;

  // "RespuestasSeleccionUnica" field.
  List<String>? _respuestasSeleccionUnica;
  List<String> get respuestasSeleccionUnica =>
      _respuestasSeleccionUnica ?? const [];
  set respuestasSeleccionUnica(List<String>? val) =>
      _respuestasSeleccionUnica = val;

  void updateRespuestasSeleccionUnica(Function(List<String>) updateFn) {
    updateFn(_respuestasSeleccionUnica ??= []);
  }

  bool hasRespuestasSeleccionUnica() => _respuestasSeleccionUnica != null;

  // "RespuestaSUnicaCorrecta" field.
  String? _respuestaSUnicaCorrecta;
  String get respuestaSUnicaCorrecta => _respuestaSUnicaCorrecta ?? '';
  set respuestaSUnicaCorrecta(String? val) => _respuestaSUnicaCorrecta = val;

  bool hasRespuestaSUnicaCorrecta() => _respuestaSUnicaCorrecta != null;

  // "Atributos" field.
  AtributosStruct? _atributos;
  AtributosStruct get atributos => _atributos ?? AtributosStruct();
  set atributos(AtributosStruct? val) => _atributos = val;

  void updateAtributos(Function(AtributosStruct) updateFn) {
    updateFn(_atributos ??= AtributosStruct());
  }

  bool hasAtributos() => _atributos != null;

  // "RespuestaTamizaje" field.
  List<AtributosStruct>? _respuestaTamizaje;
  List<AtributosStruct> get respuestaTamizaje => _respuestaTamizaje ?? const [];
  set respuestaTamizaje(List<AtributosStruct>? val) => _respuestaTamizaje = val;

  void updateRespuestaTamizaje(Function(List<AtributosStruct>) updateFn) {
    updateFn(_respuestaTamizaje ??= []);
  }

  bool hasRespuestaTamizaje() => _respuestaTamizaje != null;

  // "sustancia" field.
  String? _sustancia;
  String get sustancia => _sustancia ?? '';
  set sustancia(String? val) => _sustancia = val;

  bool hasSustancia() => _sustancia != null;

  // "RespuestaCondicionante" field.
  List<ValorCondicionanteStruct>? _respuestaCondicionante;
  List<ValorCondicionanteStruct> get respuestaCondicionante =>
      _respuestaCondicionante ?? const [];
  set respuestaCondicionante(List<ValorCondicionanteStruct>? val) =>
      _respuestaCondicionante = val;

  void updateRespuestaCondicionante(
      Function(List<ValorCondicionanteStruct>) updateFn) {
    updateFn(_respuestaCondicionante ??= []);
  }

  bool hasRespuestaCondicionante() => _respuestaCondicionante != null;

  // "ocultarRespuesta" field.
  bool? _ocultarRespuesta;
  bool get ocultarRespuesta => _ocultarRespuesta ?? false;
  set ocultarRespuesta(bool? val) => _ocultarRespuesta = val;

  bool hasOcultarRespuesta() => _ocultarRespuesta != null;

  // "variable" field.
  String? _variable;
  String get variable => _variable ?? '';
  set variable(String? val) => _variable = val;

  bool hasVariable() => _variable != null;

  // "NumeroPregunta" field.
  int? _numeroPregunta;
  int get numeroPregunta => _numeroPregunta ?? 0;
  set numeroPregunta(int? val) => _numeroPregunta = val;

  void incrementNumeroPregunta(int amount) =>
      numeroPregunta = numeroPregunta + amount;

  bool hasNumeroPregunta() => _numeroPregunta != null;

  static PreguntasEncuestaStruct fromMap(Map<String, dynamic> data) =>
      PreguntasEncuestaStruct(
        pregunta: data['Pregunta'] as String?,
        tipo: data['Tipo'] as String?,
        respuestaLarga: data['Respuesta_larga'] as String?,
        nPregunta: castToType<int>(data['NPregunta']),
        respuestaSelection: getDataList(data['RespuestaSelection']),
        respuestasSeleccionUnica: getDataList(data['RespuestasSeleccionUnica']),
        respuestaSUnicaCorrecta: data['RespuestaSUnicaCorrecta'] as String?,
        atributos: data['Atributos'] is AtributosStruct
            ? data['Atributos']
            : AtributosStruct.maybeFromMap(data['Atributos']),
        respuestaTamizaje: getStructList(
          data['RespuestaTamizaje'],
          AtributosStruct.fromMap,
        ),
        sustancia: data['sustancia'] as String?,
        respuestaCondicionante: getStructList(
          data['RespuestaCondicionante'],
          ValorCondicionanteStruct.fromMap,
        ),
        ocultarRespuesta: data['ocultarRespuesta'] as bool?,
        variable: data['variable'] as String?,
        numeroPregunta: castToType<int>(data['NumeroPregunta']),
      );

  static PreguntasEncuestaStruct? maybeFromMap(dynamic data) => data is Map
      ? PreguntasEncuestaStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Pregunta': _pregunta,
        'Tipo': _tipo,
        'Respuesta_larga': _respuestaLarga,
        'NPregunta': _nPregunta,
        'RespuestaSelection': _respuestaSelection,
        'RespuestasSeleccionUnica': _respuestasSeleccionUnica,
        'RespuestaSUnicaCorrecta': _respuestaSUnicaCorrecta,
        'Atributos': _atributos?.toMap(),
        'RespuestaTamizaje': _respuestaTamizaje?.map((e) => e.toMap()).toList(),
        'sustancia': _sustancia,
        'RespuestaCondicionante':
            _respuestaCondicionante?.map((e) => e.toMap()).toList(),
        'ocultarRespuesta': _ocultarRespuesta,
        'variable': _variable,
        'NumeroPregunta': _numeroPregunta,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Pregunta': serializeParam(
          _pregunta,
          ParamType.String,
        ),
        'Tipo': serializeParam(
          _tipo,
          ParamType.String,
        ),
        'Respuesta_larga': serializeParam(
          _respuestaLarga,
          ParamType.String,
        ),
        'NPregunta': serializeParam(
          _nPregunta,
          ParamType.int,
        ),
        'RespuestaSelection': serializeParam(
          _respuestaSelection,
          ParamType.String,
          isList: true,
        ),
        'RespuestasSeleccionUnica': serializeParam(
          _respuestasSeleccionUnica,
          ParamType.String,
          isList: true,
        ),
        'RespuestaSUnicaCorrecta': serializeParam(
          _respuestaSUnicaCorrecta,
          ParamType.String,
        ),
        'Atributos': serializeParam(
          _atributos,
          ParamType.DataStruct,
        ),
        'RespuestaTamizaje': serializeParam(
          _respuestaTamizaje,
          ParamType.DataStruct,
          isList: true,
        ),
        'sustancia': serializeParam(
          _sustancia,
          ParamType.String,
        ),
        'RespuestaCondicionante': serializeParam(
          _respuestaCondicionante,
          ParamType.DataStruct,
          isList: true,
        ),
        'ocultarRespuesta': serializeParam(
          _ocultarRespuesta,
          ParamType.bool,
        ),
        'variable': serializeParam(
          _variable,
          ParamType.String,
        ),
        'NumeroPregunta': serializeParam(
          _numeroPregunta,
          ParamType.int,
        ),
      }.withoutNulls;

  static PreguntasEncuestaStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PreguntasEncuestaStruct(
        pregunta: deserializeParam(
          data['Pregunta'],
          ParamType.String,
          false,
        ),
        tipo: deserializeParam(
          data['Tipo'],
          ParamType.String,
          false,
        ),
        respuestaLarga: deserializeParam(
          data['Respuesta_larga'],
          ParamType.String,
          false,
        ),
        nPregunta: deserializeParam(
          data['NPregunta'],
          ParamType.int,
          false,
        ),
        respuestaSelection: deserializeParam<String>(
          data['RespuestaSelection'],
          ParamType.String,
          true,
        ),
        respuestasSeleccionUnica: deserializeParam<String>(
          data['RespuestasSeleccionUnica'],
          ParamType.String,
          true,
        ),
        respuestaSUnicaCorrecta: deserializeParam(
          data['RespuestaSUnicaCorrecta'],
          ParamType.String,
          false,
        ),
        atributos: deserializeStructParam(
          data['Atributos'],
          ParamType.DataStruct,
          false,
          structBuilder: AtributosStruct.fromSerializableMap,
        ),
        respuestaTamizaje: deserializeStructParam<AtributosStruct>(
          data['RespuestaTamizaje'],
          ParamType.DataStruct,
          true,
          structBuilder: AtributosStruct.fromSerializableMap,
        ),
        sustancia: deserializeParam(
          data['sustancia'],
          ParamType.String,
          false,
        ),
        respuestaCondicionante:
            deserializeStructParam<ValorCondicionanteStruct>(
          data['RespuestaCondicionante'],
          ParamType.DataStruct,
          true,
          structBuilder: ValorCondicionanteStruct.fromSerializableMap,
        ),
        ocultarRespuesta: deserializeParam(
          data['ocultarRespuesta'],
          ParamType.bool,
          false,
        ),
        variable: deserializeParam(
          data['variable'],
          ParamType.String,
          false,
        ),
        numeroPregunta: deserializeParam(
          data['NumeroPregunta'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'PreguntasEncuestaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PreguntasEncuestaStruct &&
        pregunta == other.pregunta &&
        tipo == other.tipo &&
        respuestaLarga == other.respuestaLarga &&
        nPregunta == other.nPregunta &&
        listEquality.equals(respuestaSelection, other.respuestaSelection) &&
        listEquality.equals(
            respuestasSeleccionUnica, other.respuestasSeleccionUnica) &&
        respuestaSUnicaCorrecta == other.respuestaSUnicaCorrecta &&
        atributos == other.atributos &&
        listEquality.equals(respuestaTamizaje, other.respuestaTamizaje) &&
        sustancia == other.sustancia &&
        listEquality.equals(
            respuestaCondicionante, other.respuestaCondicionante) &&
        ocultarRespuesta == other.ocultarRespuesta &&
        variable == other.variable &&
        numeroPregunta == other.numeroPregunta;
  }

  @override
  int get hashCode => const ListEquality().hash([
        pregunta,
        tipo,
        respuestaLarga,
        nPregunta,
        respuestaSelection,
        respuestasSeleccionUnica,
        respuestaSUnicaCorrecta,
        atributos,
        respuestaTamizaje,
        sustancia,
        respuestaCondicionante,
        ocultarRespuesta,
        variable,
        numeroPregunta,
      ]);
}

PreguntasEncuestaStruct createPreguntasEncuestaStruct({
  String? pregunta,
  String? tipo,
  String? respuestaLarga,
  int? nPregunta,
  String? respuestaSUnicaCorrecta,
  AtributosStruct? atributos,
  String? sustancia,
  bool? ocultarRespuesta,
  String? variable,
  int? numeroPregunta,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PreguntasEncuestaStruct(
      pregunta: pregunta,
      tipo: tipo,
      respuestaLarga: respuestaLarga,
      nPregunta: nPregunta,
      respuestaSUnicaCorrecta: respuestaSUnicaCorrecta,
      atributos: atributos ?? (clearUnsetFields ? AtributosStruct() : null),
      sustancia: sustancia,
      ocultarRespuesta: ocultarRespuesta,
      variable: variable,
      numeroPregunta: numeroPregunta,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PreguntasEncuestaStruct? updatePreguntasEncuestaStruct(
  PreguntasEncuestaStruct? preguntasEncuesta, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    preguntasEncuesta
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPreguntasEncuestaStructData(
  Map<String, dynamic> firestoreData,
  PreguntasEncuestaStruct? preguntasEncuesta,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (preguntasEncuesta == null) {
    return;
  }
  if (preguntasEncuesta.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && preguntasEncuesta.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final preguntasEncuestaData =
      getPreguntasEncuestaFirestoreData(preguntasEncuesta, forFieldValue);
  final nestedData =
      preguntasEncuestaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = preguntasEncuesta.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPreguntasEncuestaFirestoreData(
  PreguntasEncuestaStruct? preguntasEncuesta, [
  bool forFieldValue = false,
]) {
  if (preguntasEncuesta == null) {
    return {};
  }
  final firestoreData = mapToFirestore(preguntasEncuesta.toMap());

  // Handle nested data for "Atributos" field.
  addAtributosStructData(
    firestoreData,
    preguntasEncuesta.hasAtributos() ? preguntasEncuesta.atributos : null,
    'Atributos',
    forFieldValue,
  );

  // Add any Firestore field values
  preguntasEncuesta.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPreguntasEncuestaListFirestoreData(
  List<PreguntasEncuestaStruct>? preguntasEncuestas,
) =>
    preguntasEncuestas
        ?.map((e) => getPreguntasEncuestaFirestoreData(e, true))
        .toList() ??
    [];
