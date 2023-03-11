import 'dart:async';
import 'dart:convert';

 import 'package:flashcards/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedStream {
  static final _stream = SelectedStream._internal();

  factory SelectedStream() => _stream;

  SelectedStream._internal();

  final _selectedStream = StreamController<List<Flashcard>>.broadcast();

  Stream<List<Flashcard>> get selectedStream => _selectedStream.stream;

  final listFlashcardSelected = <Flashcard>[];
  SharedPreferences? preferences;

  void onAddItemSelected(Flashcard flashcard) {
    listFlashcardSelected.add(flashcard);
    saveListProductSelected();
    _selectedStream.add(listFlashcardSelected);
  }

  void onRemoveItemSelected(Flashcard flashcard) {
    listFlashcardSelected.remove(flashcard);
    saveListProductSelected();
    _selectedStream.add(listFlashcardSelected);
  }

  Future saveListProductSelected() async {
    List<String> listDataString = [];

    for (Flashcard flashcard in listFlashcardSelected) {
      // b1: chuyen Model ve Map
      Map<String, dynamic> dataJson = Map<String, dynamic>();
      dataJson['name'] = flashcard.name;
      dataJson['audio'] = flashcard.audio;
      dataJson['image'] = flashcard.urlPicture;
      dataJson['isClick'] = flashcard.isClick;

      // b2: chuyển Map thành String
      String dataString = jsonEncode(dataJson);

      listDataString.add(dataString);
    }
    preferences ??= await SharedPreferences.getInstance();
    preferences!.setStringList('dataFlashcard', listDataString);
  }

  Future getListProductSelected() async {
    preferences ??= await SharedPreferences.getInstance();
    List<String>? dataListString = preferences!.getStringList('dataFlashcard');
    if (dataListString != null) {
      for (String obj in dataListString) {
        // b1 chuyen string ve map
        Map<String, dynamic> dataMap = jsonDecode(obj);

        // b2 chuyen map ve model
        Flashcard flashcard = Flashcard();
        flashcard.name = dataMap['name'];
        flashcard.urlPicture = dataMap['image'];
        flashcard.audio = dataMap['audio'];
        flashcard.isClick = dataMap['isClick'];
        listFlashcardSelected.add(flashcard);
      }
    }
    _selectedStream.add(listFlashcardSelected);
  }
}

final selectedBloc = SelectedStream();
