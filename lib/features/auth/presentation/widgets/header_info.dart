// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:jhon_rhay_parreno_technical_assessment/core/theme/app_pallete.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });

  final String title;
  final String subTitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.25,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: AppPallete.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                subTitle,
                style: textTheme.labelSmall?.copyWith(
                  color: AppPallete.primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
