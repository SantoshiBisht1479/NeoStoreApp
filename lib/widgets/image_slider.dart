import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageList = [
    'assets/images/slider_img1.jpg',
    'assets/images/slider_img2.jpg',
    'assets/images/slider_img3.jpg',
    'assets/images/slider_img4.jpg'
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return Container(
                //height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageList[index]),
                        fit: BoxFit.cover)),
              );
            },
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                autoPlayAnimationDuration: Duration(milliseconds: 300))),
        Positioned(
          bottom: 5,
          left: 20.0.h,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.map((url) {
                int index = imageList.indexOf(url);
                return Container(
                  width: 13.0,
                  height: 13.0,
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Color.fromRGBO(0, 0, 0, 0.4)
                        : Theme.of(context).primaryColor,
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}
