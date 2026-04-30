// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CalenderEmocionesStruct extends FFFirebaseStruct {
  CalenderEmocionesStruct({
    String? emocion,
    DateTime? date,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _emocion = emocion,
        _date = date,
        super(firestoreUtilData);

  // "emocion" field.
  String? _emocion;
  String get emocion => _emocion ?? '';
  set emocion(String? val) => _emocion = val;

  bool hasEmocion() => _emocion != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  static CalenderEmocionesStruct fromMap(Map<String, dynamic> data) =>
      CalenderEmocionesStruct(
        emocion: data['emocion'] as String?,
        date: data['date'] as DateTime?,
      );

  static CalenderEmocionesStruct? maybeFromMap(dynamic data) => data is Map
      ? CalenderEmocionesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'emocion': _emocion,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'emocion': serializeParam(
          _emocion,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static CalenderEmocionesStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalenderEmocionesStruct(
        emocion: deserializeParam(
          data['emocion'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'CalenderEmocionesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalenderEmocionesStruct &&
        emocion == other.emocion &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality().hash([emocion, date]);
}

CalenderEmocionesStruct createCalenderEmocionesStruct({
  String? emocion,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalenderEmocionesStruct(
      emocion: emocion,
      date: date,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalenderEmocionesStruct? updateCalenderEmocionesStruct(
  CalenderEmocionesStruct? calenderEmociones, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calenderEmociones
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalenderEmocionesStructData(
  Map<String, dynamic> firestoreData,
  CalenderEmocionesStruct? calenderEmociones,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calenderEmociones == null) {
    return;
  }
  if (calenderEmociones.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calenderEmociones.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calenderEmocionesData =
      getCalenderEmocionesFirestoreData(calenderEmociones, forFieldValue);
  final nestedData =
      calenderEmocionesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = calenderEmociones.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalenderEmocionesFirestoreData(
  CalenderEmocionesStruct? calenderEmociones, [
  bool forFieldValue = false,
]) {
  if (calenderEmociones == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calenderEmociones.toMap());

  // Add any Firestore field values
  calenderEmociones.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalenderEmocionesListFirestoreData(
  List<CalenderEmocionesStruct>? calenderEmocioness,
) =>
    calenderEmocioness
        ?.map((e) => getCalenderEmocionesFirestoreData(e, true))
        .toList() ??
    [];
