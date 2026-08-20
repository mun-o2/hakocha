import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Appleサインインの実装
  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    return _auth.signInWithProvider(appleProvider);
  }

  // Googleサインインの実装
  Future<void> initializeGoogleSignIn() async {
    await _googleSignIn.initialize();
  }

  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.initialize();

    final GoogleSignInAccount account = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication authentication = account.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
