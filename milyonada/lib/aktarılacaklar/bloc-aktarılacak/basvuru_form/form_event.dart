abstract class FormEvent {}

class NameChanged extends FormEvent {
  final String name;
  NameChanged(this.name);
}

class PurposeChanged extends FormEvent {
  final String purpose;
  PurposeChanged(this.purpose);
}

class NoteChanged extends FormEvent {
  final String note;
  NoteChanged(this.note);
}

class SubmitForm extends FormEvent {}
