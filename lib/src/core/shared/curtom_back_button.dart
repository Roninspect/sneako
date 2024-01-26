import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends ConsumerWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(width: 2.5),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(0.5, 1))
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.only(right: 2.0),
            child: Icon(
              AntDesign.left,
              size: 25,
            ),
          ),
        ));
  }
}
