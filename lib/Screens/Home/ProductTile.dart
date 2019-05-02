import 'package:AboutYouDemo/Helpers/Converters.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:AboutYouDemo/Screens/Home/TransparentImage.dart';
import 'package:AboutYouDemo/Styles/Dimensions.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({@required this.product});

  @override
  Widget build(BuildContext context) {
    final TextTheme baseTextTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;
    final double itemWidth = screenSize.width * 0.4;
    final double itemHeight = screenSize.width * 0.6;
    final int labelLength = product.attributes.name.label.length;

    return Container(
        width: itemWidth,
        height: itemHeight,
        //TODO: Add better way of handling varying text lengths to show fuller text / no image clipping
        child: GridTile(
            footer: Column(children: <Widget>[
              Text(
                '${product.attributes.name.label.substring(0, labelLength > 20 ? 20 : labelLength)} - ${product.attributes.brand.label}',
                style: baseTextTheme.subtitle,
                textAlign: TextAlign.center
              ),
              Text(
                  Converters.currencyToStringLocalization(
                      product.priceRange.priceMin.currencyCode,
                      product.priceRange.priceMin.price),
                  style: baseTextTheme.subtitle,
                  textAlign: TextAlign.center)
            ]),
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: Dimensions.stylePaddingXL),
                child: FadeInImage.memoryNetwork(
                    placeholder: TransparentImage.kTransparentImage,
                    //TODO: Strip out hard-coded bits to a central config
                    image: 'https://cdn.aboutstatic.com/file/' +
                        '${product.images.first.hash}' +
                        '?width=400&amp;' +
                        'height=400&amp;' +
                        'quality=75&amp;' +
                        'bg=ffffff00&amp;' +
                        'brightness=0.96&amp;' +
                        'trim=1'))));
  }
}
