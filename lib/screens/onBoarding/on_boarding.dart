import 'package:ecommerce_app/screens/login/login.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class Onboading extends StatelessWidget {
  const Onboading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 360,
            child: const Image(
              image: AssetImage('assets/images/boarding.png'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Text(
                'Welcome to ShopPDK',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Your one-stop destination for hassle-free online shopping',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: neutral800, fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          BoxButton(
              title: 'Get Started',
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login())))
        ],
      ),
    ));
  }
}
