import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/components/cards/big_cards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportivo/controllers/place_controller.dart';

class Carousel extends StatefulWidget {
  final String carouselName;

  const Carousel({Key? key, required this.carouselName}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceController>(context);
    final carouselData =
        widget.carouselName == 'Sugestões' ? provider.suggestions : provider.favorites;
    return Container(
      height: 200.h,
      child: CarouselSlider(
        items: carouselData.map((place) {
          return BigCards(
            placeItem: place,
          );
        }).toList(),
        options: CarouselOptions(
            height: 150.h,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayInterval: Duration(seconds: 5),
            viewportFraction: 0.8),
      ),
    );
  }
}
