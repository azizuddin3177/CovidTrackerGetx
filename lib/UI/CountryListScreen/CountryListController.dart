import 'dart:convert';
import 'dart:developer';
import 'package:covid22222222222222222/Services/app_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Models/CountryListModel.dart';

class CountryController extends GetxController {

  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  List<CountryListModel> filteredCountryList = RxList<CountryListModel>();
  @override
  void onInit() {
    super.onInit();
    fetchCountryListApi();
  }

  List<CountryListModel> countryList = []; // List to hold country data

  Future<void> fetchCountryListApi() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.countriesList));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        countryList = responseData.map((countryData) {
          return CountryListModel.fromJson(countryData);
        }).toList();
        update();
      } else {
        throw Exception('Failed to fetch country list');
      }
    } catch (e) {
      log('Error fetching country list: $e');
    }
  }

  void filterCountryList(String searchText) {
    if (searchText.isEmpty) {
      filteredCountryList.assignAll(countryList);
    } else {
      filteredCountryList.assignAll(countryList.where((country) {
        return country.country
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList());
    }
    update();
  }
}
