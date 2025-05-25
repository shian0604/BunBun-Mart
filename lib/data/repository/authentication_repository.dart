import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/data/repository/user/user_repository.dart';
import 'package:bunbunmart/login/email%20verification/bun_emailverification.dart';
import 'package:bunbunmart/login/login.dart';
import 'package:bunbunmart/pages/features/bun_onboardingscreen.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/pages/seller/seller_mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //get authenticated data
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

   Future<String> getUserRole(String userId) async {
    // Fetch the user role from Firestore or your database
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Sellers').doc(userId).get();
    if (snapshot.exists) {
      return 'seller'; // Return seller role
    } else {
      // Check if the user exists in the buyers collection
      snapshot = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
      if (snapshot.exists) {
        return 'buyer'; // Return buyer role
      } else {
        return 'unknown'; // Default case if user role is not found
      }
    }
  }


  //Screen redirecting in different screens based on the conditions
  void screenRedirect() async {
    final user = _auth.currentUser ;

    // Verified user login
    if (user != null) {
      if (user.emailVerified) {
        // Fetch user role from Firestore
        String userRole = await getUserRole(user.uid); // Call the method here

        // Redirect based on user role
        if (userRole == 'seller') {
          Get.offAll(() => SellerMainPage()); // Navigate to seller main page
        } else {
          Get.offAll(() => MainPage()); // Navigate to buyer main page
        }
      } else {
        Get.offAll(() => BunEmailVerification(email: user.email));
      }
    } else {
      // First-time flag setup
      await deviceStorage.writeIfNull('IsFirstTime', true);

      // Redirect based on flag
      if (deviceStorage.read('IsFirstTime') == true) {
        // Show onboarding if first time
        await deviceStorage.write('IsFirstTime', false); // mark as seen
        Get.offAll(() => const BunBunOnBoardingScreen());
      } else {
        // Otherwise, go to login
        Get.offAll(() => const LoginPage());
      }
    }
  }
  /* ----------------------------------------------------------- */

  //{Email Authentication} - Signin
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }

  //{Email Authentication} - Register
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }

  //{Email Authentication} - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }

  // {Email Authentication} - FORGOT PASSWORD
  Future<void> sendEPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }


  //{Reauthentication} - Reauthenticate User
  Future<void> reAuthenticateEmailAndPasswordUser(String email, String password) async {
    try {

      //create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      
      //reauthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }

  //{Email Authentication} - Signin

  /* ----------------------------------------------------------- */

  //{Google Authentication} - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger Authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtain auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //Create new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }

  //{Facebook Authentication} - Facebook

  /* ----------------------------------------------------------- */

  //{Logout User} - Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }

  //{Delete User} - Delete
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw BunFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Whoopsie! Something went wrong on our end. Give it another try, fur-iend! 🐾';
    }
  }
  
  
}
