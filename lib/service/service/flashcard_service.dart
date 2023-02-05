import 'package:flashcards/service/category.dart';

import 'api_service.dart';

extension CategoryService on APIService {
  Future<List<Category>> getCategory() async {
    final result = await request(
      path: 'phong',
      method: Method.get,
    );
    final categories =
        List<Category>.from(result.map((e) => Category.fromJson(e)));
    return categories;
  }
}
