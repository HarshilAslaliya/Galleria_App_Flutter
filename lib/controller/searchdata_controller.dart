import 'package:gallery_app/models/searchdata.dart';
import 'package:get/get.dart';

class SearchDataController extends GetxController{
  SearchData searchData = SearchData(s1: "Sports");

  void call(){
    searchData.s1;
    update();
  }
}