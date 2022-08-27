import 'package:flutter/foundation.dart';

import '../model/favorites_list.dart';

class FavoritesProductProvider extends ChangeNotifier {
  FavoritesListModel? favoritesListModel;
  FavoritesListModel? get list => favoritesListModel;
  set favoritesList(FavoritesListModel model) {
    favoritesListModel = model;
    notifyListeners();
  }
}
