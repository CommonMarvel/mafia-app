import 'package:mafia_app/core/login/login_controller.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginController implements LoginController {
  final _facebookLogin = FacebookLogin();

  @override
  Future login() async {
    final result = await _facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print("success");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("cancelledByUser");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
    }

    return result;
  }

  @override
  Future logout() {
    return _facebookLogin.logOut();
  }
}