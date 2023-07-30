import 'package:gp_calculator/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Map<String, List<CourseModel>> groupedCourses;
  String cgpa = '';

  @override
  void initState() {
    super.initState();

    groupedCourses = courses.cast();
  }

  void calculateGP() {
    List<CourseModel> allCourses = [];
    for (var list in groupedCourses.values) {
      for (var map in list) {
        allCourses.add(map);
      }
    }
    if (allCourses.any((element) => element.score == null)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text(
                'Arsenal fan like you 😒',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          )
          .closed
          .whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 800),
                content: Text(
                  'Enter the grade for all courses! 🥸',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            ),
          );
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

  void openYearList() => showModalBottomSheet(
        showDragHandle: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select one of these',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: groupedCourses.length + 2,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Builder(builder: (context) {
                    var text = 'Year ${index + 1}';
                    if ((groupedCourses.length + 1) == index) {
                      text = 'Carry Over';
                    }
                    return Text(text);
                  }),
                  onTap: () {
                    Navigator.of(context).pop();
                    if ((groupedCourses.length + 1) == index) {
                      askName('5');
                    } else {
                      askName('${index + 1}');
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );

  void askName(String year) {
    var key = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 30,
          ),
          child: StatefulBuilder(
            builder: (context, refresh) {
              return Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FittedBox(
                      child: Text(
                        'Enter the course code',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'EXE 101',
                        errorStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        focusedErrorBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a course, jhoor 🙄';
                        }
                        if (!RegExp(r'^[A-Za-z]{3}\s\d{3}$').hasMatch(value)) {
                          return 'Enter a correct course code 🙏';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          if (!groupedCourses.containsKey(year)) {
                            groupedCourses.addAll({year: []});
                          }
                          groupedCourses[year]!.add(
                            CourseModel(load: 1, name: controller.text),
                          );
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      },
                      child: const Text('Add'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
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
      floatingActionButton: groupedCourses.length == 5
          ? null
          : FloatingActionButton(
              onPressed: openYearList,
              child: const Icon(
                Icons.add,
              ),
            ),
      bottomNavigationBar: Container(
        height: 120,
        color: Colors.blue,
        child: Row(
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
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/icon.png',
                ),
                opacity: 0.05,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 100),
                    shrinkWrap: true,
                    itemCount: groupedCourses.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      var courseYear = groupedCourses.keys.toList()[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 15,
                              bottom: 15,
                            ),
                            child: Builder(builder: (context) {
                              var text = 'Year $courseYear';
                              if (courseYear == '5') {
                                text = 'Carry Over';
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    text,
                                  ),
                                  if (courseYear != '1')
                                    IconButton(
                                      tooltip: 'Remove $text',
                                      onPressed: () {
                                        groupedCourses.remove(courseYear);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.red,
                                      ),
                                    )
                                ],
                              );
                            }),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                groupedCourses.values.toList()[index].length,
                            itemBuilder: (context, position) => Padding(
                              padding: const EdgeInsets.only(
                                left: 30,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Builder(
                                builder: (context) {
                                  var course = groupedCourses.values
                                      .toList()[index][position];
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          course.name.toUpperCase(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: PopupMenuButton<int>(
                                          onSelected: (value) => setState(
                                            () => groupedCourses[courseYear]![
                                                position] = course
                                              ..load = value,
                                          ),
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
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                              groupedCourses[courseYear]![
                                                  position] = course
                                                ..score = value),
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
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      if (groupedCourses[courseYear]!.length >
                                          1)
                                        IconButton(
                                          tooltip: 'Delete ${course.name}',
                                          onPressed: () {
                                            groupedCourses.values
                                                .toList()[index]
                                                .remove(course);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
