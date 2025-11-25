import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // INSCRIPTION
  Future<String?> signUp(String email, String password, String phone) async {
    try {
      // Creation du compte Firebase Auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Vous pouvez enregistrer l'utilisateur dans Firestore si nécessaire
      // (optionnel selon ton projet)

      return null; // Aucun message d'erreur → succès
    } catch (e) {
      return e.toString();
    }
  }

  // CONNEXION
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
