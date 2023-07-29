class CourseModel {
  String name;
  int load;
  String? score;
  CourseModel({
    required this.load,
    required this.name,
    this.score,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'load': load,
        'score': score,
      };
}
