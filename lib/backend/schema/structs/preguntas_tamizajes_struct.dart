// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PreguntasTamizajesStruct extends FFFirebaseStruct {
  PreguntasTamizajesStruct({
    String? pregunta,
    String? tipo,
    String? respuestaLarga,
    int? nPregunta,
    List<String>? respuestaSelection,
    DocumentReference? userRef,
    int? trueAndFalse,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _pregunta = pregunta,
        _tipo = tipo,
        _respuestaLarga = respuestaLarga,
        _nPregunta = nPregunta,
        _respuestaSelection = respuestaSelection,
        _userRef = userRef,
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

  static PreguntasTamizajesStruct fromMap(Map<String, dynamic> data) =>
      PreguntasTamizajesStruct(
        pregunta: data['Pregunta'] as String?,
        tipo: data['Tipo'] as String?,
        respuestaLarga: data['Respuesta_larga'] as String?,
        nPregunta: castToType<int>(data['NPregunta']),
        respuestaSelection: getDataList(data['RespuestaSelection']),
        userRef: data['user_ref'] as DocumentReference?,
        trueAndFalse: castToType<int>(data['TrueAndFalse']),
      );

  static PreguntasTamizajesStruct? maybeFromMap(dynamic data) => data is Map
      ? PreguntasTamizajesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Pregunta': _pregunta,
        'Tipo': _tipo,
        'Respuesta_larga': _respuestaLarga,
        'NPregunta': _nPregunta,
        'RespuestaSelection': _respuestaSelection,
        'user_ref': _userRef,
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
        'user_ref': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'TrueAndFalse': serializeParam(
          _trueAndFalse,
          ParamType.int,
        ),
      }.withoutNulls;

  static PreguntasTamizajesStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PreguntasTamizajesStruct(
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
      );

  @override
  String toString() => 'PreguntasTamizajesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PreguntasTamizajesStruct &&
        pregunta == other.pregunta &&
        tipo == other.tipo &&
        respuestaLarga == other.respuestaLarga &&
        nPregunta == other.nPregunta &&
        listEquality.equals(respuestaSelection, other.respuestaSelection) &&
        userRef == other.userRef &&
        trueAndFalse == other.trueAndFalse;
  }

  @override
  int get hashCode => const ListEquality().hash([
        pregunta,
        tipo,
        respuestaLarga,
        nPregunta,
        respuestaSelection,
        userRef,
        trueAndFalse
      ]);
}

PreguntasTamizajesStruct createPreguntasTamizajesStruct({
  String? pregunta,
  String? tipo,
  String? respuestaLarga,
  int? nPregunta,
  DocumentReference? userRef,
  int? trueAndFalse,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PreguntasTamizajesStruct(
      pregunta: pregunta,
      tipo: tipo,
      respuestaLarga: respuestaLarga,
      nPregunta: nPregunta,
      userRef: userRef,
      trueAndFalse: trueAndFalse,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PreguntasTamizajesStruct? updatePreguntasTamizajesStruct(
  PreguntasTamizajesStruct? preguntasTamizajes, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    preguntasTamizajes
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPreguntasTamizajesStructData(
  Map<String, dynamic> firestoreData,
  PreguntasTamizajesStruct? preguntasTamizajes,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (preguntasTamizajes == null) {
    return;
  }
  if (preguntasTamizajes.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && preguntasTamizajes.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final preguntasTamizajesData =
      getPreguntasTamizajesFirestoreData(preguntasTamizajes, forFieldValue);
  final nestedData =
      preguntasTamizajesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      preguntasTamizajes.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPreguntasTamizajesFirestoreData(
  PreguntasTamizajesStruct? preguntasTamizajes, [
  bool forFieldValue = false,
]) {
  if (preguntasTamizajes == null) {
    return {};
  }
  final firestoreData = mapToFirestore(preguntasTamizajes.toMap());

  // Add any Firestore field values
  preguntasTamizajes.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPreguntasTamizajesListFirestoreData(
  List<PreguntasTamizajesStruct>? preguntasTamizajess,
) =>
    preguntasTamizajess
        ?.map((e) => getPreguntasTamizajesFirestoreData(e, true))
        .toList() ??
    [];
