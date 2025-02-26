import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopPromoSlider extends StatelessWidget {
  const TopPromoSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of image assets to display
    final List<String> imageList = [
      "assets/images/promotion__one.png",
      // Uncomment these when you have the assets ready
      // "assets/images/promotion_two.png",
      // "assets/images/promotion_three.png",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: imageList.length,
              options: CarouselOptions(
                height: 150,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imageList[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
