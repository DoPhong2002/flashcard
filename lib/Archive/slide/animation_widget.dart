import 'dart:math';
import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child;

  final Duration duration;

  const FadeInWidget(
      {super.key, required this.child, this.duration = const Duration(milliseconds: 400)});

  @override
  State createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}

class RotateWidget extends StatefulWidget {
  final Widget child;
  final double angle;

  const RotateWidget({super.key, required this.child, required this.angle});

  @override
  State createState() => _RotateWidgetState();
}

class _RotateWidgetState extends State<RotateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _currentAngle;
  double? _previousAngle;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350))
      ..forward(from: 0);
    _currentAngle = widget.angle;
    super.initState();
  }

  @override
  void didUpdateWidget(RotateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.angle != widget.angle) {
      _previousAngle = _currentAngle;
      _currentAngle = widget.angle;
      _animation = Tween<double>(begin: _previousAngle, end: _currentAngle)
          .animate(_controller);
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_previousAngle == null) {
      return Transform.rotate(
        angle: _currentAngle,
        child: widget.child,
      );
    } else {
      return RotationTransition(
        turns: _animation,
        child: widget.child,
      );
    }
  }
}

class SlideWidget extends StatefulWidget {
  final Widget child;

  final Duration duration;

  final Offset offset;

  final Curve curve;

  const SlideWidget(
      {super.key, required this.child,
        this.curve = Curves.linear,
        this.duration = const Duration(milliseconds: 400),
        this.offset = const Offset(0.5, 0)});

  @override
  State createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: widget.offset, end: Offset.zero)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve)),
      child: widget.child,
    );
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;
  final int shakeCount;
  final bool autoPlay;
  final Duration? delay;

  static const countInfinite = -1;

  const ShakeWidget(
      {Key? key,
        required this.child,
        this.duration = const Duration(milliseconds: 50),
        this.offset = 10,
        this.shakeCount = 3,
        this.axis = Axis.horizontal,
        this.delay,
        this.autoPlay = false})
      : super(key: key);

  @override
  State createState() => _ShakeWidgetState();

  static shakeScreen(BuildContext context) {
    final state = context.findAncestorStateOfType<_ShakeWidgetState>();
    state?.shake();
  }
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  late double _offset;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        upperBound: 1,
        lowerBound: -1,
        value: 0,
        duration: widget.duration);

    _offset = widget.offset;

    _shakeAnimation = CurvedAnimation(parent: _controller, curve: ShakeCurve());

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.shakeCount == ShakeWidget.countInfinite) {
          _controller.reverse();
        } else {
          _offset -= widget.offset / widget.shakeCount;
          if (_offset > 0) {
            _controller.reverse();
          } else {
            _controller.animateTo(0);
          }
        }
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    if (widget.autoPlay) {
      if (widget.delay != null) {
        Future.delayed(widget.delay!, () {
          _controller.forward(from: 0);
        });
      } else {
        _controller.forward(from: 0);
      }
    }

    super.initState();
  }

  @override
  void didUpdateWidget(ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.duration = widget.duration;
    _offset = widget.offset;
    if (_controller.isAnimating) {
      _controller.forward(from: 0);
    }
  }

  void shake() {
    _offset = widget.offset;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        final newOffset = _controller.value * _offset;
        return Transform.translate(
          offset: widget.axis == Axis.horizontal
              ? Offset(newOffset, 0)
              : Offset(0, newOffset),
          child: Container(
            child: child,
          ),
        );
      },
      animation: _shakeAnimation,
      child: widget.child,
    );
  }
}

class BlinkingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const BlinkingWidget({Key? key, required this.child, required this.duration})
      : super(key: key);

  @override
  State createState() => _BlinkingWidgetState();
}

class _BlinkingWidgetState extends State<BlinkingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
    AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse(from: 1);
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward(from: 0);
        }
      })
      ..forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BouncingButton extends StatefulWidget {
  final Widget child;
  final Function? onTap;
  final double shrinkOffset;

  const BouncingButton(
      {Key? key, required this.onTap,required  this.child, this.shrinkOffset = 0.9})
      : super(key: key);

  @override
  State createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 70));
    _animation = Tween<double>(begin: 1, end: widget.shrinkOffset).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (details) {
          _controller.forward(from: 0);
        },
        onTapUp: (details) {
          _controller.reverse();
          Future.delayed(const Duration(milliseconds: 50), () {
            widget.onTap!();
          });
        },
        onTapCancel: () {
          _controller.reverse();
        },
        behavior: HitTestBehavior.translucent,
        child: ScaleTransition(
          scale: _animation,
          child: widget.child,
        ),
      );
    } else {
      return widget.child;
    }
  }
}

class BlinkWidget extends StatefulWidget {
  final List<Widget> children;
  final int interval;

  const BlinkWidget({Key? key, required this.children, this.interval = 500})
      : super(key: key);

  @override
  State createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.interval), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (++_currentWidget == widget.children.length) {
            _currentWidget = 0;
          }
        });

        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.children[_currentWidget],
    );
  }
}
