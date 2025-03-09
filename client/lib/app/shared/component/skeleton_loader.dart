import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/core/controller/theme_controller.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonLoader({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    var isDarkMode = DependencyProvider.get<ThemeController>().isDarkMode(
      context,
    );
    var baseColor = Colors.grey.shade300;
    var highlightColor = Colors.white;

    if (isDarkMode) {
      baseColor = Colors.grey.shade800;
      highlightColor = Colors.grey.shade600;
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
