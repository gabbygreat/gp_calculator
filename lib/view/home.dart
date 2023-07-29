import 'package:gp_calculator/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<CourseModel>> groupedCourses = [];
  String cgpa = '';

  @override
  void initState() {
    super.initState();
    for (var list in courses.keys) {
      groupedCourses.add(courses[list]!);
    }
  }

  void calculateGP() {
    List<CourseModel> allCourses = [];
    for (var list in groupedCourses) {
      for (var map in list) {
        allCourses.add(map);
      }
    }
    if (allCourses.any((element) => element.score == null)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Arsenal fan like you '),
        backgroundColor: Colors.red,
      ));
    } else {
      var totalCreditLoad = allCourses.fold(
          0, (previousValue, element) => previousValue + element.load);
      var totalQualityPoint = allCourses.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.load * grades[element.score]!));

      cgpa = (totalQualityPoint / totalCreditLoad).toStringAsFixed(2);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GP Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: groupedCourses.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Text(
                        'Year ${index + 1}',
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: groupedCourses[index].length,
                      itemBuilder: (context, position) => Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Builder(
                          builder: (context) {
                            var course = groupedCourses[index][position];
                            return Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    course.name,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: PopupMenuButton<int>(
                                    onSelected: (value) => setState(() =>
                                        groupedCourses[index]
                                            .replaceLoad(course, value)),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 0,
                                        child: Text('0'),
                                      ),
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Text('1'),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text('2'),
                                      ),
                                      const PopupMenuItem(
                                        value: 3,
                                        child: Text('3'),
                                      ),
                                      const PopupMenuItem(
                                        value: 4,
                                        child: Text('4'),
                                      ),
                                      const PopupMenuItem(
                                        value: 5,
                                        child: Text('5'),
                                      ),
                                      const PopupMenuItem(
                                        value: 6,
                                        child: Text('6'),
                                      ),
                                    ],
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text('${course.load}'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: PopupMenuButton<String>(
                                    onSelected: (value) => setState(() =>
                                        groupedCourses[index].replaceScore(
                                          course,
                                          value,
                                        )),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: "A",
                                        child: Text('A'),
                                      ),
                                      const PopupMenuItem(
                                        value: "B",
                                        child: Text('B'),
                                      ),
                                      const PopupMenuItem(
                                        value: "C",
                                        child: Text('C'),
                                      ),
                                      const PopupMenuItem(
                                        value: "D",
                                        child: Text('D'),
                                      ),
                                      const PopupMenuItem(
                                        value: "E",
                                        child: Text('E'),
                                      ),
                                      const PopupMenuItem(
                                        value: "F",
                                        child: Text('F'),
                                      ),
                                    ],
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        course.score == null
                                            ? 'Select grade'
                                            : '${course.score}',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: calculateGP,
                child: const Text('Calculate'),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                'Your CGPA IS: $cgpa',
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
