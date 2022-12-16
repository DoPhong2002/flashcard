import '../const/category/category.dart';

class Flashcard {
  String? image;
  String? name;
  String? audio;
  bool isClick = false;

  Flashcard({this.image, this.name, this.audio});
}

class FlashcardModel {
  static final _model = FlashcardModel._internal();

  factory FlashcardModel() => _model;

  FlashcardModel._internal();

  final listFlashcardAlphabet = <Flashcard>[];
  final listFlashcardColor = <Flashcard>[];
  final listFlashcardAnimal = <Flashcard>[];
  final listFlashcardFamily = <Flashcard>[];
  final listFlashcardItem = <Flashcard>[];

  void createListFlashcard() {
    for (Map<String, dynamic> obj in jsonAlphabet) {
      final model = Flashcard(
          name: obj['Name'], image: obj['UrlPicture'], audio: obj['Audio']);
      listFlashcardAlphabet.add(model);
    }
    for (Map<String, dynamic> obj in jsonColor) {
      final model = Flashcard(
          name: obj['Name'], image: obj['UrlPicture'], audio: obj['Audio']);
      listFlashcardColor.add(model);
    }
    for (Map<String, dynamic> obj in jsonAnimal) {
      final model = Flashcard(
          name: obj['Name'], image: obj['UrlPicture'], audio: obj['Audio']);
      listFlashcardAnimal.add(model);
    }
    for (Map<String, dynamic> obj in jsonFamily) {
      final model = Flashcard(
          name: obj['Name'], image: obj['UrlPicture'], audio: obj['Audio']);
      listFlashcardFamily.add(model);
    }
    for (Map<String, dynamic> obj in jsonItem) {
      final model = Flashcard(
          name: obj['Name'], image: obj['UrlPicture'], audio: obj['Audio']);
      listFlashcardItem.add(model);
    }
  }
}

final model = FlashcardModel();
