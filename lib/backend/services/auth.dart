
import 'package:todo_app/backend/models/user.dart';

abstract class AbstractAuthentication {
  // SignIn Anonymously
  Future<User?> signInAnonymously();

  // sign in with email and password
  Future<User?> signInWthEmailAndPassword(String email, String password);

  // register with email and password
  Future<User?> signUpWthEmailAndPassword(String email, String password);

  // get current logged in user
  Future<User?> getCurrentUser();
  // signout
  Future<bool> signOut();
}