// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/home/repository/home_repository.dart';
import 'package:sneako/src/models/offer.dart';

class OfferCard extends ConsumerWidget {
  final Offer offerData;
  const OfferCard({
    super.key,
    required this.offerData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: offerData.pagePath != null
          ? () {
              print('pagePath is provded');
            }
          : offerData.productId != null
              ? () {
                  print('productId is provided');
                }
              : () {
                  print('nothing is provided');
                },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(0.0, 5.0),
                blurRadius: 5.0,
                spreadRadius: -3.0,
                color: Color(int.parse(offerData.colorCode)),
              ),
            ],
            color: Color(int.parse(offerData.colorCode)),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(offerData.title,
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  Text(offerData.extraText,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 08),
                  if (offerData.moreText != null)
                    SizedBox(
                      width: 200,
                      child: Text(offerData.moreText!,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(width: 10),
            CachedNetworkImage(
              cacheKey: offerData.id.toString(),
              imageUrl: offerData.background,
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}
