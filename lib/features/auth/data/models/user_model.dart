import 'package:firebase_auth/firebase_auth.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    super.name,
    super.photoUrl,
  });

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      name: firebaseUser.displayName ?? '',
    );
  }
}
