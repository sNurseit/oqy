part of 'course_creating_bloc.dart';


abstract class CourseCreatingEvent extends Equatable{}

class LoadCourseCreating extends CourseCreatingEvent{
  final int? courseId;
  final Completer? completer;

  LoadCourseCreating({this.courseId, this.completer});
  @override
  List<Object?> get props => [courseId, completer];
}

class LoadCourseCategory extends CourseCreatingEvent{
  final Completer? completer;
  LoadCourseCategory({this.completer});
  @override
  List<Object?> get props => [completer];
}

class PostCourseMainInformation extends CourseCreatingEvent {
  final Course course;
  final Completer? completer;
  PostCourseMainInformation({required this.course, this.completer});

  @override
  List<Object?> get props => [course, completer];
}



/*

// Файл events.dart
@freezed
abstract class DocumentEvent with _$DocumentEvent {
  const factory DocumentEvent.fetchDocuments() = _FetchDocuments;
  const factory DocumentEvent.createDocument(Document document) = _CreateDocument;
  const factory DocumentEvent.updateDocument(Document document) = _UpdateDocument;
  const factory DocumentEvent.deleteDocument(String documentId) = _DeleteDocument;
}

// Файл states.dart
@freezed
abstract class DocumentState with _$DocumentState {
  const factory DocumentState.documentsLoading() = DocumentsLoading;
  const factory DocumentState.documentsLoaded(List<Document> documents) = DocumentsLoaded;
  const factory DocumentState.documentError(String message) = DocumentError;
}

*/