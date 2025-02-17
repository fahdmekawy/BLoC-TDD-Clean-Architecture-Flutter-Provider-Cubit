import 'package:education_app_tutorial/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent(
      {required this.title, required this.description, required this.image});

  const PageContent.first()
      : this(
          title: 'Brand new curriculum',
          description:
              'This is the first online educational platform designed by the '
              "world's top professors",
          image: MediaRes.casualReading,
        );

  const PageContent.second()
      : this(
          title: 'Brand a fun atmosphere',
          description:
              'This is the first online educational platform designed by the '
              "world's top professors",
          image: MediaRes.casualLife,
        );

  const PageContent.third()
      : this(
          title: 'Easy to join the lesson',
          description:
              'This is the first online educational platform designed by the '
              "world's top professors",
          image: MediaRes.casualMeditationScience,
        );
  final String title;
  final String description;
  final String image;

  @override
  List<Object?> get props => [title, description, image];
}
