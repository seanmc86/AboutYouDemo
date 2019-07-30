import 'dart:math';
import 'package:AboutYouDemo/Helpers/Converters.dart';
import 'package:AboutYouDemo/Helpers/ImageConfig.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:AboutYouDemo/Screens/Home/TransparentImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'package:AboutYouDemo/Screens/Home/CarouselWidget/Indicator.dart';

class _CarouselLayoutDelegate extends MultiChildLayoutDelegate {
  _CarouselLayoutDelegate({
    @required this.page,
    @required this.itemCount,
  });

  final double page;
  final int itemCount;

  final double _z = 1.30;

  @override
  void performLayout(Size size) {
    final double offset = (page % itemCount) / itemCount;
    final Offset center = Offset(size.width / 2, size.height / 4);

    for (int i = 0; i < itemCount; i++) {
      final String childId = 'item$i';
      final double alpha = (i + offset * itemCount) * (2 * pi / itemCount);

      final double x = (1 - sin(alpha)) / 2;
      final double z = _z - (1 - cos(alpha)) / 2;

      if (hasChild(childId)) {
        final Size imageSize =
            layoutChild(childId, BoxConstraints.tight((size / 4) * z));

        positionChild(childId,
            Offset(size.width * x - (size.width / 8 * z), size.height / 6));
      }
    }
  }

  @override
  bool shouldRelayout(_CarouselLayoutDelegate oldDelegate) =>
      page != oldDelegate.page || itemCount != oldDelegate.itemCount;
}

class Carousel extends StatefulWidget {
  const Carousel({
    Key key,
    @required this.products
  })  : assert(products.length > 0),
        super(key: key);

  final List<Product> products;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController(keepPage: false);
  static const Duration _kDuration = Duration(milliseconds: 300);
  static const Cubic _kCurve = Curves.ease;

  double _page = 0.0;
  int _pageIndex = 0;

  int get itemCount => widget.products.length;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imagesWithId = <Widget>[];
    final List<Widget> renderLast = <Widget>[];
    // Paint order is determined by order of layout ids
    for (int i = 0; i < itemCount; i++) {
      final double offset = (_page % itemCount) / itemCount;
      final double alpha = (i + offset * itemCount) * (2 * pi / itemCount);
      // If in foreground, render last
      if (alpha % (2 * pi) < pi / 2 || alpha % (2 * pi) > 3 * pi / 2) {
        renderLast.add(LayoutId(
          id: 'item$i',
          child: Opacity(opacity: _pageIndex == i ? 1.0 : 0.4,child: FadeInImage.memoryNetwork(
                    placeholder: TransparentImage.kTransparentImage,
                    image: ImageConfig.mainTileImage(widget.products[i].images.first.hash))),
        ));
        continue;
      }
      imagesWithId.add(LayoutId(
        id: 'item$i',
        child: FadeInImage.memoryNetwork(
                    placeholder: TransparentImage.kTransparentImage,
                    image: ImageConfig.mainTileImage(widget.products[i].images.first.hash)),
      ));
    }
    imagesWithId.addAll(renderLast);
    return Stack(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollUpdateNotification) {
              final PageMetrics metrics = notification.metrics;
              if (metrics.page >= 0) {
                setState(() {
                  _page = metrics.page;
                  _pageIndex =
                      (itemCount - (_page % itemCount).round()) % itemCount;
                });
              }
            }
            return false;
          },
          child: Scrollable(
            dragStartBehavior: DragStartBehavior.start,
            axisDirection: AxisDirection.right,
            controller: _pageController,
            physics: const PageScrollPhysics(),
            viewportBuilder: (BuildContext context, ViewportOffset position) {
              return Viewport(
                offset: position,
                axisDirection: AxisDirection.right,
                slivers: <Widget>[
                  SliverFixedExtentList(
                    itemExtent: MediaQuery.of(context).size.width,
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        color: Colors.transparent,
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
        CustomMultiChildLayout(
          children: imagesWithId,
          delegate: _CarouselLayoutDelegate(
            itemCount: itemCount,
            page: _page,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(widget.products[_pageIndex].attributes.name.label,
                    style: Theme.of(context).textTheme.headline),
                Text(
                  Converters.currencyToStringLocalization(
                      widget.products[_pageIndex].priceRange.priceMin.currencyCode,
                      widget.products[_pageIndex].priceRange.priceMin.price),
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DotsIndicator(
              controller: _pageController,
              itemCount: itemCount,
              color: CupertinoColors.inactiveGray,
              onPageSelected: (int page) {
                _pageController.animateToPage(
                  page,
                  duration: _kDuration,
                  curve: _kCurve,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
