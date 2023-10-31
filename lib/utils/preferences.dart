import 'package:firebase_phone_auth/utils/preference_utils.dart';

import '../constant/shared-pref-keys.dart';

class Preferences{

  static setUserUid(String uid) async {
    await PreferenceUtils.setString(UserUID, uid);
  }

  static String getUserUid() {
    return PreferenceUtils.getString(UserUID);
  }
}
