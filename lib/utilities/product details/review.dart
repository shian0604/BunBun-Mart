import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/product%20details/stars.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';

class BunReview extends StatefulWidget {
  const BunReview({super.key});

  @override
  State<BunReview> createState() => _BunReviewState();
}

class _BunReviewState extends State<BunReview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BTextBold(text: "J***** T*****", color: BunColors.black),
            BunbunText(
              text: "01/01/2025",
              color: BunColors.black.withOpacity(0.5),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        BunStars(),
        SizedBox(height: 10.0),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BunBunImage(
              imageheight: 64,
              imagewidth: 64,
              imagepath: "assets/products/product1.jpg",
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: BunDetailsText(
                text:
                    "Been waiting to try this eversince I saw this sa Tiktok!, will repurchase again :)",
                color: BunColors.black,
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircularIcons(
              imagepath: "assets/icons/like.png",
              imageheight: 16,
              imagewidth: 16,
              padding: EdgeInsets.all(0),
            ),
            BTextBold(text: "Helpful (1)", color: BunColors.navy),
          ],
        ),

        SizedBox(height: 5.0,),
      ],
    );
  }
}
