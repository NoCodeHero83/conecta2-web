// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RespuestaTestStruct extends FFFirebaseStruct {
  RespuestaTestStruct({
    String? pregunta,
    String? tipo,
    int? nPregunta,
    String? respuesta,
    DocumentReference? userRef,
    int? trueAndFalse,
    List<String>? respuestaSelection,
    List<int>? select,
    String? select2,
    List<String>? respuestasSeleccionadas,
    List<String>? rSeleccionUnica,
    String? respuestaSeleccionUnica,
    List<AtributosStruct>? respuestaTamizaje,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _pregunta = pregunta,
        _tipo = tipo,
        _nPregunta = nPregunta,
        _respuesta = respuesta,
        _userRef = userRef,
        _trueAndFalse = trueAndFalse,
        _respuestaSelection = respuestaSelection,
        _select = select,
        _select2 = select2,
        _respuestasSeleccionadas = respuestasSeleccionadas,
        _rSeleccionUnica = rSeleccionUnica,
        _respuestaSeleccionUnica = respuestaSeleccionUnica,
        _respuestaTamizaje = respuestaTamizaje,
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

  // "NPregunta" field.
  int? _nPregunta;
  int get nPregunta => _nPregunta ?? 0;
  set nPregunta(int? val) => _nPregunta = val;

  void incrementNPregunta(int amount) => nPregunta = nPregunta + amount;

  bool hasNPregunta() => _nPregunta != null;

  // "Respuesta" field.
  String? _respuesta;
  String get respuesta => _respuesta ?? '';
  set respuesta(String? val) => _respuesta = val;

  bool hasRespuesta() => _respuesta != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "TrueAndFalse" field.
  int? _trueAndFalse;
  int get trueAndFalse => _trueAndFalse ?? 0;
  set trueAndFalse(int? val) => _trueAndFalse = val;

  void incrementTrueAndFalse(int amount) =>
      trueAndFalse = trueAndFalse + amount;

  bool hasTrueAndFalse() => _trueAndFalse != null;

  // "RespuestaSelection" field.
  List<String>? _respuestaSelection;
  List<String> get respuestaSelection => _respuestaSelection ?? const [];
  set respuestaSelection(List<String>? val) => _respuestaSelection = val;

  void updateRespuestaSelection(Function(List<String>) updateFn) {
    updateFn(_respuestaSelection ??= []);
  }

  bool hasRespuestaSelection() => _respuestaSelection != null;

  // "Select" field.
  List<int>? _select;
  List<int> get select => _select ?? const [];
  set select(List<int>? val) => _select = val;

  void updateSelect(Function(List<int>) updateFn) {
    updateFn(_select ??= []);
  }

  bool hasSelect() => _select != null;

  // "Select2" field.
  String? _select2;
  String get select2 => _select2 ?? '';
  set select2(String? val) => _select2 = val;

  bool hasSelect2() => _select2 != null;

  // "RespuestasSeleccionadas" field.
  List<String>? _respuestasSeleccionadas;
  List<String> get respuestasSeleccionadas =>
      _respuestasSeleccionadas ?? const [];
  set respuestasSeleccionadas(List<String>? val) =>
      _respuestasSeleccionadas = val;

  void updateRespuestasSeleccionadas(Function(List<String>) updateFn) {
    updateFn(_respuestasSeleccionadas ??= []);
  }

  bool hasRespuestasSeleccionadas() => _respuestasSeleccionadas != null;

  // "RSeleccionUnica" field.
  List<String>? _rSeleccionUnica;
  List<String> get rSeleccionUnica => _rSeleccionUnica ?? const [];
  set rSeleccionUnica(List<String>? val) => _rSeleccionUnica = val;

  void updateRSeleccionUnica(Function(List<String>) updateFn) {
    updateFn(_rSeleccionUnica ??= []);
  }

  bool hasRSeleccionUnica() => _rSeleccionUnica != null;

  // "RespuestaSeleccionUnica" field.
  String? _respuestaSeleccionUnica;
  String get respuestaSeleccionUnica => _respuestaSeleccionUnica ?? '';
  set respuestaSeleccionUnica(String? val) => _respuestaSeleccionUnica = val;

  bool hasRespuestaSeleccionUnica() => _respuestaSeleccionUnica != null;

  // "RespuestaTamizaje" field.
  List<AtributosStruct>? _respuestaTamizaje;
  List<AtributosStruct> get respuestaTamizaje => _respuestaTamizaje ?? const [];
  set respuestaTamizaje(List<AtributosStruct>? val) => _respuestaTamizaje = val;

  void updateRespuestaTamizaje(Function(List<AtributosStruct>) updateFn) {
    updateFn(_respuestaTamizaje ??= []);
  }

  bool hasRespuestaTamizaje() => _respuestaTamizaje != null;

  static RespuestaTestStruct fromMap(Map<String, dynamic> data) =>
      RespuestaTestStruct(
        pregunta: castToType<String>(data['Pregunta']),
        tipo: castToType<String>(data['Tipo']),
        nPregunta: castToType<int>(data['NPregunta']),
        respuesta: castToType<String>(data['Respuesta']),
        userRef: data['user_ref'] as DocumentReference?,
        trueAndFalse: castToType<int>(data['TrueAndFalse']),
        respuestaSelection: getDataList(data['RespuestaSelection']),
        select: getDataList(data['Select']),
        select2: castToType<String>(data['Select2']),
        respuestasSeleccionadas: getDataList(data['RespuestasSeleccionadas']),
        rSeleccionUnica: getDataList(data['RSeleccionUnica']),
        respuestaSeleccionUnica: castToType<String>(data['RespuestaSeleccionUnica']),
        respuestaTamizaje: getStructList(
          data['RespuestaTamizaje'],
          AtributosStruct.fromMap,
        ),
      );

  static RespuestaTestStruct? maybeFromMap(dynamic data) => data is Map
      ? RespuestaTestStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Pregunta': _pregunta,
        'Tipo': _tipo,
        'NPregunta': _nPregunta,
        'Respuesta': _respuesta,
        'user_ref': _userRef,
        'TrueAndFalse': _trueAndFalse,
        'RespuestaSelection': _respuestaSelection,
        'Select': _select,
        'Select2': _select2,
        'RespuestasSeleccionadas': _respuestasSeleccionadas,
        'RSeleccionUnica': _rSeleccionUnica,
        'RespuestaSeleccionUnica': _respuestaSeleccionUnica,
        'RespuestaTamizaje': _respuestaTamizaje?.map((e) => e.toMap()).toList(),
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
        'NPregunta': serializeParam(
          _nPregunta,
          ParamType.int,
        ),
        'Respuesta': serializeParam(
          _respuesta,
          ParamType.String,
        ),
        'user_ref': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'TrueAndFalse': serializeParam(
          _trueAndFalse,
          ParamType.int,
        ),
        'RespuestaSelection': serializeParam(
          _respuestaSelection,
          ParamType.String,
          isList: true,
        ),
        'Select': serializeParam(
          _select,
          ParamType.int,
          isList: true,
        ),
        'Select2': serializeParam(
          _select2,
          ParamType.String,
        ),
        'RespuestasSeleccionadas': serializeParam(
          _respuestasSeleccionadas,
          ParamType.String,
          isList: true,
        ),
        'RSeleccionUnica': serializeParam(
          _rSeleccionUnica,
          ParamType.String,
          isList: true,
        ),
        'RespuestaSeleccionUnica': serializeParam(
          _respuestaSeleccionUnica,
          ParamType.String,
        ),
        'RespuestaTamizaje': serializeParam(
          _respuestaTamizaje,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static RespuestaTestStruct fromSerializableMap(Map<String, dynamic> data) =>
      RespuestaTestStruct(
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
        nPregunta: deserializeParam(
          data['NPregunta'],
          ParamType.int,
          false,
        ),
        respuesta: deserializeParam(
          data['Respuesta'],
          ParamType.String,
          false,
        ),
        userRef: deserializeParam(
          data['user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        trueAndFalse: deserializeParam(
          data['TrueAndFalse'],
          ParamType.int,
          false,
        ),
        respuestaSelection: deserializeParam<String>(
          data['RespuestaSelection'],
          ParamType.String,
          true,
        ),
        select: deserializeParam<int>(
          data['Select'],
          ParamType.int,
          true,
        ),
        select2: deserializeParam(
          data['Select2'],
          ParamType.String,
          false,
        ),
        respuestasSeleccionadas: deserializeParam<String>(
          data['RespuestasSeleccionadas'],
          ParamType.String,
          true,
        ),
        rSeleccionUnica: deserializeParam<String>(
          data['RSeleccionUnica'],
          ParamType.String,
          true,
        ),
        respuestaSeleccionUnica: deserializeParam(
          data['RespuestaSeleccionUnica'],
          ParamType.String,
          false,
        ),
        respuestaTamizaje: deserializeStructParam<AtributosStruct>(
          data['RespuestaTamizaje'],
          ParamType.DataStruct,
          true,
          structBuilder: AtributosStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RespuestaTestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RespuestaTestStruct &&
        pregunta == other.pregunta &&
        tipo == other.tipo &&
        nPregunta == other.nPregunta &&
        respuesta == other.respuesta &&
        userRef == other.userRef &&
        trueAndFalse == other.trueAndFalse &&
        listEquality.equals(respuestaSelection, other.respuestaSelection) &&
        listEquality.equals(select, other.select) &&
        select2 == other.select2 &&
        listEquality.equals(
            respuestasSeleccionadas, other.respuestasSeleccionadas) &&
        listEquality.equals(rSeleccionUnica, other.rSeleccionUnica) &&
        respuestaSeleccionUnica == other.respuestaSeleccionUnica &&
        listEquality.equals(respuestaTamizaje, other.respuestaTamizaje);
  }

  @override
  int get hashCode => const ListEquality().hash([
        pregunta,
        tipo,
        nPregunta,
        respuesta,
        userRef,
        trueAndFalse,
        respuestaSelection,
        select,
        select2,
        respuestasSeleccionadas,
        rSeleccionUnica,
        respuestaSeleccionUnica,
        respuestaTamizaje
      ]);
}

RespuestaTestStruct createRespuestaTestStruct({
  String? pregunta,
  String? tipo,
  int? nPregunta,
  String? respuesta,
  DocumentReference? userRef,
  int? trueAndFalse,
  String? select2,
  String? respuestaSeleccionUnica,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RespuestaTestStruct(
      pregunta: pregunta,
      tipo: tipo,
      nPregunta: nPregunta,
      respuesta: respuesta,
      userRef: userRef,
      trueAndFalse: trueAndFalse,
      select2: select2,
      respuestaSeleccionUnica: respuestaSeleccionUnica,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RespuestaTestStruct? updateRespuestaTestStruct(
  RespuestaTestStruct? respuestaTest, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    respuestaTest
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRespuestaTestStructData(
  Map<String, dynamic> firestoreData,
  RespuestaTestStruct? respuestaTest,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (respuestaTest == null) {
    return;
  }
  if (respuestaTest.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && respuestaTest.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final respuestaTestData =
      getRespuestaTestFirestoreData(respuestaTest, forFieldValue);
  final nestedData =
      respuestaTestData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = respuestaTest.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRespuestaTestFirestoreData(
  RespuestaTestStruct? respuestaTest, [
  bool forFieldValue = false,
]) {
  if (respuestaTest == null) {
    return {};
  }
  final firestoreData = mapToFirestore(respuestaTest.toMap());

  // Add any Firestore field values
  respuestaTest.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRespuestaTestListFirestoreData(
  List<RespuestaTestStruct>? respuestaTests,
) =>
    respuestaTests
        ?.map((e) => getRespuestaTestFirestoreData(e, true))
        .toList() ??
    [];
