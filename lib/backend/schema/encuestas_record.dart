import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EncuestasRecord extends FirestoreRecord {
  EncuestasRecord._(
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

  // "Preguntas" field.
  List<PreguntasEncuestaStruct>? _preguntas;
  List<PreguntasEncuestaStruct> get preguntas => _preguntas ?? const [];
  bool hasPreguntas() => _preguntas != null;

  // "Roles" field.
  List<String>? _roles;
  List<String> get roles => _roles ?? const [];
  bool hasRoles() => _roles != null;

  // "Publicado" field.
  bool? _publicado;
  bool get publicado => _publicado ?? false;
  bool hasPublicado() => _publicado != null;

  // "CreateAt" field.
  DateTime? _createAt;
  DateTime? get createAt => _createAt;
  bool hasCreateAt() => _createAt != null;

  // "user_Ref" field.
  List<DocumentReference>? _userRef;
  List<DocumentReference> get userRef => _userRef ?? const [];
  bool hasUserRef() => _userRef != null;

  // "created_by" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "tipo" field.
  String? _tipo;
  String get tipo => _tipo ?? '';
  bool hasTipo() => _tipo != null;

  // "bajo" field.
  AlertaStruct? _bajo;
  AlertaStruct get bajo => _bajo ?? AlertaStruct();
  bool hasBajo() => _bajo != null;

  // "moderado" field.
  AlertaStruct? _moderado;
  AlertaStruct get moderado => _moderado ?? AlertaStruct();
  bool hasModerado() => _moderado != null;

  // "alto" field.
  AlertaStruct? _alto;
  AlertaStruct get alto => _alto ?? AlertaStruct();
  bool hasAlto() => _alto != null;

  // "alertas" field.
  List<AlertaStruct>? _alertas;
  List<AlertaStruct> get alertas => _alertas ?? const [];
  bool hasAlertas() => _alertas != null;

  // "alertasEspeciales" field.
  List<AlertaEspecialStruct>? _alertasEspeciales;
  List<AlertaEspecialStruct> get alertasEspeciales =>
      _alertasEspeciales ?? const [];
  bool hasAlertasEspeciales() => _alertasEspeciales != null;

  // "categoria" field.
  String? _categoria;
  String get categoria => _categoria ?? '';
  bool hasCategoria() => _categoria != null;

  void _initializeFields() {
    _titulo = snapshotData['titulo'] as String?;
    _descripcion = snapshotData['descripcion'] as String?;
    _preguntas = getStructList(
      snapshotData['Preguntas'],
      PreguntasEncuestaStruct.fromMap,
    );
    _roles = getDataList(snapshotData['Roles']);
    _publicado = snapshotData['Publicado'] as bool?;
    _createAt = snapshotData['CreateAt'] as DateTime?;
    _userRef = getDataList(snapshotData['user_Ref']);
    _createdBy = snapshotData['created_by'] as DocumentReference?;
    _tipo = snapshotData['tipo'] as String?;
    _bajo = snapshotData['bajo'] is AlertaStruct
        ? snapshotData['bajo']
        : AlertaStruct.maybeFromMap(snapshotData['bajo']);
    _moderado = snapshotData['moderado'] is AlertaStruct
        ? snapshotData['moderado']
        : AlertaStruct.maybeFromMap(snapshotData['moderado']);
    _alto = snapshotData['alto'] is AlertaStruct
        ? snapshotData['alto']
        : AlertaStruct.maybeFromMap(snapshotData['alto']);
    _alertas = getStructList(
      snapshotData['alertas'],
      AlertaStruct.fromMap,
    );
    _alertasEspeciales = getStructList(
      snapshotData['alertasEspeciales'],
      AlertaEspecialStruct.fromMap,
    );
    _categoria = snapshotData['categoria'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Encuestas');

  static Stream<EncuestasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EncuestasRecord.fromSnapshot(s));

  static Future<EncuestasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EncuestasRecord.fromSnapshot(s));

  static EncuestasRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EncuestasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EncuestasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EncuestasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EncuestasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EncuestasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEncuestasRecordData({
  String? titulo,
  String? descripcion,
  bool? publicado,
  DateTime? createAt,
  DocumentReference? createdBy,
  String? tipo,
  AlertaStruct? bajo,
  AlertaStruct? moderado,
  AlertaStruct? alto,
  String? categoria,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'Publicado': publicado,
      'CreateAt': createAt,
      'created_by': createdBy,
      'tipo': tipo,
      'bajo': AlertaStruct().toMap(),
      'moderado': AlertaStruct().toMap(),
      'alto': AlertaStruct().toMap(),
      'categoria': categoria,
    }.withoutNulls,
  );

  // Handle nested data for "bajo" field.
  addAlertaStructData(firestoreData, bajo, 'bajo');

  // Handle nested data for "moderado" field.
  addAlertaStructData(firestoreData, moderado, 'moderado');

  // Handle nested data for "alto" field.
  addAlertaStructData(firestoreData, alto, 'alto');

  return firestoreData;
}

class EncuestasRecordDocumentEquality implements Equality<EncuestasRecord> {
  const EncuestasRecordDocumentEquality();

  @override
  bool equals(EncuestasRecord? e1, EncuestasRecord? e2) {
    const listEquality = ListEquality();
    return e1?.titulo == e2?.titulo &&
        e1?.descripcion == e2?.descripcion &&
        listEquality.equals(e1?.preguntas, e2?.preguntas) &&
        listEquality.equals(e1?.roles, e2?.roles) &&
        e1?.publicado == e2?.publicado &&
        e1?.createAt == e2?.createAt &&
        listEquality.equals(e1?.userRef, e2?.userRef) &&
        e1?.createdBy == e2?.createdBy &&
        e1?.tipo == e2?.tipo &&
        e1?.bajo == e2?.bajo &&
        e1?.moderado == e2?.moderado &&
        e1?.alto == e2?.alto &&
        listEquality.equals(e1?.alertas, e2?.alertas) &&
        listEquality.equals(e1?.alertasEspeciales, e2?.alertasEspeciales) &&
        e1?.categoria == e2?.categoria;
  }

  @override
  int hash(EncuestasRecord? e) => const ListEquality().hash([
        e?.titulo,
        e?.descripcion,
        e?.preguntas,
        e?.roles,
        e?.publicado,
        e?.createAt,
        e?.userRef,
        e?.createdBy,
        e?.tipo,
        e?.bajo,
        e?.moderado,
        e?.alto,
        e?.alertas,
        e?.alertasEspeciales,
        e?.categoria
      ]);

  @override
  bool isValidKey(Object? o) => o is EncuestasRecord;
}
