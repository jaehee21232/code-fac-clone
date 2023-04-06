import 'package:code_fac/common/layout/deafult_layout.dart';
import 'package:code_fac/product/component/procduct_card.dart';
import 'package:code_fac/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProducts(),
        ],
      ),
      // Column(children: [
      //   RestaurantCard(
      //     image: Image.asset("asset/img/food/ddeok_bok_gi.jpg"),
      //     name: "불타는 떡볶이",
      //     tags: ["떡볶이", "맛있음", "치즈"],
      //     ratingCounts: 100,
      //     delivertTime: 30,
      //     delivertFee: 3000,
      //     ratings: 5.34,
      //     isDetail: true,
      //     detail: "맛있는 떡볶이",
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //     child: ProductCard(),
      //   )
      // ]),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          "메뉴",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset("asset/img/food/ddeok_bok_gi.jpg"),
        name: "불타는 떡볶이",
        tags: ["떡볶이", "맛있음", "치즈"],
        ratingCounts: 100,
        delivertTime: 30,
        delivertFee: 3000,
        ratings: 5.34,
        isDetail: true,
        detail: "맛있는 떡볶이",
      ),
    );
  }
}
