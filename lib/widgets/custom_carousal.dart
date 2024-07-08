import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/tv_series_model.dart';

class CustomCarousalSlider extends StatelessWidget {
  final TvSeriesModel data;
  const CustomCarousalSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: (screenSize.height * 0.33 < 300) ? 300 : screenSize.height * 0.33,
      width: screenSize.width, // 80% of screen width
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index, realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(imageUrl: "$imageUrl$url"),
                Text(
                  data.results[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                )
              ],
            ));
          },
          options: CarouselOptions(
              height: (screenSize.height * 0.33 < 300)
                  ? 300
                  : screenSize.height * 0.33,
              aspectRatio: 16 / 9,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              initialPage: 0)),
    );
  }
}
