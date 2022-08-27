import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage fetchImage(
    String imageUrl, double? imageHeight, double? imageWidth, bool hasRadius) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
        height: imageHeight ?? 80,
        width: imageWidth ?? 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(hasRadius ? 50 : 0),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        )),
    placeholder: (context, url) => const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.0,
      ),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
