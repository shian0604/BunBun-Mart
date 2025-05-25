class BunFirebaseAuthException implements Exception {
  final String code;

  BunFirebaseAuthException({required this.code});

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Paw-don us! That email is already registered with a BunBun account.';
      case 'invalid-email':
        return 'Hmm... that doesn’t look like a valid email. Could you double-check it? 🧐';
      case 'operation-not-allowed':
        return 'This type of login isn’t enabled yet—stay tuned, fur-iend!';
      case 'weak-password':
        return 'Your password needs more bite! Try something stronger. 💪🐾';
      case 'user-disabled':
        return 'This BunBun account has been deactivated. Please contact support.';
      case 'user-not-found':
        return 'We couldn’t find an account with those details. 🕵️‍♀️';
      case 'wrong-password':
        return 'Oops! That password isn’t quite right. Try again!';
      case 'too-many-requests':
        return 'Whoa there! Too many tries. Take a short break and try again soon. 🐢';
      case 'invalid-credential':
        return 'Something’s wrong with those login credentials. Please try again.';
      case 'account-exists-with-different-credential':
        return 'Looks like you’ve signed up with a different method before!';
      case 'invalid-verification-code':
        return 'That verification code isn’t correct. Could you try entering it again? 🔐';
      default:
        return 'Uh-oh! Something went wrong during sign up. [Error: $code]';
    }
  }
}

class BunFirebaseException implements Exception{
  final String code;

  BunFirebaseException({required this.code});

  String get message {
    switch (code) {
      case 'network-request-failed':
        return 'No connection? Oh no! 🐶 Try checking your Wi-Fi or mobile data.';
      case 'timeout':
        return 'Things are taking a bit too long... try again in a moment. ⏳';
      case 'unavailable':
        return 'Firebase is catching its breath. Please try again later!';
      case 'permission-denied':
        return 'You don’t have pawsmission to do that! 🐾';
      case 'resource-exhausted':
        return 'Our paws are full right now. Please try again later!';
      default:
        return 'Firebase ran into a hiccup. [Error: $code]';
    }
  }
}

class BunPlatformException implements Exception{
  final String code;

  BunPlatformException({required this.code});

  String get message {
    switch (code) {
      case 'sign_in_failed':
        return 'Sign-in didn’t go as planned—give it another try, paw-lease!';
      case 'not-available':
        return 'This feature isn’t available on your device. 🛠️';
      case 'invalid-argument':
        return 'Something’s not right with the input. Try rechecking the details!';
      case 'platform-unavailable':
        return 'Your platform isn’t cooperating right now. 🧩';
      default:
        return 'Something’s off on the platform side. [Error: $code]';
    }
  }
}

class BunFormatException implements Exception {
  final String message;

  const BunFormatException([this.message = 'Oh no! An unexpected error occurred. Please check your input.']);

  factory BunFormatException.fromCode(String code) {
    switch (code) {
      case 'empty-field':
        return BunFormatException('Oops! Looks like you missed a spot. All fields must be filled. 📝');
      case 'invalid-email-format':
        return BunFormatException('That doesn’t look like a proper email. Can you double-check it? 📧');
      case 'invalid-phone-format':
        return BunFormatException('Hmm... That phone number seems off. Make sure it’s correct! ☎️');
      case 'invalid-name-format':
        return BunFormatException('Names should only contain letters. Paw-lease try again!');
      case 'number-expected':
        return BunFormatException('Numbers only in this field, fur-iend! 🧮');
      case 'date-format-error':
        return BunFormatException('That date format looks confusing! Try using MM/DD/YYYY. 📅');
      case 'password-mismatch':
        return BunFormatException('Uh-oh! Those passwords don’t match. Try again. 🔐');
      default:
        return BunFormatException('Something’s wrong with the input format. [Error: $code]');
    }
  }

  String get formattedMessage => message;
}
