// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AlertaStruct extends FFFirebaseStruct {
  AlertaStruct({
    int? min,
    int? max,
    String? sustancia,
    String? nivel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _min = min,
        _max = max,
        _sustancia = sustancia,
        _nivel = nivel,
        super(firestoreUtilData);

  // "min" field.
  int? _min;
  int get min => _min ?? 0;
  set min(int? val) => _min = val;

  void incrementMin(int amount) => min = min + amount;

  bool hasMin() => _min != null;

  // "max" field.
  int? _max;
  int get max => _max ?? 0;
  set max(int? val) => _max = val;

  void incrementMax(int amount) => max = max + amount;

  bool hasMax() => _max != null;

  // "sustancia" field.
  String? _sustancia;
  String get sustancia => _sustancia ?? '';
  set sustancia(String? val) => _sustancia = val;

  bool hasSustancia() => _sustancia != null;

  // "nivel" field.
  String? _nivel;
  String get nivel => _nivel ?? '';
  set nivel(String? val) => _nivel = val;

  bool hasNivel() => _nivel != null;

  static AlertaStruct fromMap(Map<String, dynamic> data) => AlertaStruct(
        min: castToType<int>(data['min']),
        max: castToType<int>(data['max']),
        sustancia: data['sustancia'] as String?,
        nivel: data['nivel'] as String?,
      );

  static AlertaStruct? maybeFromMap(dynamic data) =>
      data is Map ? AlertaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'min': _min,
        'max': _max,
        'sustancia': _sustancia,
        'nivel': _nivel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'min': serializeParam(
          _min,
          ParamType.int,
        ),
        'max': serializeParam(
          _max,
          ParamType.int,
        ),
        'sustancia': serializeParam(
          _sustancia,
          ParamType.String,
        ),
        'nivel': serializeParam(
          _nivel,
          ParamType.String,
        ),
      }.withoutNulls;

  static AlertaStruct fromSerializableMap(Map<String, dynamic> data) =>
      AlertaStruct(
        min: deserializeParam(
          data['min'],
          ParamType.int,
          false,
        ),
        max: deserializeParam(
          data['max'],
          ParamType.int,
          false,
        ),
        sustancia: deserializeParam(
          data['sustancia'],
          ParamType.String,
          false,
        ),
        nivel: deserializeParam(
          data['nivel'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AlertaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AlertaStruct &&
        min == other.min &&
        max == other.max &&
        sustancia == other.sustancia &&
        nivel == other.nivel;
  }

  @override
  int get hashCode => const ListEquality().hash([min, max, sustancia, nivel]);
}

AlertaStruct createAlertaStruct({
  int? min,
  int? max,
  String? sustancia,
  String? nivel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AlertaStruct(
      min: min,
      max: max,
      sustancia: sustancia,
      nivel: nivel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AlertaStruct? updateAlertaStruct(
  AlertaStruct? alerta, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    alerta
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAlertaStructData(
  Map<String, dynamic> firestoreData,
  AlertaStruct? alerta,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (alerta == null) {
    return;
  }
  if (alerta.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && alerta.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final alertaData = getAlertaFirestoreData(alerta, forFieldValue);
  final nestedData = alertaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = alerta.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAlertaFirestoreData(
  AlertaStruct? alerta, [
  bool forFieldValue = false,
]) {
  if (alerta == null) {
    return {};
  }
  final firestoreData = mapToFirestore(alerta.toMap());

  // Add any Firestore field values
  alerta.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAlertaListFirestoreData(
  List<AlertaStruct>? alertas,
) =>
    alertas?.map((e) => getAlertaFirestoreData(e, true)).toList() ?? [];
