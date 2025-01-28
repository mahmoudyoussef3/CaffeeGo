import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationMethods {
  //Todo Create account with email and password
  Future<UserCredential?> createAccountWithEmailAndPassword(String email,
      String password, String phoneNumber, String fullName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: email);
      var user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'displayName': fullName,
        'email': email,
        'uid': user.uid,
        'created_at': Timestamp.now(),
        'phoneNumber': phoneNumber,
        'cart': [],
      });
      return userCredential;
    } on FirebaseException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message,
      );
    }
  }

//todo Create Authenticate with google mail(gmail)
  signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Google sign-in aborted by user';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'displayName': userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
        'created_at': Timestamp.now(),
        'phoneNumber':
            userCredential.user!.phoneNumber ?? 'No phone number provided',
        'img': userCredential.user!.photoURL ?? '',
        'cart': [],
      });
    } catch (e) {
      print('Error during Google sign-in: $e');
      throw 'Google sign-in failed: $e';
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No account found with this email. Please sign up.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }

      throw FirebaseAuthException(
        code: e.code,
        message: errorMessage,
      );
    }
  }
}
