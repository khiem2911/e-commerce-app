import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:flutter/material.dart';

class BottomAlert extends StatelessWidget {
  const BottomAlert({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    print(title);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        width: double.infinity,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/success_icon.png'),
              width: 80,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 48,
            ),
            BoxButton(
                title: 'Done',
                onTap: () {
                  if (title == 'Signup sucessful!') {
                    Navigator.pushNamedAndRemoveUntil(context, locationRoute,
                        (Route<dynamic> route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, tabsBottomRoute,
                        (Route<dynamic> route) => false);
                  }
                })
          ],
        ),
      ),
    );
  }
}
