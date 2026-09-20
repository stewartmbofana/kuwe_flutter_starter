import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      await _saveUserProfile();
    } on Exception catch (error) {
      debugPrint('Google sign-in failed: $error');
      rethrow;
    }
  }

  Future<void> signInWithFacebook() async {
    final facebookProvider = FacebookAuthProvider();
    await _signInWithProvider(facebookProvider);
  }

  Future<void> signInWithTwitter() async {
    final twitterProvider = TwitterAuthProvider();
    await _signInWithProvider(twitterProvider);
  }

  Future<void> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    await _signInWithProvider(appleProvider);
  }

  Future<void> signInWithMicrosoft() async {
    final microsoftProvider = OAuthProvider('microsoft.com');
    await _signInWithProvider(microsoftProvider);
  }

  Future<void> signInWithGitHub() async {
    final githubProvider = GithubAuthProvider();
    await _signInWithProvider(githubProvider);
  }

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), GoogleSignIn().signOut()]);
  }

  Future<void> _signInWithProvider(AuthProvider provider) async {
    try {
      await _firebaseAuth.signInWithProvider(provider);
      await _saveUserProfile();
    } on Exception catch (error) {
      debugPrint('Provider sign-in failed: $error');
      rethrow;
    }
  }

  Future<void> _saveUserProfile() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return;
    }

    final profile = {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
      'lastSeen': FieldValue.serverTimestamp(),
      'providers': user.providerData
          .map((profileData) => profileData.providerId)
          .toList(),
    };

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(profile, SetOptions(merge: true));
  }
}
