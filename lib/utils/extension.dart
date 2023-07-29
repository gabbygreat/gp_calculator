import 'package:gp_calculator/utils/utils.dart';

extension CourseListExtension on List<CourseModel> {
  void replaceLoad(CourseModel course, int newLoad) {
    for (int i = 0; i < length; i++) {
      if (this[i] == course) {
        this[i] = CourseModel(
          load: newLoad,
          name: course.name,
          score: course.score,
        );
        break; // Optional: To stop after the first match is found
      }
    }
  }

  void replaceScore(CourseModel course, String score) {
    for (int i = 0; i < length; i++) {
      if (this[i] == course) {
        this[i] = CourseModel(
          load: course.load,
          name: course.name,
          score: score,
        );
        break; // Optional: To stop after the first match is found
      }
    }
  }
}
