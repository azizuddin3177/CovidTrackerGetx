import 'package:covid22222222222222222/UI/CounryDetaileScreen/country_detail_screen.dart';
import 'package:covid22222222222222222/UI/CountryListScreen/CountryListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';






class CountriesListScreen extends StatelessWidget {
  CountriesListScreen({Key? key}) : super(key: key);

  final  cntroller = Get.put(CountryController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryController>(
      builder: (__) {
        if(__.countryList.isEmpty){
          {
            return Scaffold(
              body: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListTile(
                        leading: Container(height: 50,width: 50,decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),),
                        title:  Container(height: 10,width: 90,color: Colors.white,),
                        subtitle:  Container(height: 10,width: 90,color: Colors.white,),
                      ),
                    );
                  })
            );
          }
        }else{
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: InkWell(onTap: (){Get.back();},child: const Icon(Icons.arrow_back_ios)),
              title: __.isSearching
              ? TextFormField(
                controller: __.searchController, // Use the search controller here
                onChanged: (value) {
                  __.filterCountryList(value); // Call the filter method on controller
                },
                decoration: InputDecoration(
                    contentPadding:const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                  suffixIcon: InkWell(onTap: (){
                    __.isSearching=false;
                    __.searchController.clear();
                    __.update();
                  },child:const Icon(Icons.close)),
                ),
                
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Country Detail'),
                  InkWell(onTap: (){
                    __.isSearching = true;
                    __.update();
                  },child: const Icon(Icons.search_outlined),),
                ],
              ),
            ),
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width * .02),
              child: ListView.builder(
                  itemCount: __.searchController.text.isEmpty
                      ? __.countryList.length
                      : __.filteredCountryList.length,
                  itemBuilder: (context, index){
                    final country = __.searchController.text.isEmpty
                        ? __.countryList[index]
                        : __.filteredCountryList[index];
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(CountryDetailScreen(
                              namee: country.country.toString(),
                              image: country.countryInfo!.flag.toString(),
                              actve: country.active!.toInt(),
                              critical: country.critical!.toInt(),
                              test: country.tests!.toInt(),
                              todayRecovered: country.todayRecovered!.toInt(),
                              totalRecovered: country.recovered!.toInt(),
                              totoalCases: country.cases!.toInt(),
                              tottalDeath: country.deaths!.toInt()
                          ),transition: Transition.rightToLeftWithFade);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(country.countryInfo!.flag.toString()),
                        ),
                        title: Text(country.country.toString()),
                        subtitle: Text(country.cases.toString()),
                      ),
                    );
                  }),
            ),
          );
        }
      },
    );
  }
}

