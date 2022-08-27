import 'package:flutter/foundation.dart';

import '../model/Profile.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? myprofileModel;
  ProfileModel? get profile => myprofileModel;

  set setProfile(ProfileModel? p) {
    myprofileModel = p;
    notifyListeners();
  }
}
