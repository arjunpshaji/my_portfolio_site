import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

/// Global controller to trigger cursor state changes (hovering interactive elements)
class CursorController extends ChangeNotifier {
  static final CursorController instance = CursorController._();
  CursorController._();

  bool _isHoveringInteractive = false;
  String? _hoverText;

  bool get isHoveringInteractive => _isHoveringInteractive;
  String? get hoverText => _hoverText;

  void setHovering(bool hovering, {String? text}) {
    if (_isHoveringInteractive != hovering || _hoverText != text) {
      _isHoveringInteractive = hovering;
      _hoverText = text;
      notifyListeners();
    }
  }
}

/// A wrapper widget that marks any child as an interactive hover target for the custom cursor
class InteractiveCursorZone extends StatelessWidget {
  final Widget child;
  final String? hoverText;
  final VoidCallback? onTap;

  const InteractiveCursorZone({
    super.key,
    required this.child,
    this.hoverText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => CursorController.instance.setHovering(true, text: hoverText),
      onExit: (_) => CursorController.instance.setHovering(false),
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

/// The overlay that tracks mouse position and renders:
/// 1. An ultra-responsive inner glowing dot
/// 2. A smooth, spring-interpolated trailing aura ring that expands on hover
class CustomCursorOverlay extends StatefulWidget {
  final Widget child;

  const CustomCursorOverlay({super.key, required this.child});

  @override
  State<CustomCursorOverlay> createState() => _CustomCursorOverlayState();
}

class _CustomCursorOverlayState extends State<CustomCursorOverlay> {
  Offset _mousePos = const Offset(-100, -100);
  bool _isMouseInside = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Only show on desktop screens
    if (screenWidth < 900) {
      return widget.child;
    }

    final colors = appColor(context);
    final brandAccent = colors?.hoverColor ?? const Color(0xff8B5CF6);

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = event.position;
          _isMouseInside = true;
        });
      },
      onExit: (_) {
        setState(() => _isMouseInside = false);
      },
      child: Stack(
        children: [
          widget.child,

          // Custom Follower Cursor
          if (_isMouseInside)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: CursorController.instance,
                  builder: (context, _) {
                    final isHovering =
                        CursorController.instance.isHoveringInteractive;
                    final hoverText = CursorController.instance.hoverText;
                    final ringSize = isHovering ? 52.0 : 30.0;
                    final dotSize = isHovering ? 4.0 : 6.0;

                    return Stack(
                      children: [
                        // Smooth Spring Trailing Ring / Aura
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 140),
                          curve: Curves.easeOutCubic,
                          left: _mousePos.dx - (ringSize / 2),
                          top: _mousePos.dy - (ringSize / 2),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            width: ringSize,
                            height: ringSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isHovering
                                  ? brandAccent.withValues(alpha: 0.12)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isHovering
                                    ? brandAccent.withValues(alpha: 0.85)
                                    : Colors.white.withValues(alpha: 0.3),
                                width: isHovering ? 1.5 : 1.2,
                              ),
                              boxShadow: isHovering
                                  ? [
                                      BoxShadow(
                                        color: brandAccent.withValues(alpha: 0.35),
                                        blurRadius: 16,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 6,
                                      ),
                                    ],
                            ),
                            child: hoverText != null && isHovering
                                ? Center(
                                    child: Text(
                                      hoverText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Manrope',
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),

                        // Immediate Inner Glowing Dot
                        Positioned(
                          left: _mousePos.dx - (dotSize / 2),
                          top: _mousePos.dy - (dotSize / 2),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: dotSize,
                            height: dotSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isHovering
                                  ? brandAccent
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: isHovering
                                      ? brandAccent.withValues(alpha: 0.7)
                                      : Colors.white.withValues(alpha: 0.8),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
