import 'package:code_fac/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget imgae;
  final String name;
  final List<String> tags;
  final int ratingCount;
  final int delivertTime;
  final int delivertFee;
  final double ratings;
  const RestaurantCard({
    super.key,
    required this.imgae,
    required this.name,
    required this.tags,
    required this.ratingCount,
    required this.delivertTime,
    required this.delivertFee,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: imgae,
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
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
                  label: ratingCount.toString(),
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
            )
          ],
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
