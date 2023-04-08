import 'package:code_fac/common/const/colors.dart';
import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/restaurant/model/restaurant_detail_model.dart';
import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingCounts;
  final int delivertTime;
  final int delivertFee;
  final double ratings;
  final bool isDetail;
  final String? detail;
  const RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingCounts,
      required this.delivertTime,
      required this.delivertFee,
      required this.ratings,
      this.isDetail = false,
      this.detail});
  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        "http://$ip${model.thumbUrl}",
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingCounts: model.ratingsCount,
      delivertTime: model.deliveryTime,
      delivertFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(" tasdasdasd");
    return Column(
      children: [
        if (isDetail) image,
        if (!isDetail)
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: image,
          ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                tags.join("·"),
                style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  _IconText(
                    icon: Icons.star,
                    label: ratings.toString(),
                  ),
                  renderDor(),
                  _IconText(
                    icon: Icons.receipt,
                    label: ratingCounts.toString(),
                  ),
                  renderDor(),
                  _IconText(
                    icon: Icons.timelapse_outlined,
                    label: "@$delivertTime",
                  ),
                  renderDor(),
                  _IconText(
                    icon: Icons.monetization_on,
                    label: "${delivertFee == 0 ? "무료" : "$delivertFee"}",
                  ),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(detail!),
                )
            ],
          ),
        )
      ],
    );
  }

  Widget renderDor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        "·",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconText({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.01,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
