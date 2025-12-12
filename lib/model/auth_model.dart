
class AuthModel {
  final String uid;
  final String email;
  AuthModel({required this.uid, required this.email});


  factory AuthModel.fromFirebaseUser(user){
    return AuthModel(
      uid: user.uid,
      email: user.email,
    );
  }
}