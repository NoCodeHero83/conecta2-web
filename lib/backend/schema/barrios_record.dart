import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BarriosRecord extends FirestoreRecord {
  BarriosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  bool hasNombre() => _nombre != null;

  // "municipio" field.
  String? _municipio;
  String get municipio => _municipio ?? '';
  bool hasMunicipio() => _municipio != null;

  void _initializeFields() {
    _nombre = snapshotData['nombre'] as String?;
    _municipio = snapshotData['municipio'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('barrios');

  static Stream<BarriosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BarriosRecord.fromSnapshot(s));

  static Future<BarriosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BarriosRecord.fromSnapshot(s));

  static BarriosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BarriosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BarriosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BarriosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BarriosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BarriosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBarriosRecordData({
  String? nombre,
  String? municipio,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nombre': nombre,
      'municipio': municipio,
    }.withoutNulls,
  );

  return firestoreData;
}

class BarriosRecordDocumentEquality implements Equality<BarriosRecord> {
  const BarriosRecordDocumentEquality();

  @override
  bool equals(BarriosRecord? e1, BarriosRecord? e2) {
    return e1?.nombre == e2?.nombre && e1?.municipio == e2?.municipio;
  }

  @override
  int hash(BarriosRecord? e) =>
      const ListEquality().hash([e?.nombre, e?.municipio]);

  @override
  bool isValidKey(Object? o) => o is BarriosRecord;
}
