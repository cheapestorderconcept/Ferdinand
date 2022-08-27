import 'package:ferdinand_coffee/model/favorites_list.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  int _numberofitemordered = 1;

  bool _numberofgram = true;
  bool _showbuttombar = true;
  int? itemSelect;
  get getnumberofgram => _numberofgram;
  int? get itemSelected => itemSelect;
  get getnumberofitemordered => _numberofitemordered;
  get showbuttombar => _showbuttombar;
  togglegramtrue() {
    _numberofgram = true;
    notifyListeners();
  }

  selectedgram(int? index) {
    itemSelect = index;
    print(itemSelect);
    notifyListeners();
  }

  togglebuttombartotrue() {
    _showbuttombar = true;
    notifyListeners();
  }

  togglebuttombartofalse() {
    _showbuttombar = false;
    notifyListeners();
  }

  togglegramfalse() {
    _numberofgram = false;
    notifyListeners();
  }

  increasenumberofitemordered() {
    _numberofitemordered = _numberofitemordered + 1;
    notifyListeners();
  }

  decreasenumberofitemorderedd() {
    if (_numberofitemordered == 1) {
      _numberofitemordered = 1;
    } else {
      _numberofitemordered = _numberofitemordered - 1;
    }
    notifyListeners();
  }
}
