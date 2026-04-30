// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DetalleUsuarioStruct extends FFFirebaseStruct {
  DetalleUsuarioStruct({
    DateTime? fechaNacimiento,
    String? genero,
    String? municipio,
    String? barrio,
    String? colegio,
    String? eps,
    String? grado,
    String? documento,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _fechaNacimiento = fechaNacimiento,
        _genero = genero,
        _municipio = municipio,
        _barrio = barrio,
        _colegio = colegio,
        _eps = eps,
        _grado = grado,
        _documento = documento,
        super(firestoreUtilData);

  // "fecha_nacimiento" field.
  DateTime? _fechaNacimiento;
  DateTime? get fechaNacimiento => _fechaNacimiento;
  set fechaNacimiento(DateTime? val) => _fechaNacimiento = val;

  bool hasFechaNacimiento() => _fechaNacimiento != null;

  // "genero" field.
  String? _genero;
  String get genero => _genero ?? '';
  set genero(String? val) => _genero = val;

  bool hasGenero() => _genero != null;

  // "municipio" field.
  String? _municipio;
  String get municipio => _municipio ?? '';
  set municipio(String? val) => _municipio = val;

  bool hasMunicipio() => _municipio != null;

  // "barrio" field.
  String? _barrio;
  String get barrio => _barrio ?? '';
  set barrio(String? val) => _barrio = val;

  bool hasBarrio() => _barrio != null;

  // "colegio" field.
  String? _colegio;
  String get colegio => _colegio ?? '';
  set colegio(String? val) => _colegio = val;

  bool hasColegio() => _colegio != null;

  // "eps" field.
  String? _eps;
  String get eps => _eps ?? '';
  set eps(String? val) => _eps = val;

  bool hasEps() => _eps != null;

  // "grado" field.
  String? _grado;
  String get grado => _grado ?? '';
  set grado(String? val) => _grado = val;

  bool hasGrado() => _grado != null;

  // "documento" field.
  String? _documento;
  String get documento => _documento ?? '';
  set documento(String? val) => _documento = val;

  bool hasDocumento() => _documento != null;

  static DetalleUsuarioStruct fromMap(Map<String, dynamic> data) =>
      DetalleUsuarioStruct(
        fechaNacimiento: data['fecha_nacimiento'] as DateTime?,
        genero: data['genero'] as String?,
        municipio: data['municipio'] as String?,
        barrio: data['barrio'] as String?,
        colegio: data['colegio'] as String?,
        eps: data['eps'] as String?,
        grado: data['grado'] as String?,
        documento: data['documento'] as String?,
      );

  static DetalleUsuarioStruct? maybeFromMap(dynamic data) => data is Map
      ? DetalleUsuarioStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'fecha_nacimiento': _fechaNacimiento,
        'genero': _genero,
        'municipio': _municipio,
        'barrio': _barrio,
        'colegio': _colegio,
        'eps': _eps,
        'grado': _grado,
        'documento': _documento,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'fecha_nacimiento': serializeParam(
          _fechaNacimiento,
          ParamType.DateTime,
        ),
        'genero': serializeParam(
          _genero,
          ParamType.String,
        ),
        'municipio': serializeParam(
          _municipio,
          ParamType.String,
        ),
        'barrio': serializeParam(
          _barrio,
          ParamType.String,
        ),
        'colegio': serializeParam(
          _colegio,
          ParamType.String,
        ),
        'eps': serializeParam(
          _eps,
          ParamType.String,
        ),
        'grado': serializeParam(
          _grado,
          ParamType.String,
        ),
        'documento': serializeParam(
          _documento,
          ParamType.String,
        ),
      }.withoutNulls;

  static DetalleUsuarioStruct fromSerializableMap(Map<String, dynamic> data) =>
      DetalleUsuarioStruct(
        fechaNacimiento: deserializeParam(
          data['fecha_nacimiento'],
          ParamType.DateTime,
          false,
        ),
        genero: deserializeParam(
          data['genero'],
          ParamType.String,
          false,
        ),
        municipio: deserializeParam(
          data['municipio'],
          ParamType.String,
          false,
        ),
        barrio: deserializeParam(
          data['barrio'],
          ParamType.String,
          false,
        ),
        colegio: deserializeParam(
          data['colegio'],
          ParamType.String,
          false,
        ),
        eps: deserializeParam(
          data['eps'],
          ParamType.String,
          false,
        ),
        grado: deserializeParam(
          data['grado'],
          ParamType.String,
          false,
        ),
        documento: deserializeParam(
          data['documento'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DetalleUsuarioStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DetalleUsuarioStruct &&
        fechaNacimiento == other.fechaNacimiento &&
        genero == other.genero &&
        municipio == other.municipio &&
        barrio == other.barrio &&
        colegio == other.colegio &&
        eps == other.eps &&
        grado == other.grado &&
        documento == other.documento;
  }

  @override
  int get hashCode => const ListEquality().hash([
        fechaNacimiento,
        genero,
        municipio,
        barrio,
        colegio,
        eps,
        grado,
        documento
      ]);
}

DetalleUsuarioStruct createDetalleUsuarioStruct({
  DateTime? fechaNacimiento,
  String? genero,
  String? municipio,
  String? barrio,
  String? colegio,
  String? eps,
  String? grado,
  String? documento,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DetalleUsuarioStruct(
      fechaNacimiento: fechaNacimiento,
      genero: genero,
      municipio: municipio,
      barrio: barrio,
      colegio: colegio,
      eps: eps,
      grado: grado,
      documento: documento,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DetalleUsuarioStruct? updateDetalleUsuarioStruct(
  DetalleUsuarioStruct? detalleUsuario, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    detalleUsuario
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDetalleUsuarioStructData(
  Map<String, dynamic> firestoreData,
  DetalleUsuarioStruct? detalleUsuario,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (detalleUsuario == null) {
    return;
  }
  if (detalleUsuario.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && detalleUsuario.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final detalleUsuarioData =
      getDetalleUsuarioFirestoreData(detalleUsuario, forFieldValue);
  final nestedData =
      detalleUsuarioData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = detalleUsuario.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDetalleUsuarioFirestoreData(
  DetalleUsuarioStruct? detalleUsuario, [
  bool forFieldValue = false,
]) {
  if (detalleUsuario == null) {
    return {};
  }
  final firestoreData = mapToFirestore(detalleUsuario.toMap());

  // Add any Firestore field values
  detalleUsuario.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDetalleUsuarioListFirestoreData(
  List<DetalleUsuarioStruct>? detalleUsuarios,
) =>
    detalleUsuarios
        ?.map((e) => getDetalleUsuarioFirestoreData(e, true))
        .toList() ??
    [];
