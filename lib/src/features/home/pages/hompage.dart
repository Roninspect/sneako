import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/home/repository/home_repository.dart';
import 'package:sneako/src/features/home/widgets/brand_listview.dart';
import 'package:sneako/src/features/home/widgets/custom_search_bar.dart';
import 'package:sneako/src/features/home/widgets/offer_card.dart';
import 'package:sneako/src/features/home/widgets/productById_listview.dart';
import 'package:sneako/src/features/home/widgets/select_brand_listview.dart';
import 'package:sneako/src/features/home/widgets/title_sell_row.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataNotifierProvider);

    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    String greetingText;

    if (currentHour >= 4 && currentHour < 12) {
      greetingText = 'Good Morning';
    } else if (currentHour >= 13 && currentHour < 19) {
      greetingText = 'Good Evening';
    } else {
      greetingText = 'Good Night';
    }
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: user.profile != null || user.profile != ""
                ? CircleAvatar(
                    minRadius: 30,
                    backgroundImage: CachedNetworkImageProvider(user.profile!,
                        cacheKey: user.id),
                  )
                : Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                  )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetingText,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              user.username,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.ios_notifications_outline,
                size: 26,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.heart_outline,
                size: 27,
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const CustomSearchBar(),
              const SizedBox(height: 10),
              TitleSeeMoreRow(
                title: 'Special Offers',
                seemoreTapped: () {},
              ),
              const SizedBox(height: 10),
              AsyncValueWidget(
                  value: ref.watch(recentofferProvider),
                  data: (offer) {
                    return OfferCard(offerData: offer);
                  }),
              const SizedBox(height: 20),
              const BrandListView(),
              const SizedBox(height: 10),
              TitleSeeMoreRow(
                title: 'Most Popular',
                seemoreTapped: () {},
              ),
              const SelectbrandListView(),
              const ProductByIdListView()
            ],
          ),
        ),
      ),
    );
  }
}
