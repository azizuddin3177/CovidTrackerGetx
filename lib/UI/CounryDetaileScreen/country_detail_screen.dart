import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CountryDetailScreen extends StatelessWidget {

  final String image,namee;
  final int totoalCases, tottalDeath, totalRecovered, actve, critical, todayRecovered, test;

   const CountryDetailScreen({
    required this.namee,
    required this.image,
    required this.actve,
    required this.critical,
    required this.test,
    required this.todayRecovered,
    required this.totalRecovered,
    required this.totoalCases,
    required this.tottalDeath,
     Key? key
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(namee),
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: (){Get.back();},child: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  image
              ),
            ),
            Stack(
              children: [
                Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      MyCard(title: 'Cases', naame: totoalCases.toString()),
                      MyCard(title: 'Recovered', naame: todayRecovered.toString()),
                      MyCard(title: 'Death', naame: tottalDeath.toString()),
                      MyCard(title: 'Critical', naame: critical.toString()),
                      MyCard(title: 'Active', naame: actve.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title,naame;
   const MyCard({
    required this.title,
    required this.naame,
     Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Text(title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          Text(naame),
        ],
      ),
    );
  }
}

