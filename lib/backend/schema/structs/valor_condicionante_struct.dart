// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ValorCondicionanteStruct extends FFFirebaseStruct {
  ValorCondicionanteStruct({
    String? etiqueta,
    String? sustanciaValor,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _etiqueta = etiqueta,
        _sustanciaValor = sustanciaValor,
        super(firestoreUtilData);

  // "etiqueta" field.
  String? _etiqueta;
  String get etiqueta => _etiqueta ?? '';
  set etiqueta(String? val) => _etiqueta = val;

  bool hasEtiqueta() => _etiqueta != null;

  // "sustanciaValor" field.
  String? _sustanciaValor;
  String get sustanciaValor => _sustanciaValor ?? '';
  set sustanciaValor(String? val) => _sustanciaValor = val;

  bool hasSustanciaValor() => _sustanciaValor != null;

  static ValorCondicionanteStruct fromMap(Map<String, dynamic> data) =>
      ValorCondicionanteStruct(
        etiqueta: data['etiqueta'] as String?,
        sustanciaValor: data['sustanciaValor'] as String?,
      );

  static ValorCondicionanteStruct? maybeFromMap(dynamic data) => data is Map
      ? ValorCondicionanteStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'etiqueta': _etiqueta,
        'sustanciaValor': _sustanciaValor,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'etiqueta': serializeParam(
          _etiqueta,
          ParamType.String,
        ),
        'sustanciaValor': serializeParam(
          _sustanciaValor,
          ParamType.String,
        ),
      }.withoutNulls;

  static ValorCondicionanteStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ValorCondicionanteStruct(
        etiqueta: deserializeParam(
          data['etiqueta'],
          ParamType.String,
          false,
        ),
        sustanciaValor: deserializeParam(
          data['sustanciaValor'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ValorCondicionanteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ValorCondicionanteStruct &&
        etiqueta == other.etiqueta &&
        sustanciaValor == other.sustanciaValor;
  }

  @override
  int get hashCode => const ListEquality().hash([etiqueta, sustanciaValor]);
}

ValorCondicionanteStruct createValorCondicionanteStruct({
  String? etiqueta,
  String? sustanciaValor,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ValorCondicionanteStruct(
      etiqueta: etiqueta,
      sustanciaValor: sustanciaValor,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ValorCondicionanteStruct? updateValorCondicionanteStruct(
  ValorCondicionanteStruct? valorCondicionante, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    valorCondicionante
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addValorCondicionanteStructData(
  Map<String, dynamic> firestoreData,
  ValorCondicionanteStruct? valorCondicionante,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (valorCondicionante == null) {
    return;
  }
  if (valorCondicionante.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && valorCondicionante.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final valorCondicionanteData =
      getValorCondicionanteFirestoreData(valorCondicionante, forFieldValue);
  final nestedData =
      valorCondicionanteData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      valorCondicionante.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getValorCondicionanteFirestoreData(
  ValorCondicionanteStruct? valorCondicionante, [
  bool forFieldValue = false,
]) {
  if (valorCondicionante == null) {
    return {};
  }
  final firestoreData = mapToFirestore(valorCondicionante.toMap());

  // Add any Firestore field values
  valorCondicionante.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getValorCondicionanteListFirestoreData(
  List<ValorCondicionanteStruct>? valorCondicionantes,
) =>
    valorCondicionantes
        ?.map((e) => getValorCondicionanteFirestoreData(e, true))
        .toList() ??
    [];
