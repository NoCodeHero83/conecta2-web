import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RemindersRecord extends FirestoreRecord {
  RemindersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "due_date" field.
  DateTime? _dueDate;
  DateTime? get dueDate => _dueDate;
  bool hasDueDate() => _dueDate != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "notified" field.
  bool? _notified;
  bool get notified => _notified ?? false;
  bool hasNotified() => _notified != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _dueDate = snapshotData['due_date'] as DateTime?;
    _title = snapshotData['title'] as String?;
    _content = snapshotData['content'] as String?;
    _notified = snapshotData['notified'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reminders');

  static Stream<RemindersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RemindersRecord.fromSnapshot(s));

  static Future<RemindersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RemindersRecord.fromSnapshot(s));

  static RemindersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RemindersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RemindersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RemindersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RemindersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RemindersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRemindersRecordData({
  DocumentReference? user,
  DateTime? dueDate,
  String? title,
  String? content,
  bool? notified,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'due_date': dueDate,
      'title': title,
      'content': content,
      'notified': notified ?? false,
    }.withoutNulls,
  );

  return firestoreData;
}

class RemindersRecordDocumentEquality implements Equality<RemindersRecord> {
  const RemindersRecordDocumentEquality();

  @override
  bool equals(RemindersRecord? e1, RemindersRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.dueDate == e2?.dueDate &&
        e1?.title == e2?.title &&
        e1?.content == e2?.content;
  }

  @override
  int hash(RemindersRecord? e) =>
      const ListEquality().hash([e?.user, e?.dueDate, e?.title, e?.content]);

  @override
  bool isValidKey(Object? o) => o is RemindersRecord;
}
