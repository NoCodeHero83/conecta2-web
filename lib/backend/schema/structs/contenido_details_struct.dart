// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ContenidoDetailsStruct extends FFFirebaseStruct {
  ContenidoDetailsStruct({
    String? paragraphLarga,
    String? paragraphImage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _paragraphLarga = paragraphLarga,
        _paragraphImage = paragraphImage,
        super(firestoreUtilData);

  // "Paragraph_larga" field.
  String? _paragraphLarga;
  String get paragraphLarga => _paragraphLarga ?? '';
  set paragraphLarga(String? val) => _paragraphLarga = val;

  bool hasParagraphLarga() => _paragraphLarga != null;

  // "Paragraph_Image" field.
  String? _paragraphImage;
  String get paragraphImage => _paragraphImage ?? '';
  set paragraphImage(String? val) => _paragraphImage = val;

  bool hasParagraphImage() => _paragraphImage != null;

  static ContenidoDetailsStruct fromMap(Map<String, dynamic> data) =>
      ContenidoDetailsStruct(
        paragraphLarga: data['Paragraph_larga'] as String?,
        paragraphImage: data['Paragraph_Image'] as String?,
      );

  static ContenidoDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? ContenidoDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Paragraph_larga': _paragraphLarga,
        'Paragraph_Image': _paragraphImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Paragraph_larga': serializeParam(
          _paragraphLarga,
          ParamType.String,
        ),
        'Paragraph_Image': serializeParam(
          _paragraphImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContenidoDetailsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ContenidoDetailsStruct(
        paragraphLarga: deserializeParam(
          data['Paragraph_larga'],
          ParamType.String,
          false,
        ),
        paragraphImage: deserializeParam(
          data['Paragraph_Image'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContenidoDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContenidoDetailsStruct &&
        paragraphLarga == other.paragraphLarga &&
        paragraphImage == other.paragraphImage;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([paragraphLarga, paragraphImage]);
}

ContenidoDetailsStruct createContenidoDetailsStruct({
  String? paragraphLarga,
  String? paragraphImage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContenidoDetailsStruct(
      paragraphLarga: paragraphLarga,
      paragraphImage: paragraphImage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContenidoDetailsStruct? updateContenidoDetailsStruct(
  ContenidoDetailsStruct? contenidoDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contenidoDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContenidoDetailsStructData(
  Map<String, dynamic> firestoreData,
  ContenidoDetailsStruct? contenidoDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contenidoDetails == null) {
    return;
  }
  if (contenidoDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contenidoDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contenidoDetailsData =
      getContenidoDetailsFirestoreData(contenidoDetails, forFieldValue);
  final nestedData =
      contenidoDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contenidoDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContenidoDetailsFirestoreData(
  ContenidoDetailsStruct? contenidoDetails, [
  bool forFieldValue = false,
]) {
  if (contenidoDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contenidoDetails.toMap());

  // Add any Firestore field values
  contenidoDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContenidoDetailsListFirestoreData(
  List<ContenidoDetailsStruct>? contenidoDetailss,
) =>
    contenidoDetailss
        ?.map((e) => getContenidoDetailsFirestoreData(e, true))
        .toList() ??
    [];
