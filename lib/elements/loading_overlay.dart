import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'loader.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      
          overlayWidget: const Center(
            child: Loader(
              color: Colors.white,
            ),
          ),
      child: child,
    );
  }
}