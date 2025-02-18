import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.points,
    this.groupIds = const [],
    this.followers = const [],
    this.following = const [],
    this.enrolledCoursesIds = const [],
    this.bio,
    this.profilePic,
  });

  const LocalUser.empty()
      : this(
          uid: '',
          fullName: '',
          email: '',
          points: 0,
          groupIds: const [],
          followers: const [],
          following: const [],
          enrolledCoursesIds: const [],
        );

  final String uid;
  final String fullName;
  final String email;
  final String? bio;
  final String? profilePic;
  final int points;
  final List<String> groupIds;
  final List<String> followers;
  final List<String> following;
  final List<String> enrolledCoursesIds;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser(uid: $uid, email: $email, bio: $bio, '
        'points: $points , fullName: $fullName)';
  }
}
