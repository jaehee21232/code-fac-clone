enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.item(item) {
    return RestaurantModel(
        id: item["id"],
        name: item["name"],
        thumbUrl: item["thumbUrl"],
        tags: List<String>.from(item["tags"]),
        priceRange: RestaurantPriceRange.values
            .firstWhere((element) => element.name == item["priceRange"]),
        ratings: item["ratings"],
        ratingsCount: item["ratingsCount"],
        deliveryTime: item["deliveryTime"],
        deliveryFee: item["deliveryFee"]);
  }
}
