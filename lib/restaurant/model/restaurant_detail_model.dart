import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/common/utils/data_utils.dart';
import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

// "detail": "오늘 주문하면 배송비 3000원 할인!",
//   "products": [
//     {
//       "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
//       "name": "마라맛 코팩 떡볶이",
//       "imgUrl": "/img/img.png",
//       "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
//       "price": 8000
//     }
//   ]
part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> product;
  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.product,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$RestaurantDetailModelFromJson(json);
  }
}

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);
}
