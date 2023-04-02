import 'package:code_fac/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RestaurantCard(
            imgae: Image.asset(
              "asset/img/food/ddeok_bok_gi.jpg",
              fit: BoxFit.cover,
            ),
            name: "떡볶이",
            tags: ["떡볶이", "치즈", "매운맛"],
            ratingCount: 100,
            delivertTime: 15,
            delivertFee: 2000,
            ratings: 4.52),
      ),
    );
  }
}
