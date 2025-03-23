import 'package:flutter/material.dart';

class DefaultBodyComponent extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final List<Widget> children;
  final ScrollController? scrollController;
  final MainAxisSize? mainAxisSize;
  final EdgeInsetsGeometry? padding;
  const DefaultBodyComponent({
    required this.children,
    this.padding,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.scrollController,
    this.mainAxisSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: padding ?? const EdgeInsets.all(32),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            mainAxisSize: mainAxisSize ?? MainAxisSize.max,
            spacing: 16,
            children: children,
          ),
        ),
      ),
    );
  }
}
