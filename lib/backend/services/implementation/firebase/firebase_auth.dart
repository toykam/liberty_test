import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/backend/models/user.dart' as TodoUser;
import 'package:todo_app/backend/services/auth.dart';

class FirebaseAuthentication implements AbstractAuthentication {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<TodoUser.User?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      final user = TodoUser.User(
        name: result.user!.displayName, 
        email: result.user!.email, phone: result.user!.phoneNumber,
        uid: result.user!.uid
      );
      return user;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<TodoUser.User?> signInWthEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = TodoUser.User(
        name: result.user!.displayName,
        email: result.user!.email, phone: result.user!.phoneNumber,
        uid: result.user!.uid
      );
      return user;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<TodoUser.User?> signUpWthEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = TodoUser.User(
        name: result.user!.displayName,
        email: result.user!.email, phone: result.user!.phoneNumber,
        uid: result.user!.uid
      );
      return user;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<TodoUser.User?> getCurrentUser() async {
    try {
      final res = _auth.currentUser;
      final user = TodoUser.User(
          name: res!.displayName,
          email: res.email, phone: res.phoneNumber,
          uid: res.uid
      );
      return user;
    } catch (error) {
      return null;
    }
  }

}