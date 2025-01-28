import 'dart:math';
import 'package:flutter/material.dart';

class GiftDropAnimation extends StatefulWidget {
  final Widget child;

  const GiftDropAnimation({Key? key, required this.child}) : super(key: key);

  @override
  _GiftDropAnimationState createState() => _GiftDropAnimationState();
}

class _GiftDropAnimationState extends State<GiftDropAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  List<Gift> gifts = [];
  final int giftCount = 30; // Increased number of gifts
  final double maxGiftSize = 40.0;
  final double minGiftSize = 20.0;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      giftCount,
      (index) => AnimationController(
        duration: Duration(milliseconds: 1500 + Random().nextInt(1000)),
        vsync: this,
      ),
    );

    for (int i = 0; i < giftCount; i++) {
      gifts.add(Gift(_controllers[i], maxGiftSize, minGiftSize));
      Future.delayed(Duration(milliseconds: Random().nextInt(1500)), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ...gifts
            .map((gift) => AnimatedBuilder(
                  animation: gift.controller,
                  builder: (context, child) {
                    return Positioned(
                      left: gift.x.value,
                      top: gift.y.value,
                      child: Transform.rotate(
                        angle: gift.rotation.value,
                        child: Opacity(
                          opacity: gift.opacity.value,
                          child: Icon(
                            gift.icon,
                            size: gift.size,
                            color: gift.color,
                          ),
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ],
    );
  }
}

class Gift {
  late Animation<double> x;
  late Animation<double> y;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late IconData icon;
  late double size;
  late Color color;
  late AnimationController controller;

  Gift(this.controller, double maxSize, double minSize) {
    final random = Random();
    final screenWidth = 400.0; // Approximate screen width
    final screenHeight = 800.0; // Approximate screen height

    x = Tween<double>(
      begin: random.nextDouble() * screenWidth,
      end: random.nextDouble() * screenWidth,
    ).animate(controller);

    y = Tween<double>(
      begin: -50.0,
      end: screenHeight + 50.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    rotation = Tween<double>(
      begin: 0,
      end: random.nextDouble() * 2 * pi,
    ).animate(controller);

    opacity = Tween<double>(
      begin: 0.8,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    size = minSize + random.nextDouble() * (maxSize - minSize);
    icon = _getRandomGiftIcon();
    color = _getRandomColor();
  }

  IconData _getRandomGiftIcon() {
    final icons = [
      Icons.card_giftcard,
      Icons.celebration,
      Icons.star,
      Icons.favorite,
      Icons.cake,
    ];
    return icons[Random().nextInt(icons.length)];
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];
    return colors[Random().nextInt(colors.length)];
  }
}
