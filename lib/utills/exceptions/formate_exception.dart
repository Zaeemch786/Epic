class TformateException implements Exception {
  final String message;
  TformateException(
      [this.message =
          'An unexpected formate error occourred. Please check your input.']);
  factory TformateException.fromMessage(String message) {
    return TformateException(message);
  }
  String get formattedMessage => message;
  factory TformateException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-formate':
        return TformateException(
            "The email adress formate is invalid. PLease enter a valid email.");
      case 'invalid-phone-number-formate':
        return TformateException(
            "The provider phone number formate is invalid. PLease enter a valid number.");
      case 'invalid-date-formate':
        return TformateException(
            "The date formate is invalid. PLease enter a valid date.");
      case 'invalid-url-formate':
        return TformateException(
            "The URL formate is invalid. PLease enter a valid URL.");
      case 'invalid-credit-card-formate':
        return TformateException(
            "The credit card formate is invalid. PLease enter a valid credit card number.");

      default:
        return TformateException();
    }
  }
}
