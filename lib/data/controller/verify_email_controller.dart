import 'dart:async';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/login/email%20verification/bun_emailsuccess.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  Timer? _timer;
  final int _maxDurationInSeconds = 120; // 2 minutes
  int _elapsedSeconds = 0;

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Clean up timer when controller is disposed
    super.onClose();
  }

  // Send email verification link
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      BunSnackBar.bunsuccess(
        title: "Email sent",
        message: "Please check your inbox and verify your email",
      );
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }

  // Timer to automatically redirect on Email Verification
  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      if (_elapsedSeconds > _maxDurationInSeconds) {
        timer.cancel();
        BunSnackBar.bunerror(
          title: "Verification Timeout",
          message: "Email verification took too long. Try again later. ⏳",
        );
        return;
      }
      _checkEmailVerification(timer);
    });
  }

  Future<void> _checkEmailVerification(Timer timer) async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => BunEmailSuccess(
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    } catch (e) {
      timer.cancel();

      // Show a friendly error message
      BunSnackBar.bunerror(
        title: "Verification Failed",
        message:
            "We couldn't verify your email status right now. Please try again later. 🐾",
      );
    }
  }

  // Manually check if Email is Verified
  Future<void> checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser?.emailVerified ?? false) {
      Get.off(
        () => BunEmailSuccess(
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
