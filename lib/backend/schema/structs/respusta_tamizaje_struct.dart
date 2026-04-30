// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RespustaTamizajeStruct extends FFFirebaseStruct {
  RespustaTamizajeStruct({
    String? pregunta,
    String? tipo,
    int? nPregunta,
    String? respuesta,
    DocumentReference? userRef,
    int? trueAndFalse,
    List<String>? respuestaSelection,
    List<int>? select,
    String? select2,
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

  static RespustaTamizajeStruct fromMap(Map<String, dynamic> data) =>
      RespustaTamizajeStruct(
        pregunta: data['Pregunta'] as String?,
        tipo: data['Tipo'] as String?,
        nPregunta: castToType<int>(data['NPregunta']),
        respuesta: data['Respuesta'] as String?,
        userRef: data['user_ref'] as DocumentReference?,
        trueAndFalse: castToType<int>(data['TrueAndFalse']),
        respuestaSelection: getDataList(data['RespuestaSelection']),
        select: getDataList(data['Select']),
        select2: data['Select2'] as String?,
      );

  static RespustaTamizajeStruct? maybeFromMap(dynamic data) => data is Map
      ? RespustaTamizajeStruct.fromMap(data.cast<String, dynamic>())
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
      }.withoutNulls;

  static RespustaTamizajeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RespustaTamizajeStruct(
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
      );

  @override
  String toString() => 'RespustaTamizajeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RespustaTamizajeStruct &&
        pregunta == other.pregunta &&
        tipo == other.tipo &&
        nPregunta == other.nPregunta &&
        respuesta == other.respuesta &&
        userRef == other.userRef &&
        trueAndFalse == other.trueAndFalse &&
        listEquality.equals(respuestaSelection, other.respuestaSelection) &&
        listEquality.equals(select, other.select) &&
        select2 == other.select2;
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
        select2
      ]);
}

RespustaTamizajeStruct createRespustaTamizajeStruct({
  String? pregunta,
  String? tipo,
  int? nPregunta,
  String? respuesta,
  DocumentReference? userRef,
  int? trueAndFalse,
  String? select2,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RespustaTamizajeStruct(
      pregunta: pregunta,
      tipo: tipo,
      nPregunta: nPregunta,
      respuesta: respuesta,
      userRef: userRef,
      trueAndFalse: trueAndFalse,
      select2: select2,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RespustaTamizajeStruct? updateRespustaTamizajeStruct(
  RespustaTamizajeStruct? respustaTamizaje, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    respustaTamizaje
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRespustaTamizajeStructData(
  Map<String, dynamic> firestoreData,
  RespustaTamizajeStruct? respustaTamizaje,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (respustaTamizaje == null) {
    return;
  }
  if (respustaTamizaje.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && respustaTamizaje.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final respustaTamizajeData =
      getRespustaTamizajeFirestoreData(respustaTamizaje, forFieldValue);
  final nestedData =
      respustaTamizajeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = respustaTamizaje.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRespustaTamizajeFirestoreData(
  RespustaTamizajeStruct? respustaTamizaje, [
  bool forFieldValue = false,
]) {
  if (respustaTamizaje == null) {
    return {};
  }
  final firestoreData = mapToFirestore(respustaTamizaje.toMap());

  // Add any Firestore field values
  respustaTamizaje.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRespustaTamizajeListFirestoreData(
  List<RespustaTamizajeStruct>? respustaTamizajes,
) =>
    respustaTamizajes
        ?.map((e) => getRespustaTamizajeFirestoreData(e, true))
        .toList() ??
    [];
