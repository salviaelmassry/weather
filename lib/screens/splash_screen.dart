import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/resources/app_color.dart';
import 'package:weather/screens/home_page.dart';
import 'package:weather/shared/components/text_display.dart';
import 'package:weather/utilities/navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _getCurrentLocation() async {
    final Location? location;

    location = Location();

    try {
      await location.requestPermission();
      final LocationData _locationResult = await location.getLocation();
      popALlAndPushPage(
          context,
          HomePage(
              coord: Coord(
                  lat: _locationResult.latitude,
                  lon: _locationResult.longitude))
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Center(
              child: AppTextDisplay(
            text: 'Splash Screen',
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppColors.facebookColor,
          )),
        ],
      ),
    );
  }
}
