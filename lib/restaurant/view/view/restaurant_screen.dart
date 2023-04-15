import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/common/dio/dio.dart';
import 'package:code_fac/restaurant/component/restaurant_card.dart';
import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:code_fac/restaurant/repository/restaurant_repository.dart';
import 'package:code_fac/restaurant/view/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );
    final resp =
        await RestaurantRepository(dio, baseUrl: "http://$ip/restaurant")
            .paginate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
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
                final pItem = snapshot.data![index];
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
