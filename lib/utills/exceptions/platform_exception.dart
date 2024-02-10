class TPlatFormException implements Exception {
  final String code;
  TPlatFormException(this.code);
  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return "Invalid login credentials. PLease double-check your information";
      case 'too-many-requests':
        return "Too many requests. Please try again later.";
      case 'invalid-argument':
        return "Invalid argument provider to the authentication method.";
      case 'invalid-password':
        return "Incorrect password. Please try again.";
      case 'invalid-phone-number':
        return "The provider phon number is invalid.";
      case 'sign_in_failed':
        return "Sign-in failed. Please try again.";
      case 'internal-error':
        return "Internal error. Please try again later.";
      case 'invalid-verification-code':
        return "Invlaid verification code. Please enter valid code.";
      case 'network-request-failed':
        return "Network request failed. Please check your internet connection.";
      case 'session-cookie-expired':
        return "The Firebase session cookie has expired. Please sign in again";

      default:
        return 'An unexpected error occoured. Please try again.';
    }
  }
}
