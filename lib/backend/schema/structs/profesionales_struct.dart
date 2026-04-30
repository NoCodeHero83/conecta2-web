// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ProfesionalesStruct extends FFFirebaseStruct {
  ProfesionalesStruct({
    String? nombre,
    DocumentReference? ref,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nombre = nombre,
        _ref = ref,
        super(firestoreUtilData);

  // "Nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  set nombre(String? val) => _nombre = val;

  bool hasNombre() => _nombre != null;

  // "Ref" field.
  DocumentReference? _ref;
  DocumentReference? get ref => _ref;
  set ref(DocumentReference? val) => _ref = val;

  bool hasRef() => _ref != null;

  static ProfesionalesStruct fromMap(Map<String, dynamic> data) =>
      ProfesionalesStruct(
        nombre: data['Nombre'] as String?,
        ref: data['Ref'] as DocumentReference?,
      );

  static ProfesionalesStruct? maybeFromMap(dynamic data) => data is Map
      ? ProfesionalesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Nombre': _nombre,
        'Ref': _ref,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Nombre': serializeParam(
          _nombre,
          ParamType.String,
        ),
        'Ref': serializeParam(
          _ref,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static ProfesionalesStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProfesionalesStruct(
        nombre: deserializeParam(
          data['Nombre'],
          ParamType.String,
          false,
        ),
        ref: deserializeParam(
          data['Ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
      );

  @override
  String toString() => 'ProfesionalesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProfesionalesStruct &&
        nombre == other.nombre &&
        ref == other.ref;
  }

  @override
  int get hashCode => const ListEquality().hash([nombre, ref]);
}

ProfesionalesStruct createProfesionalesStruct({
  String? nombre,
  DocumentReference? ref,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProfesionalesStruct(
      nombre: nombre,
      ref: ref,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProfesionalesStruct? updateProfesionalesStruct(
  ProfesionalesStruct? profesionales, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    profesionales
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProfesionalesStructData(
  Map<String, dynamic> firestoreData,
  ProfesionalesStruct? profesionales,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (profesionales == null) {
    return;
  }
  if (profesionales.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && profesionales.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final profesionalesData =
      getProfesionalesFirestoreData(profesionales, forFieldValue);
  final nestedData =
      profesionalesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = profesionales.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProfesionalesFirestoreData(
  ProfesionalesStruct? profesionales, [
  bool forFieldValue = false,
]) {
  if (profesionales == null) {
    return {};
  }
  final firestoreData = mapToFirestore(profesionales.toMap());

  // Add any Firestore field values
  profesionales.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProfesionalesListFirestoreData(
  List<ProfesionalesStruct>? profesionaless,
) =>
    profesionaless
        ?.map((e) => getProfesionalesFirestoreData(e, true))
        .toList() ??
    [];
