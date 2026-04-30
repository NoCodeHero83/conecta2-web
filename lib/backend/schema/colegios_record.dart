import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ColegiosRecord extends FirestoreRecord {
  ColegiosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "barrio" field.
  String? _barrio;
  String get barrio => _barrio ?? '';
  bool hasBarrio() => _barrio != null;

  // "cod_dane" field.
  String? _codDane;
  String get codDane => _codDane ?? '';
  bool hasCodDane() => _codDane != null;

  // "direccion" field.
  String? _direccion;
  String get direccion => _direccion ?? '';
  bool hasDireccion() => _direccion != null;

  // "latitud" field.
  String? _latitud;
  String get latitud => _latitud ?? '';
  bool hasLatitud() => _latitud != null;

  // "longitud" field.
  String? _longitud;
  String get longitud => _longitud ?? '';
  bool hasLongitud() => _longitud != null;

  // "municipio" field.
  String? _municipio;
  String get municipio => _municipio ?? '';
  bool hasMunicipio() => _municipio != null;

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  bool hasNombre() => _nombre != null;

  // "sector" field.
  String? _sector;
  String get sector => _sector ?? '';
  bool hasSector() => _sector != null;

  void _initializeFields() {
    _barrio = snapshotData['barrio'] as String?;
    _codDane = snapshotData['cod_dane'] as String?;
    _direccion = snapshotData['direccion'] as String?;
    _latitud = snapshotData['latitud'] as String?;
    _longitud = snapshotData['longitud'] as String?;
    _municipio = snapshotData['municipio'] as String?;
    _nombre = snapshotData['nombre'] as String?;
    _sector = snapshotData['sector'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('colegios');

  static Stream<ColegiosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ColegiosRecord.fromSnapshot(s));

  static Future<ColegiosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ColegiosRecord.fromSnapshot(s));

  static ColegiosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ColegiosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ColegiosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ColegiosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ColegiosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ColegiosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createColegiosRecordData({
  String? barrio,
  String? codDane,
  String? direccion,
  String? latitud,
  String? longitud,
  String? municipio,
  String? nombre,
  String? sector,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'barrio': barrio,
      'cod_dane': codDane,
      'direccion': direccion,
      'latitud': latitud,
      'longitud': longitud,
      'municipio': municipio,
      'nombre': nombre,
      'sector': sector,
    }.withoutNulls,
  );

  return firestoreData;
}

class ColegiosRecordDocumentEquality implements Equality<ColegiosRecord> {
  const ColegiosRecordDocumentEquality();

  @override
  bool equals(ColegiosRecord? e1, ColegiosRecord? e2) {
    return e1?.barrio == e2?.barrio &&
        e1?.codDane == e2?.codDane &&
        e1?.direccion == e2?.direccion &&
        e1?.latitud == e2?.latitud &&
        e1?.longitud == e2?.longitud &&
        e1?.municipio == e2?.municipio &&
        e1?.nombre == e2?.nombre &&
        e1?.sector == e2?.sector;
  }

  @override
  int hash(ColegiosRecord? e) => const ListEquality().hash([
        e?.barrio,
        e?.codDane,
        e?.direccion,
        e?.latitud,
        e?.longitud,
        e?.municipio,
        e?.nombre,
        e?.sector
      ]);

  @override
  bool isValidKey(Object? o) => o is ColegiosRecord;
}
