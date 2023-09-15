import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CachedImage extends StatelessWidget {
  String? imageUrl;
  CachedImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl!,
      errorWidget: (context, url, error) => Container(
        color: Colors.red[100],
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Padding(
          padding: EdgeInsets.all(130.0.h),
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
