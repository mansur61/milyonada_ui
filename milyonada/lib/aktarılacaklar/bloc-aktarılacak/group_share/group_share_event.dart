abstract class GroupShareEvent {}

class TextChanged extends GroupShareEvent {
  final String text;
  TextChanged(this.text);
}

class SubmitShare extends GroupShareEvent {}

class OpenGallery extends GroupShareEvent {}

class OpenCamera extends GroupShareEvent {}

class AddLink extends GroupShareEvent {}
