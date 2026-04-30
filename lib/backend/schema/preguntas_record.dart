import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PreguntasRecord extends FirestoreRecord {
  PreguntasRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Tipo" field.
  String? _tipo;
  String get tipo => _tipo ?? '';
  bool hasTipo() => _tipo != null;

  // "Pregunta" field.
  String? _pregunta;
  String get pregunta => _pregunta ?? '';
  bool hasPregunta() => _pregunta != null;

  // "Respuesta1" field.
  String? _respuesta1;
  String get respuesta1 => _respuesta1 ?? '';
  bool hasRespuesta1() => _respuesta1 != null;

  // "Respuesta2" field.
  String? _respuesta2;
  String get respuesta2 => _respuesta2 ?? '';
  bool hasRespuesta2() => _respuesta2 != null;

  // "Respuesta3" field.
  String? _respuesta3;
  String get respuesta3 => _respuesta3 ?? '';
  bool hasRespuesta3() => _respuesta3 != null;

  // "Respuesta4" field.
  String? _respuesta4;
  String get respuesta4 => _respuesta4 ?? '';
  bool hasRespuesta4() => _respuesta4 != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _tipo = snapshotData['Tipo'] as String?;
    _pregunta = snapshotData['Pregunta'] as String?;
    _respuesta1 = snapshotData['Respuesta1'] as String?;
    _respuesta2 = snapshotData['Respuesta2'] as String?;
    _respuesta3 = snapshotData['Respuesta3'] as String?;
    _respuesta4 = snapshotData['Respuesta4'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('Preguntas')
          : FirebaseFirestore.instance.collectionGroup('Preguntas');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('Preguntas').doc(id);

  static Stream<PreguntasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PreguntasRecord.fromSnapshot(s));

  static Future<PreguntasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PreguntasRecord.fromSnapshot(s));

  static PreguntasRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PreguntasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PreguntasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PreguntasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PreguntasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PreguntasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPreguntasRecordData({
  String? tipo,
  String? pregunta,
  String? respuesta1,
  String? respuesta2,
  String? respuesta3,
  String? respuesta4,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Tipo': tipo,
      'Pregunta': pregunta,
      'Respuesta1': respuesta1,
      'Respuesta2': respuesta2,
      'Respuesta3': respuesta3,
      'Respuesta4': respuesta4,
    }.withoutNulls,
  );

  return firestoreData;
}

class PreguntasRecordDocumentEquality implements Equality<PreguntasRecord> {
  const PreguntasRecordDocumentEquality();

  @override
  bool equals(PreguntasRecord? e1, PreguntasRecord? e2) {
    return e1?.tipo == e2?.tipo &&
        e1?.pregunta == e2?.pregunta &&
        e1?.respuesta1 == e2?.respuesta1 &&
        e1?.respuesta2 == e2?.respuesta2 &&
        e1?.respuesta3 == e2?.respuesta3 &&
        e1?.respuesta4 == e2?.respuesta4;
  }

  @override
  int hash(PreguntasRecord? e) => const ListEquality().hash([
        e?.tipo,
        e?.pregunta,
        e?.respuesta1,
        e?.respuesta2,
        e?.respuesta3,
        e?.respuesta4
      ]);

  @override
  bool isValidKey(Object? o) => o is PreguntasRecord;
}
