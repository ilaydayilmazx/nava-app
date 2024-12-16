import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authChanges => _firebaseAuth.authStateChanges();

  // Sign up
  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign in
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Şifreyi değiştirme
  Future<void> changePassword(String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        // Kullanıcıyı yeniden kimlik doğrulaması yapacak şekilde doğrulama işlemi
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password:
              'currentPassword', // Mevcut şifrenin kullanıcı tarafından girilmesi gerekebilir
        );

        // Burada doğru türde bir dönüşüm yapılabilir.
        EmailAuthCredential emailCredential = credential as EmailAuthCredential;

        await user.reauthenticateWithCredential(emailCredential);

        // Şifreyi güncelleme
        await user.updatePassword(newPassword);
        await user.reload();
        user = _firebaseAuth.currentUser;
      }
    } catch (e) {
      throw e; // Hata durumunda yeniden fırlatılacak
    }
  }
}
