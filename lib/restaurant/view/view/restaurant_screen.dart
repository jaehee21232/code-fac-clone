import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/restaurant/component/restaurant_card.dart';
import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:code_fac/restaurant/view/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      "http://$ip/restaurant",
      options: Options(
        headers: {"authorization": "Bearer $accessToken"},
      ),
    );
    return resp.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                final pItem = RestaurantModel.fromjson(json: item);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RestaurantDetailScreen(
                        id: pItem.id,
                      ),
                    ));
                  },
                  child: RestaurantCard.fromModel(
                    model: pItem,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.0,
                );
              },
            );
          },
        ));
  }
}
