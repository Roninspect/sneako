import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/constants/tab_widgets.dart';
import 'package:sneako/src/features/root/provider/nav_controller.dart';
import 'package:sneako/src/features/home/widgets/bottomnavbar.dart';

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navIndexProvider);
    return Scaffold(
      body: TabWidgets.tabs[index],
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
