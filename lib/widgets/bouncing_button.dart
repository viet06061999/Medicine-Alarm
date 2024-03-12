import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  final Widget child;
  final bool enable;

  const BouncingButton({Key? key, required this.child, required this.enable})
      : super(key: key);

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 1.0, // Giới hạn giá trị animation từ 0.0 đến 1.0
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.enable) {
      _animationController.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.enable) {
      _animationController.reverse().then((value){
        _animationController.stop();
      });
    } else{
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant BouncingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.enable) {
      _animationController.reverse().then((value){
        _animationController.stop();
      });
    } else{
      _animationController.forward();
    }
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0.0, -15.0 * _animation.value),
          // Áp dụng giá trị animation vào offset
          child: widget.child,
        );
      },
    );
  }
}
