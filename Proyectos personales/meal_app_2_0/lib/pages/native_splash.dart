import 'package:flutter/material.dart';

class NativeSplash extends StatefulWidget {
  @override
  State<NativeSplash> createState() => _NativeSplashState();
}

class _NativeSplashState extends State<NativeSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 888),
        () => Navigator.pushReplacementNamed(context, 'splash'));
  }

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xFFFFFFFF) : const Color(0xff042a49),
      body: Center(
          child: lightMode
              ? Image.asset('assets/img/food.jpg')
              : Image.asset('assets/img/food.jpg')),
    );
  }
}
