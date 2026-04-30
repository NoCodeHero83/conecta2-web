// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AlertaEspecialStruct extends FFFirebaseStruct {
  AlertaEspecialStruct({
    String? nombre,
    List<int>? preguntas,
    String? condicion,
    int? puntaje,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nombre = nombre,
        _preguntas = preguntas,
        _condicion = condicion,
        _puntaje = puntaje,
        super(firestoreUtilData);

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  set nombre(String? val) => _nombre = val;

  bool hasNombre() => _nombre != null;

  // "preguntas" field.
  List<int>? _preguntas;
  List<int> get preguntas => _preguntas ?? const [];
  set preguntas(List<int>? val) => _preguntas = val;

  void updatePreguntas(Function(List<int>) updateFn) {
    updateFn(_preguntas ??= []);
  }

  bool hasPreguntas() => _preguntas != null;

  // "condicion" field.
  String? _condicion;
  String get condicion => _condicion ?? '';
  set condicion(String? val) => _condicion = val;

  bool hasCondicion() => _condicion != null;

  // "puntaje" field.
  int? _puntaje;
  int get puntaje => _puntaje ?? 0;
  set puntaje(int? val) => _puntaje = val;

  void incrementPuntaje(int amount) => puntaje = puntaje + amount;

  bool hasPuntaje() => _puntaje != null;

  static AlertaEspecialStruct fromMap(Map<String, dynamic> data) =>
      AlertaEspecialStruct(
        nombre: data['nombre'] as String?,
        preguntas: getDataList(data['preguntas'])
            ?.map((e) => castToType<int>(e)!)
            .toList(),
        condicion: data['condicion'] as String?,
        puntaje: castToType<int>(data['puntaje']),
      );

  static AlertaEspecialStruct? maybeFromMap(dynamic data) => data is Map
      ? AlertaEspecialStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'nombre': _nombre,
        'preguntas': _preguntas,
        'condicion': _condicion,
        'puntaje': _puntaje,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'nombre': serializeParam(
          _nombre,
          ParamType.String,
        ),
        'preguntas': serializeParam(
          _preguntas,
          ParamType.int,
          isList: true,
        ),
        'condicion': serializeParam(
          _condicion,
          ParamType.String,
        ),
        'puntaje': serializeParam(
          _puntaje,
          ParamType.int,
        ),
      }.withoutNulls;

  static AlertaEspecialStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AlertaEspecialStruct(
        nombre: deserializeParam(
          data['nombre'],
          ParamType.String,
          false,
        ),
        preguntas: deserializeParam<int>(
          data['preguntas'],
          ParamType.int,
          true,
        ),
        condicion: deserializeParam(
          data['condicion'],
          ParamType.String,
          false,
        ),
        puntaje: deserializeParam(
          data['puntaje'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'AlertaEspecialStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AlertaEspecialStruct &&
        nombre == other.nombre &&
        listEquality.equals(preguntas, other.preguntas) &&
        condicion == other.condicion &&
        puntaje == other.puntaje;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([nombre, preguntas, condicion, puntaje]);
}

AlertaEspecialStruct createAlertaEspecialStruct({
  String? nombre,
  String? condicion,
  int? puntaje,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AlertaEspecialStruct(
      nombre: nombre,
      condicion: condicion,
      puntaje: puntaje,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AlertaEspecialStruct? updateAlertaEspecialStruct(
  AlertaEspecialStruct? alertaEspecial, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    alertaEspecial
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAlertaEspecialStructData(
  Map<String, dynamic> firestoreData,
  AlertaEspecialStruct? alertaEspecial,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (alertaEspecial == null) {
    return;
  }
  if (alertaEspecial.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && alertaEspecial.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final alertaEspecialData =
      getAlertaEspecialFirestoreData(alertaEspecial, forFieldValue);
  final nestedData =
      alertaEspecialData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = alertaEspecial.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAlertaEspecialFirestoreData(
  AlertaEspecialStruct? alertaEspecial, [
  bool forFieldValue = false,
]) {
  if (alertaEspecial == null) {
    return {};
  }
  final firestoreData = mapToFirestore(alertaEspecial.toMap());

  // Add any Firestore field values
  alertaEspecial.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAlertaEspecialListFirestoreData(
  List<AlertaEspecialStruct>? alertaEspecials,
) =>
    alertaEspecials
        ?.map((e) => getAlertaEspecialFirestoreData(e, true))
        .toList() ??
    [];
