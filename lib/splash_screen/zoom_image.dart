import 'package:flutter/material.dart';

import '../utils/size_utils.dart';

class ZoomImage extends StatefulWidget {
  final String imagePath;

  const ZoomImage({super.key, required this.imagePath});

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // zoom in & out loop

    _scale = Tween<double>(begin: 0.9, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Image.asset(widget.imagePath,
          height: SizeUtils.horizontalBlockSize * 35,
          width: SizeUtils.horizontalBlockSize * 35
          // fit: BoxFit.cover,
          ),
    );
  }
}
