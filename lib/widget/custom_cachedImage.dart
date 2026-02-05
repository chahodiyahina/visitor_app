import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_text.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color? colorFilter;
  final BlendMode blendMode;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.colorFilter,
    this.blendMode = BlendMode.colorBurn,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
                image: imageProvider,
                fit: fit,
                colorFilter: colorFilter != null
                    ? ColorFilter.mode(colorFilter!, blendMode)
                    : null),
          ),
        );
      },
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey.shade200, borderRadius: borderRadius),
        child: const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.black11A,),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey.shade300, borderRadius: borderRadius),
        child: const Icon(Icons.person_outline, size: 36  , color: Colors.grey),
        // child: const CustomText(title: "image not found")

        // Image.asset(AppImage.profile),
      ),
    );
  }
}
