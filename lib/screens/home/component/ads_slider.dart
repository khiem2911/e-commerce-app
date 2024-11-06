import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdsSlider extends StatefulWidget {
  const AdsSlider({super.key});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  final List _adsItem = ['assets/images/ads1.jpg', 'assets/images/ads2.png'];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _adsItem.map((item) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      width: double.infinity,
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              });
            }).toList(),
            options: CarouselOptions(
                height: 150,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                })),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _adsItem.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentIndex == entry.key ? primary700 : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
