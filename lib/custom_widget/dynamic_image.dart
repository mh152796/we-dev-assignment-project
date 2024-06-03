import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DynamicNetworkImage extends StatelessWidget {
  const DynamicNetworkImage({
    super.key,
    this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.defaultImage,
  });

  final String? imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? defaultImage;

  @override
  Widget build(BuildContext context) {
    print("imsge ${imageUrl}");
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl.toString(),
      fit: fit ?? BoxFit.fill,
      placeholder: (context, url) => const Center(child: SizedBox.shrink()),
      errorWidget: (context, url, error) => CachedNetworkImage(
          imageUrl: "https://secure.gravatar.com/avatar/0f18386fb9f252d7d1c56f6317dade7b?s=96&d=mm&r=g",
          height: height,
          width: width,
          fit: fit ?? BoxFit.fill),
    );
  }
}
