// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RegistroUsuarioTempStruct extends FFFirebaseStruct {
  RegistroUsuarioTempStruct({
    String? nombre,
    String? tipo,
    String? email,
    String? password,
    String? phone,
    DetalleUsuarioStruct? detalle,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nombre = nombre,
        _tipo = tipo,
        _email = email,
        _password = password,
        _phone = phone,
        _detalle = detalle,
        super(firestoreUtilData);

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  set nombre(String? val) => _nombre = val;

  bool hasNombre() => _nombre != null;

  // "tipo" field.
  String? _tipo;
  String get tipo => _tipo ?? '';
  set tipo(String? val) => _tipo = val;

  bool hasTipo() => _tipo != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  set password(String? val) => _password = val;

  bool hasPassword() => _password != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "detalle" field.
  DetalleUsuarioStruct? _detalle;
  DetalleUsuarioStruct get detalle => _detalle ?? DetalleUsuarioStruct();
  set detalle(DetalleUsuarioStruct? val) => _detalle = val;

  void updateDetalle(Function(DetalleUsuarioStruct) updateFn) {
    updateFn(_detalle ??= DetalleUsuarioStruct());
  }

  bool hasDetalle() => _detalle != null;

  static RegistroUsuarioTempStruct fromMap(Map<String, dynamic> data) =>
      RegistroUsuarioTempStruct(
        nombre: data['nombre'] as String?,
        tipo: data['tipo'] as String?,
        email: data['email'] as String?,
        password: data['password'] as String?,
        phone: data['phone'] as String?,
        detalle: data['detalle'] is DetalleUsuarioStruct
            ? data['detalle']
            : DetalleUsuarioStruct.maybeFromMap(data['detalle']),
      );

  static RegistroUsuarioTempStruct? maybeFromMap(dynamic data) => data is Map
      ? RegistroUsuarioTempStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'nombre': _nombre,
        'tipo': _tipo,
        'email': _email,
        'password': _password,
        'phone': _phone,
        'detalle': _detalle?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'nombre': serializeParam(
          _nombre,
          ParamType.String,
        ),
        'tipo': serializeParam(
          _tipo,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'password': serializeParam(
          _password,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'detalle': serializeParam(
          _detalle,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static RegistroUsuarioTempStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RegistroUsuarioTempStruct(
        nombre: deserializeParam(
          data['nombre'],
          ParamType.String,
          false,
        ),
        tipo: deserializeParam(
          data['tipo'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        password: deserializeParam(
          data['password'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        detalle: deserializeStructParam(
          data['detalle'],
          ParamType.DataStruct,
          false,
          structBuilder: DetalleUsuarioStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RegistroUsuarioTempStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RegistroUsuarioTempStruct &&
        nombre == other.nombre &&
        tipo == other.tipo &&
        email == other.email &&
        password == other.password &&
        phone == other.phone &&
        detalle == other.detalle;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([nombre, tipo, email, password, phone, detalle]);
}

RegistroUsuarioTempStruct createRegistroUsuarioTempStruct({
  String? nombre,
  String? tipo,
  String? email,
  String? password,
  String? phone,
  DetalleUsuarioStruct? detalle,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RegistroUsuarioTempStruct(
      nombre: nombre,
      tipo: tipo,
      email: email,
      password: password,
      phone: phone,
      detalle: detalle ?? (clearUnsetFields ? DetalleUsuarioStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RegistroUsuarioTempStruct? updateRegistroUsuarioTempStruct(
  RegistroUsuarioTempStruct? registroUsuarioTemp, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    registroUsuarioTemp
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRegistroUsuarioTempStructData(
  Map<String, dynamic> firestoreData,
  RegistroUsuarioTempStruct? registroUsuarioTemp,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (registroUsuarioTemp == null) {
    return;
  }
  if (registroUsuarioTemp.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && registroUsuarioTemp.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final registroUsuarioTempData =
      getRegistroUsuarioTempFirestoreData(registroUsuarioTemp, forFieldValue);
  final nestedData =
      registroUsuarioTempData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      registroUsuarioTemp.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRegistroUsuarioTempFirestoreData(
  RegistroUsuarioTempStruct? registroUsuarioTemp, [
  bool forFieldValue = false,
]) {
  if (registroUsuarioTemp == null) {
    return {};
  }
  final firestoreData = mapToFirestore(registroUsuarioTemp.toMap());

  // Handle nested data for "detalle" field.
  addDetalleUsuarioStructData(
    firestoreData,
    registroUsuarioTemp.hasDetalle() ? registroUsuarioTemp.detalle : null,
    'detalle',
    forFieldValue,
  );

  // Add any Firestore field values
  registroUsuarioTemp.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRegistroUsuarioTempListFirestoreData(
  List<RegistroUsuarioTempStruct>? registroUsuarioTemps,
) =>
    registroUsuarioTemps
        ?.map((e) => getRegistroUsuarioTempFirestoreData(e, true))
        .toList() ??
    [];
