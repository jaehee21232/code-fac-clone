import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/common/dio/dio.dart';
import 'package:code_fac/common/layout/deafult_layout.dart';
import 'package:code_fac/product/component/procduct_card.dart';
import 'package:code_fac/restaurant/component/restaurant_card.dart';
import 'package:code_fac/restaurant/model/restaurant_detail_model.dart';
import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:code_fac/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });
  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor(storage: storage));
    final repository =
        RestaurantRepository(dio, baseUrl: "http://$ip/restaurant");

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: FutureBuilder<RestaurantDetailModel>(
          future: getRestaurantDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: [
                renderTop(model: snapshot.data!),
                renderLabel(),
                renderProducts(products: snapshot.data!.products),
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
