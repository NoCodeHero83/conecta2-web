// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AtributosStruct extends FFFirebaseStruct {
  AtributosStruct({
    int? valor,
    String? etiqueta,
    bool? ideacionSuicida,
    int? orden,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _valor = valor,
        _etiqueta = etiqueta,
        _ideacionSuicida = ideacionSuicida,
        _orden = orden,
        super(firestoreUtilData);

  // "valor" field.
  int? _valor;
  int get valor => _valor ?? 0;
  set valor(int? val) => _valor = val;

  void incrementValor(int amount) => valor = valor + amount;

  bool hasValor() => _valor != null;

  // "etiqueta" field.
  String? _etiqueta;
  String get etiqueta => _etiqueta ?? '';
  set etiqueta(String? val) => _etiqueta = val;

  bool hasEtiqueta() => _etiqueta != null;

  // "ideacionSuicida" field.
  bool? _ideacionSuicida;
  bool get ideacionSuicida => _ideacionSuicida ?? false;
  set ideacionSuicida(bool? val) => _ideacionSuicida = val;

  bool hasIdeacionSuicida() => _ideacionSuicida != null;

  // "orden" field.
  int? _orden;
  int get orden => _orden ?? 0;
  set orden(int? val) => _orden = val;

  bool hasOrden() => _orden != null;

  static AtributosStruct fromMap(Map<String, dynamic> data) => AtributosStruct(
        valor: castToType<int>(data['valor']),
        etiqueta: data['etiqueta'] as String?,
        ideacionSuicida: data['ideacionSuicida'] as bool?,
        orden: castToType<int>(data['orden']),
      );

  static AtributosStruct? maybeFromMap(dynamic data) => data is Map
      ? AtributosStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'valor': _valor,
        'etiqueta': _etiqueta,
        'ideacionSuicida': _ideacionSuicida,
        'orden': _orden,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'valor': serializeParam(
          _valor,
          ParamType.int,
        ),
        'etiqueta': serializeParam(
          _etiqueta,
          ParamType.String,
        ),
        'ideacionSuicida': serializeParam(
          _ideacionSuicida,
          ParamType.bool,
        ),
        'orden': serializeParam(
          _orden,
          ParamType.int,
        ),
      }.withoutNulls;

  static AtributosStruct fromSerializableMap(Map<String, dynamic> data) =>
      AtributosStruct(
        valor: deserializeParam(
          data['valor'],
          ParamType.int,
          false,
        ),
        etiqueta: deserializeParam(
          data['etiqueta'],
          ParamType.String,
          false,
        ),
        ideacionSuicida: deserializeParam(
          data['ideacionSuicida'],
          ParamType.bool,
          false,
        ),
        orden: deserializeParam(
          data['orden'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'AtributosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AtributosStruct &&
        valor == other.valor &&
        etiqueta == other.etiqueta &&
        ideacionSuicida == other.ideacionSuicida &&
        orden == other.orden;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([valor, etiqueta, ideacionSuicida, orden]);
}

AtributosStruct createAtributosStruct({
  int? valor,
  String? etiqueta,
  bool? ideacionSuicida,
  int? orden,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AtributosStruct(
      valor: valor,
      etiqueta: etiqueta,
      ideacionSuicida: ideacionSuicida,
      orden: orden,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AtributosStruct? updateAtributosStruct(
  AtributosStruct? atributos, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    atributos
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAtributosStructData(
  Map<String, dynamic> firestoreData,
  AtributosStruct? atributos,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (atributos == null) {
    return;
  }
  if (atributos.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && atributos.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final atributosData = getAtributosFirestoreData(atributos, forFieldValue);
  final nestedData = atributosData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = atributos.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAtributosFirestoreData(
  AtributosStruct? atributos, [
  bool forFieldValue = false,
]) {
  if (atributos == null) {
    return {};
  }
  final firestoreData = mapToFirestore(atributos.toMap());

  // Add any Firestore field values
  atributos.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAtributosListFirestoreData(
  List<AtributosStruct>? atributoss,
) =>
    atributoss?.map((e) => getAtributosFirestoreData(e, true)).toList() ?? [];
