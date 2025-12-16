import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task03/model/auth_model.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore fireDB = FirebaseFirestore.instance;

  ///-----Signup-----
  Future<AuthModel?> signup({
    required String email,
    required String password,
    required String userName,
    required String confirmPassword,
    required int age,
    required String phoneNumber,
    required String address,
    required String gender,
    required String fullName,
    required DateTime dob,
  }) async {
    try {
      //Firebase user creation
      final UserCredential result = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = result.user!;

      //Send verification email
      await user.sendEmailVerification();

      //Create user profile
      final AuthModel authModel = AuthModel(
        uid: user.uid,
        email: user.email!,
        fullName: fullName,
        userName: userName,
        dob: dob,
        age: age,
        phoneNumber: phoneNumber,
        address: address,
        gender: gender,
      );

      //Save user profile to Firstore
      await fireDB.collection('users').doc(user.uid).set(authModel.toMap());
      // await fireDB.collection('users').doc(user.email).set(authModel.toMap());

      return authModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'SignUp failed');
    }
  }

  ///-----Login-----
  Future<AuthModel?> login(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = result.user!;

      if (!user.emailVerified) {
        throw Exception(
          "Email not verified. Please verify your email before logging in.",
        );
      }

      ///Fetch user profile form Firestore
      final DocumentSnapshot doc = await fireDB
          .collection('users')
          .doc(user.uid)
          .get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      
      return AuthModel.fromMap(doc.data() as Map<String, dynamic>);
      // -------------------********************-----------------------not used now-----------
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    }
  }

  ///-----Logout-----
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
