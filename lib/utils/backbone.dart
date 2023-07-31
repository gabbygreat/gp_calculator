import 'package:gp_calculator/utils/utils.dart';

var grades = {
  "A": 5,
  "B": 4,
  "C": 3,
  "D": 2,
  "E": 1,
  "F": 0,
};

Map<String, List<CourseModel>> courses = {
  "1": [
    CourseModel(load: 1, name: "GS 101"),
    CourseModel(load: 2, name: "GS 105"),
    CourseModel(load: 2, name: "GS 107"),
    CourseModel(load: 2, name: "ICH 101"),
    CourseModel(load: 1, name: "PHY 107"),
    CourseModel(load: 2, name: "ICH 111"),
    CourseModel(load: 3, name: "FEG 101"),
    CourseModel(load: 3, name: "MAT 101"),
    CourseModel(load: 3, name: "PHY 101"),
    CourseModel(load: 2, name: "BUS 101"),
    CourseModel(load: 3, name: "PHY 102"),
    CourseModel(load: 1, name: "GS 102"),
    CourseModel(load: 1, name: "GS 110"),
    CourseModel(load: 2, name: "GS 106"),
    CourseModel(load: 2, name: "ICH 102"),
    CourseModel(load: 2, name: "ICH 112"),
    CourseModel(load: 3, name: "MAT 102"),
    CourseModel(load: 1, name: "PHY 102"),
    CourseModel(load: 1, name: "PHY 108"),
    CourseModel(load: 3, name: "FEG 102"),
    CourseModel(load: 2, name: "FEG 103"),
  ],
  "2": [
    CourseModel(load: 3, name: "MAT 201"),
    CourseModel(load: 2, name: "ICH 221"),
    CourseModel(load: 2, name: "FEG 221"),
    CourseModel(load: 2, name: "CSC 201"),
    CourseModel(load: 3, name: "FEG 201"),
    CourseModel(load: 2, name: "FEG 211"),
    CourseModel(load: 2, name: "FEG 213"),
    CourseModel(load: 2, name: "FEG 250"),
    CourseModel(load: 2, name: "FEG 281"),
    CourseModel(load: 3, name: "MAT 202"),
    CourseModel(load: 2, name: "BUS 204"),
    CourseModel(load: 1, name: "CSC 202"),
    CourseModel(load: 3, name: "FEG 202"),
    CourseModel(load: 2, name: "FEG 280"),
    CourseModel(load: 2, name: "FEG 212"),
    CourseModel(load: 2, name: "FEG 214"),
    CourseModel(load: 2, name: "FEG 215"),
    CourseModel(load: 2, name: "FEG 282"),
    CourseModel(load: 2, name: "FEG 242"),
  ],
  "3": [
    CourseModel(load: 3, name: "FEG 303"),
    CourseModel(load: 2, name: "ELE 343"),
    CourseModel(load: 2, name: "ELE 311"),
    CourseModel(load: 2, name: "ECE 323"),
    CourseModel(load: 3, name: "ELE 353"),
    CourseModel(load: 3, name: "ELE 341"),
    CourseModel(load: 2, name: "ECE 331"),
    CourseModel(load: 2, name: "ECE 321"),
    CourseModel(load: 2, name: "ECE 333"),
    CourseModel(load: 2, name: "ELE 372"),
    CourseModel(load: 2, name: "ELE 312"),
    CourseModel(load: 3, name: "ECE 326"),
    CourseModel(load: 2, name: "ECE 328"),
    CourseModel(load: 3, name: "ELE 382"),
    CourseModel(load: 2, name: "ELE 344"),
    CourseModel(load: 2, name: "ELE 342"),
    CourseModel(load: 2, name: "ECE 322"),
    CourseModel(load: 1, name: "ELE 314"),
    CourseModel(load: 3, name: "ECE 334")
  ],
  "4": [
    CourseModel(load: 3, name: "ELE 403"),
    CourseModel(load: 2, name: "CVE 423"),
    CourseModel(load: 3, name: "ECE 427"),
    CourseModel(load: 3, name: "ELE 445"),
    CourseModel(load: 3, name: "ELE 453"),
    CourseModel(load: 3, name: "ELE 473"),
    CourseModel(load: 3, name: "FEG 404"),
    CourseModel(load: 3, name: "ECE 405"),
    CourseModel(load: 6, name: "IT"),
  ],
  "5": [],
  "6": [],
};
