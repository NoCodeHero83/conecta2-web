// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectStruct extends FFFirebaseStruct {
  SelectStruct({
    List<String>? nombre,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nombre = nombre,
        super(firestoreUtilData);

  // "Nombre" field.
  List<String>? _nombre;
  List<String> get nombre => _nombre ?? const [];
  set nombre(List<String>? val) => _nombre = val;

  void updateNombre(Function(List<String>) updateFn) {
    updateFn(_nombre ??= []);
  }

  bool hasNombre() => _nombre != null;

  static SelectStruct fromMap(Map<String, dynamic> data) => SelectStruct(
        nombre: getDataList(data['Nombre']),
      );

  static SelectStruct? maybeFromMap(dynamic data) =>
      data is Map ? SelectStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Nombre': _nombre,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Nombre': serializeParam(
          _nombre,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static SelectStruct fromSerializableMap(Map<String, dynamic> data) =>
      SelectStruct(
        nombre: deserializeParam<String>(
          data['Nombre'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'SelectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SelectStruct && listEquality.equals(nombre, other.nombre);
  }

  @override
  int get hashCode => const ListEquality().hash([nombre]);
}

SelectStruct createSelectStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SelectStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SelectStruct? updateSelectStruct(
  SelectStruct? select, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    select
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSelectStructData(
  Map<String, dynamic> firestoreData,
  SelectStruct? select,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (select == null) {
    return;
  }
  if (select.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && select.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final selectData = getSelectFirestoreData(select, forFieldValue);
  final nestedData = selectData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = select.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSelectFirestoreData(
  SelectStruct? select, [
  bool forFieldValue = false,
]) {
  if (select == null) {
    return {};
  }
  final firestoreData = mapToFirestore(select.toMap());

  // Add any Firestore field values
  select.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSelectListFirestoreData(
  List<SelectStruct>? selects,
) =>
    selects?.map((e) => getSelectFirestoreData(e, true)).toList() ?? [];
