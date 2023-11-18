import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
import '../../Models/WorldStateModels.dart';
import '../../Services/app_urls.dart';




class WorldStateController extends GetxController{
  @override
  void onInit()async {
    super.onInit();
    worldStateModels= await fetchWorldStateRecord();
  }

  WorldStateModels? worldStateModels;

  Future<WorldStateModels?> fetchWorldStateRecord() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.wotlsStateApi));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        WorldStateModels? worldStateModel = WorldStateModels.fromJson(jsonData);
        update();
        return worldStateModel;
      } else {
        return null;

      }
    } catch (e) {
      return null;
    }
  }





}


