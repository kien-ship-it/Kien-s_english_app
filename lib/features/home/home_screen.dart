import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/material.dart';

import '../../GlobalData.dart';
import '../../services/store.dart';
import '../lesson/IndividualLesson/ALessonScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LessonModel> listRecentLesson = [];
  List<LessonModel> listFavoriteLesson = [];

  @override
  void initState() {
    super.initState();
    listRecentLesson = GlobalData.getListPersonalLessonSortByTime();
    listFavoriteLesson = GlobalData.getListFavoriteLesson();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFEFF5F5),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Home",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade300, width: 2.5),
                  ),
                  height: 325,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 5),
                        child: const Row(children: [
                          Icon(
                            Icons.access_time,
                            size: 40,
                            color: Color(0xFFEB6440),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Recent",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          )
                        ]),
                      ),
                      listRecentLesson.isEmpty
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 10),
                      listRecentLesson.isEmpty
                          ? const Expanded(
                              child: Center(
                                  child: Text(
                              "No Recent Lessons Yet",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            )))
                          : Expanded(
                              child: Scrollbar(
                                radius: const Radius.circular(18),
                                child: ListView.builder(
                                  itemCount: listRecentLesson.length,
                                  itemBuilder: (context, index) {
                                    return homeLessonWidget(
                                      listRecentLesson[index].title,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ALessonScreen(
                                                lessonModel:
                                                    listRecentLesson[index]),
                                          ),
                                        ).then((value) => setState(() {
                                              // update time
                                              FireStore
                                                  .updateLatestOpenedDateById(
                                                      listRecentLesson[index]
                                                              .id ??
                                                          "",
                                                      DateTime.now()
                                                          .toIso8601String());
                                            }));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 4.0,
                    //     offset: Offset(0, 1),
                    //   ),
                    // ],
                    border: Border.all(color: Colors.grey.shade300, width: 2.5),
                  ),
                  height: 325,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 5),
                        child: const Row(children: [
                          Icon(
                            Icons.favorite,
                            size: 40,
                            color: Color(0xFFEB6440),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Favorites",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          )
                        ]),
                      ),
                      listFavoriteLesson.isEmpty
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 10),
                      listFavoriteLesson.isEmpty
                          ? const Expanded(
                              child: Center(
                                  child: Text(
                              "No Favorite Lessons Yet",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            )))
                          : Expanded(
                              child: Scrollbar(
                                radius: const Radius.circular(18),
                                child: ListView.builder(
                                  itemCount: listFavoriteLesson.length,
                                  itemBuilder: (context, index) {
                                    return homeLessonWidget(
                                      listFavoriteLesson[index].title,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ALessonScreen(
                                                lessonModel:
                                                    listFavoriteLesson[index]),
                                          ),
                                        ).then((value) => setState(() {
                                              // update time
                                              FireStore
                                                  .updateLatestOpenedDateById(
                                                      listRecentLesson[index]
                                                              .id ??
                                                          "",
                                                      DateTime.now()
                                                          .toIso8601String());
                                            }));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget homeLessonWidget(String title, VoidCallback onTap) {
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
    decoration: BoxDecoration(
      color: const Color(0xFFBFDEE2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                // add border
                border: Border.all(color: const Color(0xFFEB6440), width: 2),
              ),
              child: const Icon(
                Icons.chevron_right,
                size: 40,
                color: Color(0xFFEB6440),
              )),
        )
      ],
    ),
  );
}
