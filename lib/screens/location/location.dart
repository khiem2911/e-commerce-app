import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationState();
  }
}

class _LocationState extends State<Location> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration:
                  const BoxDecoration(color: primary50, shape: BoxShape.circle),
              child: const Image(
                image: AssetImage('assets/images/location.png'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'What is Your Location?',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'We need to know your location in order to suggest nearby services.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: neutral800),
            ),
            const SizedBox(
              height: 48,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : BoxButton(
                    title: 'Allow Location Access',
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      getCurrentLocation(() {
                        setState(() {
                          isLoading = false;
                        });
                      }, context);
                    }),
            const SizedBox(
              height: 32,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, searchLocationRoute),
              child: Text(
                'Enter Location Manually',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: primary700),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
