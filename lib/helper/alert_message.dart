import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/extension.dart';

import 'dart:async';

import '../constants/app_constants.dart';

class AlertMessage {
  static showError(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(
          Icons.error,
          color: Colors.white,
          size: 40,
        ),
        HexColor.fromHex("BB2124"));
  }

  static showSuccess(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
        HexColor.fromHex("22bb33"));
  }

  static showWarning(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(Icons.error, color: Colors.white, size: 40),
        HexColor.fromHex("f0ad4e"));
  }
}

class ToastUtils {
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  static void showCustomToast(
      BuildContext context, String message, Icon icon, Color color) {
    if (!(toastTimer?.isActive ?? false)) {
      toastTimer = null;
    }
    if (toastTimer == null) {
      if (!(toastTimer?.isActive ?? false)) {
        _overlayEntry = createOverlayEntry(context, message, icon, color);
        Overlay.of(context)!.insert(_overlayEntry!);
        toastTimer = Timer(const Duration(seconds: 2), () {
          if (_overlayEntry != null) {
            _overlayEntry?.remove();
          }
        });
      }
    }
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, String message, Icon icon, Color color) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: AppSizes.width.toDouble(),
        child: SlideInToastMessageAnimation(Material(
          child: Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 8, left: 16, right: 8),
            decoration: BoxDecoration(color: color),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  icon,
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                      width: AppSizes.width * 0.8,
                      child: Text(
                        message,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: AppColors.white),
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class SlideInToastMessageAnimation extends StatefulWidget {
  final Widget child;

  SlideInToastMessageAnimation(this.child);

  @override
  _SlideInToastMessageAnimationState createState() =>
      _SlideInToastMessageAnimationState();
}

class _SlideInToastMessageAnimationState
    extends State<SlideInToastMessageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
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
      builder: (context, child) {
        return Opacity(
          opacity: 1.0 - _animation.value.dx.abs(),
          child: Transform.translate(
            offset: _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

enum AnimationType { opacity, translateX }
