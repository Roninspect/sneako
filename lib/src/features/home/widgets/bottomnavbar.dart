import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/features/cart/widgets/cart_icon.dart';
import 'package:sneako/src/features/root/provider/nav_controller.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navIndexProvider);
    return BottomNavigationBar(
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.black26,
        showUnselectedLabels: true,
        currentIndex: navIndex,
        onTap: (value) => ref.read(navIndexProvider.notifier).state = value,
        // ref.read(navNotifierProvider.notifier).navStateChange(value),
        items: [
          BottomNavigationBarItem(
              icon: navIndex != 0
                  ? const Icon(Octicons.home)
                  : const Icon(Foundation.home),
              label: 'Home'),
          const BottomNavigationBarItem(
            icon: CartIcon(),
            label: "Cart",
          ),
          BottomNavigationBarItem(
              icon: navIndex != 2
                  ? const Icon(Ionicons.receipt_outline)
                  : const Icon(Ionicons.receipt),
              label: 'Orders'),
          BottomNavigationBarItem(
              icon: navIndex != 4
                  ? const Icon(Ionicons.person_outline)
                  : const Icon(Ionicons.ios_person),
              label: 'Profile'),
        ]);
  }
}
