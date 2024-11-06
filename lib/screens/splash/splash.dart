import 'dart:async';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool checked = shared.getBool('isLoggedIn') ?? false;
    String screen = checked ? tabsBottomRoute : onBoardingRoute;

    if (checked && FirebaseAuth.instance.currentUser != null) {
      await getUser(context);
      await getItems(context);

      _timer = Timer(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, screen, (Route<dynamic> route) => false));
    } else {
      _timer = Timer(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, loginRoute, (Route<dynamic> route) => false));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary700,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: 66,
                height: 66,
                child: const Image(
                  image: AssetImage(
                    'assets/images/splash_icon.png',
                  ),
                  color: Colors.white,
                )),
            const SizedBox(
              width: 21,
            ),
            Text(
              'ShopPdk',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 40, color: neutral50, fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
