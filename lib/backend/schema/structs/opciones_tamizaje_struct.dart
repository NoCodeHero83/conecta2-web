// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class OpcionesTamizajeStruct extends FFFirebaseStruct {
  OpcionesTamizajeStruct({
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static OpcionesTamizajeStruct fromMap(Map<String, dynamic> data) =>
      OpcionesTamizajeStruct(
        name: data['name'] as String?,
      );

  static OpcionesTamizajeStruct? maybeFromMap(dynamic data) => data is Map
      ? OpcionesTamizajeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static OpcionesTamizajeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OpcionesTamizajeStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OpcionesTamizajeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OpcionesTamizajeStruct && name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([name]);
}

OpcionesTamizajeStruct createOpcionesTamizajeStruct({
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OpcionesTamizajeStruct(
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OpcionesTamizajeStruct? updateOpcionesTamizajeStruct(
  OpcionesTamizajeStruct? opcionesTamizaje, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    opcionesTamizaje
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOpcionesTamizajeStructData(
  Map<String, dynamic> firestoreData,
  OpcionesTamizajeStruct? opcionesTamizaje,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (opcionesTamizaje == null) {
    return;
  }
  if (opcionesTamizaje.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && opcionesTamizaje.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final opcionesTamizajeData =
      getOpcionesTamizajeFirestoreData(opcionesTamizaje, forFieldValue);
  final nestedData =
      opcionesTamizajeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = opcionesTamizaje.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOpcionesTamizajeFirestoreData(
  OpcionesTamizajeStruct? opcionesTamizaje, [
  bool forFieldValue = false,
]) {
  if (opcionesTamizaje == null) {
    return {};
  }
  final firestoreData = mapToFirestore(opcionesTamizaje.toMap());

  // Add any Firestore field values
  opcionesTamizaje.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOpcionesTamizajeListFirestoreData(
  List<OpcionesTamizajeStruct>? opcionesTamizajes,
) =>
    opcionesTamizajes
        ?.map((e) => getOpcionesTamizajeFirestoreData(e, true))
        .toList() ??
    [];
