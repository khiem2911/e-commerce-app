import 'package:ecommerce_app/screens/auth/auth.dart';
import 'package:ecommerce_app/screens/login/components/box_border.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 70, top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login to ShopPDK',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: neutral950),
          ),
          const SizedBox(
            height: 48,
          ),
          const BoxBorderItem(
              title: 'Login With Google',
              icon: 'assets/images/google_icon.png'),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 148,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: neutral300)),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Or',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral600),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 148,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: neutral300)),
              ),
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Consumer<AuthState>(builder: (context, auth, child) {
            return BoxButton(
                title: auth.auth ? 'Signup With Email' : 'Login With Email',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Auth(currentAuth: auth.auth))));
          }),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Dont have any account yet?',
                style: TextStyle(color: neutral800),
              ),
              Consumer<AuthState>(builder: (context, auth, child) {
                return InkWell(
                  onTap: () {
                    auth.changeAuth();
                  },
                  child: Text(
                    auth.auth ? 'Login' : 'Signup',
                    style: const TextStyle(
                        color: primary700,
                        decoration: TextDecoration.underline,
                        decorationColor: primary700),
                  ),
                );
              })
            ],
          )
        ],
      ),
    ));
  }
}
