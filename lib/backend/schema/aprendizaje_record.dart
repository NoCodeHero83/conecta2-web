import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AprendizajeRecord extends FirestoreRecord {
  AprendizajeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  bool hasTitulo() => _titulo != null;

  // "contenido" field.
  String? _contenido;
  String get contenido => _contenido ?? '';
  bool hasContenido() => _contenido != null;

  // "imagenes" field.
  List<String>? _imagenes;
  List<String> get imagenes => _imagenes ?? const [];
  bool hasImagenes() => _imagenes != null;

  // "categoria" field.
  String? _categoria;
  String get categoria => _categoria ?? '';
  bool hasCategoria() => _categoria != null;

  // "Roles" field.
  List<String>? _roles;
  List<String> get roles => _roles ?? const [];
  bool hasRoles() => _roles != null;

  // "Publicado" field.
  bool? _publicado;
  bool get publicado => _publicado ?? false;
  bool hasPublicado() => _publicado != null;

  // "Fecha_creacion" field.
  DateTime? _fechaCreacion;
  DateTime? get fechaCreacion => _fechaCreacion;
  bool hasFechaCreacion() => _fechaCreacion != null;

  void _initializeFields() {
    _titulo = snapshotData['titulo'] as String?;
    _contenido = snapshotData['contenido'] as String?;
    _imagenes = getDataList(snapshotData['imagenes']);
    _categoria = snapshotData['categoria'] as String?;
    _roles = getDataList(snapshotData['Roles']);
    _publicado = snapshotData['Publicado'] as bool?;
    _fechaCreacion = snapshotData['Fecha_creacion'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Aprendizaje');

  static Stream<AprendizajeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AprendizajeRecord.fromSnapshot(s));

  static Future<AprendizajeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AprendizajeRecord.fromSnapshot(s));

  static AprendizajeRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AprendizajeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AprendizajeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AprendizajeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AprendizajeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AprendizajeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAprendizajeRecordData({
  String? titulo,
  String? contenido,
  String? categoria,
  bool? publicado,
  DateTime? fechaCreacion,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titulo': titulo,
      'contenido': contenido,
      'categoria': categoria,
      'Publicado': publicado,
      'Fecha_creacion': fechaCreacion,
    }.withoutNulls,
  );

  return firestoreData;
}

class AprendizajeRecordDocumentEquality implements Equality<AprendizajeRecord> {
  const AprendizajeRecordDocumentEquality();

  @override
  bool equals(AprendizajeRecord? e1, AprendizajeRecord? e2) {
    const listEquality = ListEquality();
    return e1?.titulo == e2?.titulo &&
        e1?.contenido == e2?.contenido &&
        listEquality.equals(e1?.imagenes, e2?.imagenes) &&
        e1?.categoria == e2?.categoria &&
        listEquality.equals(e1?.roles, e2?.roles) &&
        e1?.publicado == e2?.publicado &&
        e1?.fechaCreacion == e2?.fechaCreacion;
  }

  @override
  int hash(AprendizajeRecord? e) => const ListEquality().hash([
        e?.titulo,
        e?.contenido,
        e?.imagenes,
        e?.categoria,
        e?.roles,
        e?.publicado,
        e?.fechaCreacion
      ]);

  @override
  bool isValidKey(Object? o) => o is AprendizajeRecord;
}
