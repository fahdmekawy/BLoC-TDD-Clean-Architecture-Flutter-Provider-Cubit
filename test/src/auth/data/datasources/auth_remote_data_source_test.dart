import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app_tutorial/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFireStore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {
  final String _uid = 'Test uid';

  @override
  String get uid => _uid;
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential();
}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late FirebaseStorage dbClient;
  late AuthRemoteDataSource dataSource;
  late UserCredential userCredential;

  setUp(() {
    authClient = MockFirebaseAuth();
    cloudStoreClient = MockFirebaseFireStore();
    dbClient = MockFirebaseStorage();
    userCredential = MockUserCredential();
    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });

  group('signIn', () {
    test(
      'should complete successfully when call to the server is successful',
      () async {
        // arrange
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);

        // act
        final result =
            await dataSource.signIn(email: 'em', password: 'password');

        // assert
        expect(result.email, equals('email'));
      },
    );
  });
}
