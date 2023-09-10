
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String? url;
  double height;
  double width;
  BoxFit fit;
  bool isBanner;
  ImageView({this.url,this.width = 0.0, this.height = 0.0, this.fit = BoxFit.scaleDown, this.isBanner = false});


  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder:  AssetImage((!isBanner)? 'lib/assets/images/placeholder.png': 'lib/assets/images/bannerPlaceholder.png', ),
        image: NetworkImage(url ?? ''),
        imageErrorBuilder:(context, error, stackTrace) {
          return Image.asset((!isBanner)? 'lib/assets/images/placeholder.png': 'lib/assets/images/bannerPlaceholder.png',
              width: width != 0.0 ?  width : null,
              height:  height != 0.0 ?  height : null);
        },
        fit: fit,
        width:  width != 0.0 ?  width : null,height: height != 0.0 ?  height : null
    );
  }
}