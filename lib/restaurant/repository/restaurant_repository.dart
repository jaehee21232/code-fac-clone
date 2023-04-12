import 'package:code_fac/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part "restaurant_repository.g.dart";

@RestApi()
abstract class RestaurantRepository {
  //http//$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // @GET("/")
  // paginate();

  //http//$ip/restaurant/:id

  @GET("/{id}") //레트로핏에서 변수 넣으려면 {변수}
  @Headers({
    "accessToken": "true",
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
