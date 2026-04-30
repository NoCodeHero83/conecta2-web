// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AcudienteStruct extends FFFirebaseStruct {
  AcudienteStruct({
    String? nombre,
    DocumentReference? ref,
    String? parentesco,
    String? correo,
    String? telefono,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nombre = nombre,
        _ref = ref,
        _parentesco = parentesco,
        _correo = correo,
        _telefono = telefono,
        super(firestoreUtilData);

  // "Nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  set nombre(String? val) => _nombre = val;

  bool hasNombre() => _nombre != null;

  // "ref" field.
  DocumentReference? _ref;
  DocumentReference? get ref => _ref;
  set ref(DocumentReference? val) => _ref = val;

  bool hasRef() => _ref != null;

  // "parentesco" field.
  String? _parentesco;
  String get parentesco => _parentesco ?? '';
  set parentesco(String? val) => _parentesco = val;

  bool hasParentesco() => _parentesco != null;

  // "correo" field.
  String? _correo;
  String get correo => _correo ?? '';
  set correo(String? val) => _correo = val;

  bool hasCorreo() => _correo != null;

  // "telefono" field.
  String? _telefono;
  String get telefono => _telefono ?? '';
  set telefono(String? val) => _telefono = val;

  bool hasTelefono() => _telefono != null;

  static AcudienteStruct fromMap(Map<String, dynamic> data) => AcudienteStruct(
        nombre: data['Nombre'] as String?,
        ref: data['ref'] as DocumentReference?,
        parentesco: data['parentesco'] as String?,
        correo: data['correo'] as String?,
        telefono: data['telefono'] as String?,
      );

  static AcudienteStruct? maybeFromMap(dynamic data) => data is Map
      ? AcudienteStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Nombre': _nombre,
        'ref': _ref,
        'parentesco': _parentesco,
        'correo': _correo,
        'telefono': _telefono,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Nombre': serializeParam(
          _nombre,
          ParamType.String,
        ),
        'ref': serializeParam(
          _ref,
          ParamType.DocumentReference,
        ),
        'parentesco': serializeParam(
          _parentesco,
          ParamType.String,
        ),
        'correo': serializeParam(
          _correo,
          ParamType.String,
        ),
        'telefono': serializeParam(
          _telefono,
          ParamType.String,
        ),
      }.withoutNulls;

  static AcudienteStruct fromSerializableMap(Map<String, dynamic> data) =>
      AcudienteStruct(
        nombre: deserializeParam(
          data['Nombre'],
          ParamType.String,
          false,
        ),
        ref: deserializeParam(
          data['ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        parentesco: deserializeParam(
          data['parentesco'],
          ParamType.String,
          false,
        ),
        correo: deserializeParam(
          data['correo'],
          ParamType.String,
          false,
        ),
        telefono: deserializeParam(
          data['telefono'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AcudienteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AcudienteStruct &&
        nombre == other.nombre &&
        ref == other.ref &&
        parentesco == other.parentesco &&
        correo == other.correo &&
        telefono == other.telefono;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([nombre, ref, parentesco, correo, telefono]);
}

AcudienteStruct createAcudienteStruct({
  String? nombre,
  DocumentReference? ref,
  String? parentesco,
  String? correo,
  String? telefono,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AcudienteStruct(
      nombre: nombre,
      ref: ref,
      parentesco: parentesco,
      correo: correo,
      telefono: telefono,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AcudienteStruct? updateAcudienteStruct(
  AcudienteStruct? acudiente, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    acudiente
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAcudienteStructData(
  Map<String, dynamic> firestoreData,
  AcudienteStruct? acudiente,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (acudiente == null) {
    return;
  }
  if (acudiente.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && acudiente.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final acudienteData = getAcudienteFirestoreData(acudiente, forFieldValue);
  final nestedData = acudienteData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = acudiente.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAcudienteFirestoreData(
  AcudienteStruct? acudiente, [
  bool forFieldValue = false,
]) {
  if (acudiente == null) {
    return {};
  }
  final firestoreData = mapToFirestore(acudiente.toMap());

  // Add any Firestore field values
  acudiente.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAcudienteListFirestoreData(
  List<AcudienteStruct>? acudientes,
) =>
    acudientes?.map((e) => getAcudienteFirestoreData(e, true)).toList() ?? [];
