import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecordatorRecord extends FirestoreRecord {
  RecordatorRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  bool hasTitulo() => _titulo != null;

  // "descripcion" field.
  String? _descripcion;
  String get descripcion => _descripcion ?? '';
  bool hasDescripcion() => _descripcion != null;

  // "CreateAt" field.
  DateTime? _createAt;
  DateTime? get createAt => _createAt;
  bool hasCreateAt() => _createAt != null;

  void _initializeFields() {
    _titulo = snapshotData['titulo'] as String?;
    _descripcion = snapshotData['descripcion'] as String?;
    _createAt = snapshotData['CreateAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Recordator');

  static Stream<RecordatorRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RecordatorRecord.fromSnapshot(s));

  static Future<RecordatorRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RecordatorRecord.fromSnapshot(s));

  static RecordatorRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RecordatorRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RecordatorRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RecordatorRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RecordatorRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RecordatorRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRecordatorRecordData({
  String? titulo,
  String? descripcion,
  DateTime? createAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'CreateAt': createAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class RecordatorRecordDocumentEquality implements Equality<RecordatorRecord> {
  const RecordatorRecordDocumentEquality();

  @override
  bool equals(RecordatorRecord? e1, RecordatorRecord? e2) {
    return e1?.titulo == e2?.titulo &&
        e1?.descripcion == e2?.descripcion &&
        e1?.createAt == e2?.createAt;
  }

  @override
  int hash(RecordatorRecord? e) =>
      const ListEquality().hash([e?.titulo, e?.descripcion, e?.createAt]);

  @override
  bool isValidKey(Object? o) => o is RecordatorRecord;
}
