import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_model_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<User>(),
  ],
)
void main() {
  late MockUser mockUser;

  setUp(() {
    mockUser = MockUser();
  });

  final tUserModel = UserModel(id: '1', email: 'jueandelacruz@gmail.com');

  test(
    'Should be a subclass of UserEntity entity',
    () async {
      // assert
      expect(tUserModel, isA<UserEntity>());
    },
  );

  test(
    'UserModel.fromFirebaseUser creates a UserModel with correct values',
    () async {
      const uid = '12345';
      const email = 'test@example.com';
      const displayName = 'Test User';

      // Set up mock values
      when(mockUser.uid).thenReturn(uid);
      when(mockUser.email).thenReturn(email);
      when(mockUser.displayName).thenReturn(displayName);

      // Act
      final userModel = UserModel.fromFirebaseUser(mockUser);

      // Assert
      expect(userModel.id, uid);
      expect(userModel.email, email);
      expect(userModel.name, displayName);
    },
  );
}
