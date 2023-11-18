import 'dart:async';
import 'package:covid22222222222222222/UI/WorldStateScreen/WorldStateScreen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
     Get.to(WorldStateScreen());
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          AnimatedBuilder(
              animation: _controller,
              child:  SizedBox(
                height: Get.height * .30,
                child: const Image(image: AssetImage('images/logo.png')),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                  angle: _controller.value *2.0 * math.pi,
                  child: child,
                );
              }),
          SizedBox(height: MediaQuery.of(context).size.height *.08,),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Coveid-19\nTracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
          )
        ],
      ),
    );
  }
}
