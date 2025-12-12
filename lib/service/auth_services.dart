
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task03/model/auth_model.dart';

class AuthServices {
  
   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


   Stream<AuthModel?> get userStream{
    return firebaseAuth.authStateChanges().map((fUser)=> 
    fUser != null ? AuthModel.fromFirebaseUser(fUser) : null);
   }

    ///Signup
   Future<AuthModel?> signup(String email, String password){
    try{
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password).then((userCredential) => AuthModel.fromFirebaseUser(userCredential.user),
      );}
      catch(e){
        rethrow;
      }
   }

   ///Login
   Future<AuthModel?> login(String email, String password){
    try{
    return firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password).then((userCredential) => AuthModel.fromFirebaseUser(userCredential.user));
    }
    catch(e){
      throw e;
    }
   }

    ///Logout
    Future<void> logout() async {
    await firebaseAuth.signOut();}
}