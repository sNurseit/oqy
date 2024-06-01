part of 'course_creating_bloc.dart';

//---------------------------CourseCreating--------------------------------
abstract class CourseCreatingEvent extends Equatable{}


class LoadCourseCreating extends CourseCreatingEvent{
  final int? courseId;
  final Completer? completer;

  LoadCourseCreating({this.courseId, this.completer});
  @override
  List<Object?> get props => [courseId, completer];
}

class LoadModule extends CourseCreatingEvent{
  
  final Completer? completer;
  final int step;

  LoadModule({required this.step, this.completer});
  @override
  List<Object?> get props => [completer, step];
}

class PopNavigate extends CourseCreatingEvent{
  final BuildContext buildContext;

  PopNavigate({required this.buildContext});

  @override
  List<Object?> get props => [buildContext];

}

class LoadMaterial extends CourseCreatingEvent{
  
  final Completer? completer;
  final int step;
  final int moduleStep;

  LoadMaterial({required this.step, required this.moduleStep, this.completer});
  @override
  List<Object?> get props => [completer,step,moduleStep];
}

class LoadCourseCategory extends CourseCreatingEvent{
  final Completer? completer;
  LoadCourseCategory({this.completer});
  @override
  List<Object?> get props => [completer];
}

class AddModule extends CourseCreatingEvent{
  final BuildContext context;
  final String title;
  final String description;
  final int type;
  final int? id;
  final int? step;

  AddModule({required this.context,required this.title, required this.description, required this.type, required this.id, this.step});

  @override
  List<Object?> get props =>[title, description, type, id];
}

class ChangeModuleStep extends CourseCreatingEvent{
  final List<ModuleType> moduleTypes;

  ChangeModuleStep({required this.moduleTypes});

  @override
  List<Object?> get props => [moduleTypes];

}

class PostCourseMainInformation extends CourseCreatingEvent {
  final Course course;
  final Completer? completer;
  PostCourseMainInformation({required this.course, this.completer});

  @override
  List<Object?> get props => [course, completer];
}

class NavigateToMaterial extends CourseCreatingEvent{
  final BuildContext buildContext;
  final int materialStep;
  final int moduleStep;
  
  NavigateToMaterial({required this.buildContext, required this.materialStep, required this.moduleStep});
  @override
  List<Object?> get props => [buildContext,materialStep,moduleStep];
}

class NavigateToModule extends CourseCreatingEvent {
  final BuildContext buildContext;
  final StepItem moduleType;

  
  NavigateToModule({required this.buildContext, required this.moduleType});
  @override
  List<Object?> get props =>[buildContext, moduleType];
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