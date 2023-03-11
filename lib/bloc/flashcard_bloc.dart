import 'dart:async';

import 'package:flashcards/model/category.dart';
import 'package:flashcards/service/service/api_service.dart';
import 'package:flashcards/service/service/flashcard_service.dart';

class CategoryBloc {
  static final _categoryStream = CategoryBloc._internal();

  factory CategoryBloc() => _categoryStream;

  CategoryBloc._internal();

  final _categoryController = StreamController<List<Category>>.broadcast();

  Stream<List<Category>> get streamIssue => _categoryController.stream;

  final flashcards = <Category>[];



  ///API
  void getCategory() {
    apiService.getCategory().then((value) {
      if (value.isNotEmpty) {
        flashcards.addAll(value);
        print('check check : ${flashcards.length}');
        _categoryController.add(flashcards);
      }
    }).catchError((e) {
      _categoryController.addError(e.toString());
    });
  }
}
final categoryBloc = CategoryBloc();