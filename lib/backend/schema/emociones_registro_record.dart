import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmocionesRegistroRecord extends FirestoreRecord {
  EmocionesRegistroRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "fecha" field.
  DateTime? _fecha;
  DateTime? get fecha => _fecha;
  bool hasFecha() => _fecha != null;

  // "emocion" field.
  int? _emocion;
  int get emocion => _emocion ?? 0;
  bool hasEmocion() => _emocion != null;

  // "descripcion" field.
  String? _descripcion;
  String get descripcion => _descripcion ?? '';
  bool hasDescripcion() => _descripcion != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _fecha = snapshotData['fecha'] as DateTime?;
    _emocion = castToType<int>(snapshotData['emocion']);
    _descripcion = snapshotData['descripcion'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('emociones_registro')
          : FirebaseFirestore.instance.collectionGroup('emociones_registro');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('emociones_registro').doc(id);

  static Stream<EmocionesRegistroRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EmocionesRegistroRecord.fromSnapshot(s));

  static Future<EmocionesRegistroRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EmocionesRegistroRecord.fromSnapshot(s));

  static EmocionesRegistroRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EmocionesRegistroRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EmocionesRegistroRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EmocionesRegistroRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EmocionesRegistroRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EmocionesRegistroRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEmocionesRegistroRecordData({
  DateTime? fecha,
  int? emocion,
  String? descripcion,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'fecha': fecha,
      'emocion': emocion,
      'descripcion': descripcion,
    }.withoutNulls,
  );

  return firestoreData;
}

class EmocionesRegistroRecordDocumentEquality
    implements Equality<EmocionesRegistroRecord> {
  const EmocionesRegistroRecordDocumentEquality();

  @override
  bool equals(EmocionesRegistroRecord? e1, EmocionesRegistroRecord? e2) {
    return e1?.fecha == e2?.fecha &&
        e1?.emocion == e2?.emocion &&
        e1?.descripcion == e2?.descripcion;
  }

  @override
  int hash(EmocionesRegistroRecord? e) =>
      const ListEquality().hash([e?.fecha, e?.emocion, e?.descripcion]);

  @override
  bool isValidKey(Object? o) => o is EmocionesRegistroRecord;
}
