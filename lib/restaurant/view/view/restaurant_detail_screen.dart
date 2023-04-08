import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/common/layout/deafult_layout.dart';
import 'package:code_fac/product/component/procduct_card.dart';
import 'package:code_fac/restaurant/component/restaurant_card.dart';
import 'package:code_fac/restaurant/model/restaurant_detail_model.dart';
import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });
  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      "http://$ip/restaurant/$id",
      options: Options(headers: {"authorization": "Bearer $accessToken"}),
    );

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final item = RestaurantDetailModel.fromJson(json: snapshot.data!);
            return CustomScrollView(
              slivers: [
                renderTop(model: item),
                renderLabel(),
                renderProducts(products: item.product),
              ],
            );
          },
        )
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

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.formModel(
                model: model,
              ),
            );
          },
          childCount: products.length,
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

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
