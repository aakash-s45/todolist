class AuthError {
  static late String signInErrorMessage;
  static late String registerErrorMessage;
  static late String logoutErrorMessage;
  set signinError(String e) {
    signInErrorMessage = e;
  }

  set registerError(String e) {
    signInErrorMessage = e;
  }

  set logoutError(String e) {
    logoutErrorMessage = e;
  }
}
