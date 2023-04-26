import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/models/wallpapers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../helpers/api_helper.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Wallpaper data = ModalRoute.of(context)!.settings.arguments as Wallpaper;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: data.image,
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width * 0.93,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(data.image), fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Get.isDarkMode?Colors.white:Colors.black,
                  mini: true,
                  elevation: 0,
                  onPressed: () {
                    Clipboard.setData(
                      new ClipboardData(text: data.image),
                    ).then((_) {});
                  },
                  child: Icon(
                    Icons.copy_rounded,
                    color: Get.isDarkMode?Colors.black:Colors.white,
                  ),
                ),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () async {
                    var status = await Permission.storage.request();
                    if (status.isGranted) {
                      var response = await Dio().get("${data.image}",
                          options: Options(responseType: ResponseType.bytes));
                      final result = await ImageGallerySaver.saveImage(
                          Uint8List.fromList(response.data),
                          quality: 60,
                          name: "hello");
                      log(result);
                    }
                  },
                  backgroundColor: Get.isDarkMode?Colors.white:Colors.black,
                  mini: true,
                  child: Icon(
                    Icons.download,
                    color: Get.isDarkMode?Colors.black:Colors.white,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Get.isDarkMode?Colors.white:Colors.black,
                  mini: true,
                  elevation: 0,
                  onPressed: () async {
                    await Share.share(data.image);
                  },
                  child: Icon(
                    Icons.share,
                    color: Get.isDarkMode?Colors.black:Colors.white,
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
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
                                  // Navigator.of(context).pushReplacementNamed(
                                  //     "download_page",
                                  //     arguments: data);
                                },
                                child: Container(
                                  height: data[i].height.toDouble() + 150,
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
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(data[i].image),
                                        fit: BoxFit.cover),
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
    );
  }
}
