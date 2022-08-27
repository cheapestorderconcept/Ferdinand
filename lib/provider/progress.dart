import 'package:flutter/foundation.dart';

class IsLoading extends ChangeNotifier {
  bool _progress = false;
  bool get progress => _progress;

  set setprogressIndicator(bool newProgress) {
    if (_progress != newProgress) {
      _progress = newProgress;

      notifyListeners();
      return;
    }
    _progress = false;
    notifyListeners();
  }

  updateIndicator(bool status) {
    _progress = status;

    notifyListeners();
  }
}
