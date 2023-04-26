import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/api_helper.dart';
import '../../models/wallpapers.dart';
import '../../res/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox.expand(
                      child: Image(
                        image: AssetImage('assets/images/nature.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      color: Colors.black12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Spacer(
                              flex: 4,
                            ),
                            Hero(
                              tag: "title",
                              child: Text(
                                "Galleria",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white60,
                                )),
                              ),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            IconButton(
                              onPressed: () {
                                Get.changeTheme(Get.isDarkMode
                                    ? ThemeData.light()
                                    : ThemeData.dark());
                              },
                              icon: Icon(
                                Get.isDarkMode
                                    ? Icons.dark_mode
                                    : Icons.dark_mode_outlined,
                                color: Colors.white,
                              ),
                              // Icon(
                              //   Icons.light_mode,
                              //   color: Colors.white,
                              // ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: CupertinoSearchTextField(
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                            controller: searchController,
                            onSubmitted: (val) {
                              setState(() {
                                Global.searchData = val;
                              });
                            },
                            placeholder: "Search",
                            backgroundColor: Get.isDarkMode
                                ? Colors.grey.shade800
                                : Colors.white,
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Categories",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        buildCategories(size,
                            picture: 'assets/images/sports.jpg',
                            category: 'Sports'),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        buildCategories(size,
                            picture: 'assets/images/car.jpg', category: 'Cars'),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        buildCategories(size,
                            picture: 'assets/images/yoga.jpg',
                            category: 'Yoga'),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        buildCategories(size,
                            picture: 'assets/images/nature1.jpg',
                            category: 'Nature'),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        buildCategories(size,
                            picture: 'assets/images/wallpaper.jpg',
                            category: 'Wallpaper'),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Photos",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: FutureBuilder(
                      future: ApiHelpers.apiHelpers.getData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error is : ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          List<Wallpaper>? data = snapshot.data;
                          return (data != null)
                              ? MasonryGridView.builder(
                                  padding: EdgeInsets.all(10),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: data.length,
                                  gridDelegate:
                                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            "/download_page",
                                            arguments: data[i]);
                                      },
                                      child: Hero(
                                        tag: data[i].image,
                                        child: Container(
                                          height:
                                              data[i].height.toDouble() + 150,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                spreadRadius: 1,
                                                offset: Offset(3, 3),
                                                color: Colors.black38,
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white.withOpacity(0.3),
                                                  Colors.white.withOpacity(0.6)
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(data[i].image),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text("Data is Not Founds ...."),
                                );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildCategories(Size size,
      {required String picture, required String category}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Global.searchData = category;
          searchController.clear();
          searchController.text = category;
        });
      },
      child: Container(
        height: size.height * 0.078,
        width: size.width * 0.33,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(picture), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            Text(
              category,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget m1(BuildContext context) {
//   return MasonryGridView.builder(
//       padding: EdgeInsets.all(10),
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       physics: BouncingScrollPhysics(),
//       itemCount: details.length,
//       gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemBuilder: (context, i) {
//         return Stack(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, 'detailpage',
//                     arguments: details[i]);
//               },
//               child: Container(
//                 height: details[i]['height'],
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                 ),
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "${details[i]['name']}",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, 'detailpage',
//                     arguments: details[i]);
//               },
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                 ),
//                 child: Image(
//                   image: details[i]['image'],
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ],
//         );
//       });
// }
}
