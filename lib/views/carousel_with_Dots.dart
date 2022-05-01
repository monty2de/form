import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:form/Controllers/NewsController.dart';
import 'package:form/main.dart';
import 'package:form/models/news.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<News> news;

  const CarouselWithIndicator({Key? key, required this.news}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: widget.news
              .map((n) => SizedBox(
                    width: double.infinity,
                    child: NewsWidget(news: n, role: 5, onNewsDelete: () {}),
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              height: 300,
              enlargeCenterPage: true,
              // aspectRatio: 2,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.news.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
