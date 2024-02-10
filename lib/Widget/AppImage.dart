import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColor.dart';
import 'GeneralWidget.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ColorFilter? colorFilter;
  final BorderRadiusGeometry? borderRadius;

  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: ColorFiltered(
        colorFilter: colorFilter ??
            ColorFilter.mode(AppColor.opacityColor, BlendMode.darken),
        child: FadeInImage(
          height: height ?? 190.h,
          width: width ?? double.infinity,
          image: AssetImage(image),
          placeholderFit: BoxFit.cover,
          placeholder: GeneralWidget.placeholderImage(),
          imageErrorBuilder: (context, error, stackTrace) =>
              GeneralWidget.imageError(),
          fit: fit ?? BoxFit.contain,
        ),
      ),
    );
  }

  backgroundImage() {
    return FadeInImage(
      height: height ?? 190.h,
      width: width ?? double.infinity,
      image: AssetImage(image),
      placeholderFit: BoxFit.cover,
      placeholder: GeneralWidget.placeholderImage(),
      imageErrorBuilder: (context, error, stackTrace) =>
          GeneralWidget.imageError(),
      fit: BoxFit.contain,
    ).image;
  }

  netWorkImage() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
                colorFilter: colorFilter ??
                    ColorFilter.mode(AppColor.opacityColor, BlendMode.darken)),
          ),
        ),
        placeholder: (context, url) => GeneralWidget.placeholderCashNetwork(),
        errorWidget: GeneralWidget.placeholderCashNetwork(),
      ),
    );
  }
}

class AppCashImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxFit? placeHolderFit;
  final ColorFilter? colorFilter;
  final BorderRadiusGeometry? borderRadius;

  const AppCashImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.colorFilter, this.placeHolderFit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(5.r)),
      child: ColorFiltered(
        colorFilter: colorFilter ??
            ColorFilter.mode(AppColor.opacityColor, BlendMode.darken),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => GeneralWidget.placeholderCashNetwork(fit: placeHolderFit),
          errorWidget: (c, d, dd) => GeneralWidget.placeholderCashNetwork(fit: placeHolderFit),
        ),
      ),
    );
  }
}
