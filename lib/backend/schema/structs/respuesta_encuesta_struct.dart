// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RespuestaEncuestaStruct extends FFFirebaseStruct {
  RespuestaEncuestaStruct({
    String? pregunta,
    String? tipo,
    int? nPregunta,
    String? respuesta,
    DocumentReference? userRef,
    String? respuestaSelection,
    String? trueAndFalse,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _pregunta = pregunta,
        _tipo = tipo,
        _nPregunta = nPregunta,
        _respuesta = respuesta,
        _userRef = userRef,
        _respuestaSelection = respuestaSelection,
        _trueAndFalse = trueAndFalse,
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

  // "RespuestaSelection" field.
  String? _respuestaSelection;
  String get respuestaSelection => _respuestaSelection ?? '';
  set respuestaSelection(String? val) => _respuestaSelection = val;

  bool hasRespuestaSelection() => _respuestaSelection != null;

  // "TrueAndFalse" field.
  String? _trueAndFalse;
  String get trueAndFalse => _trueAndFalse ?? '';
  set trueAndFalse(String? val) => _trueAndFalse = val;

  bool hasTrueAndFalse() => _trueAndFalse != null;

  static RespuestaEncuestaStruct fromMap(Map<String, dynamic> data) =>
      RespuestaEncuestaStruct(
        pregunta: castToType<String>(data['Pregunta']),
        tipo: castToType<String>(data['Tipo']),
        nPregunta: castToType<int>(data['NPregunta']),
        respuesta: castToType<String>(data['Respuesta']),
        userRef: data['user_ref'] as DocumentReference?,
        respuestaSelection: castToType<String>(data['RespuestaSelection']),
        trueAndFalse: castToType<String>(data['TrueAndFalse']),
      );

  static RespuestaEncuestaStruct? maybeFromMap(dynamic data) => data is Map
      ? RespuestaEncuestaStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Pregunta': _pregunta,
        'Tipo': _tipo,
        'NPregunta': _nPregunta,
        'Respuesta': _respuesta,
        'user_ref': _userRef,
        'RespuestaSelection': _respuestaSelection,
        'TrueAndFalse': _trueAndFalse,
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
        'RespuestaSelection': serializeParam(
          _respuestaSelection,
          ParamType.String,
        ),
        'TrueAndFalse': serializeParam(
          _trueAndFalse,
          ParamType.String,
        ),
      }.withoutNulls;

  static RespuestaEncuestaStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RespuestaEncuestaStruct(
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
        respuestaSelection: deserializeParam(
          data['RespuestaSelection'],
          ParamType.String,
          false,
        ),
        trueAndFalse: deserializeParam(
          data['TrueAndFalse'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RespuestaEncuestaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RespuestaEncuestaStruct &&
        pregunta == other.pregunta &&
        tipo == other.tipo &&
        nPregunta == other.nPregunta &&
        respuesta == other.respuesta &&
        userRef == other.userRef &&
        respuestaSelection == other.respuestaSelection &&
        trueAndFalse == other.trueAndFalse;
  }

  @override
  int get hashCode => const ListEquality().hash([
        pregunta,
        tipo,
        nPregunta,
        respuesta,
        userRef,
        respuestaSelection,
        trueAndFalse
      ]);
}

RespuestaEncuestaStruct createRespuestaEncuestaStruct({
  String? pregunta,
  String? tipo,
  int? nPregunta,
  String? respuesta,
  DocumentReference? userRef,
  String? respuestaSelection,
  String? trueAndFalse,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RespuestaEncuestaStruct(
      pregunta: pregunta,
      tipo: tipo,
      nPregunta: nPregunta,
      respuesta: respuesta,
      userRef: userRef,
      respuestaSelection: respuestaSelection,
      trueAndFalse: trueAndFalse,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RespuestaEncuestaStruct? updateRespuestaEncuestaStruct(
  RespuestaEncuestaStruct? respuestaEncuesta, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    respuestaEncuesta
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRespuestaEncuestaStructData(
  Map<String, dynamic> firestoreData,
  RespuestaEncuestaStruct? respuestaEncuesta,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (respuestaEncuesta == null) {
    return;
  }
  if (respuestaEncuesta.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && respuestaEncuesta.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final respuestaEncuestaData =
      getRespuestaEncuestaFirestoreData(respuestaEncuesta, forFieldValue);
  final nestedData =
      respuestaEncuestaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = respuestaEncuesta.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRespuestaEncuestaFirestoreData(
  RespuestaEncuestaStruct? respuestaEncuesta, [
  bool forFieldValue = false,
]) {
  if (respuestaEncuesta == null) {
    return {};
  }
  final firestoreData = mapToFirestore(respuestaEncuesta.toMap());

  // Add any Firestore field values
  respuestaEncuesta.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRespuestaEncuestaListFirestoreData(
  List<RespuestaEncuestaStruct>? respuestaEncuestas,
) =>
    respuestaEncuestas
        ?.map((e) => getRespuestaEncuestaFirestoreData(e, true))
        .toList() ??
    [];
