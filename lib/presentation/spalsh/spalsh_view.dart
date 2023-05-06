import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flu_proj/data/data_source/local_data_source.dart';
import 'package:flu_proj/presentation/resourses/assets_manager.dart';
import 'package:flu_proj/presentation/resourses/color_manager.dart';
import 'package:flu_proj/presentation/resourses/constant_manager.dart';
import 'package:flu_proj/presentation/resourses/strings_manager.dart';
import 'package:flu_proj/presentation/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resourses/router_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

final colorizeColors = [
  ColorManager.lightPrimary,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: AppSize.s20 * 1.5,
  fontFamily: 'Horizon',
);

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  _startDelay() {
    _timer =
        Timer(const Duration(milliseconds: AppConstants.SplashDelay), _goNext);
  }

  _goNext() async {
    //Navigator.pushReplacementNamed(context, Routes.mainRoute);
    await _appPreferences.isLoggedIn().then((isUserLoggedIn) async {
      //isUserLoggedIn=false;
      if (isUserLoggedIn) {
        //TODO call get data

        print(FirebaseAuth.instance.currentUser!.emailVerified);
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          _localDataSource
              .saveUserToCache()
              .then((_) =>
                  {Navigator.pushReplacementNamed(context, Routes.mainRoute)})
              .catchError((errot) {
            print(errot);
          });
        } else {
          print("not verified");
          Navigator.pushReplacementNamed(context, Routes.verificationRoute);
        }
      } else {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkPrimary,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset(ImageAssets.splashLogo),
            Container(
              color: const Color(0xff1ABA25),
              height: AppSize.s4,
            ),
            AnimatedTextKit(
              repeatForever: false,
              totalRepeatCount: 1,
              animatedTexts: [
                ColorizeAnimatedText(
                  AppStrings.swidanEncryptionHub.tr(),
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
