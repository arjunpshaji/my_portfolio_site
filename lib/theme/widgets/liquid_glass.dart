import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/widgets/custom_cursor.dart';

/// Clean, sleek Frosted Glass Container with backdrop blur and subtle border.
class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? tintColor;
  final double blur;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.tintColor,
    this.blur = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: const Color(0xff0F0C20).withValues(alpha: 0.8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Clean, high-performance button with smooth hover scaling and custom cursor reaction.
class LiquidGlassButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget? child;
  final String? label;
  final IconData? icon;
  final Color? primaryColor;
  final Color? secondaryColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isSecondary;

  const LiquidGlassButton({
    super.key,
    required this.onTap,
    this.child,
    this.label,
    this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.borderRadius = 14.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
    this.isSecondary = false,
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.primaryColor ?? const Color(0xff7C3AED);
    final secondary = widget.secondaryColor ?? const Color(0xff06B6D4);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        CursorController.instance.setHovering(true);
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _isPressed = false;
        });
        CursorController.instance.setHovering(false);
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : (_isHovered ? 1.04 : 1.0),
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: widget.isSecondary
                  ? null
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _isHovered
                          ? [primary, secondary]
                          : [primary, primary.withValues(alpha: 0.85)],
                    ),
              color: widget.isSecondary
                  ? (_isHovered
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.05))
                  : null,
              border: Border.all(
                color: widget.isSecondary
                    ? (_isHovered
                        ? Colors.white.withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.18))
                    : (_isHovered
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.white.withValues(alpha: 0.2)),
                width: 1,
              ),
              boxShadow: [
                if (!widget.isSecondary)
                  BoxShadow(
                    color: primary.withValues(alpha: _isHovered ? 0.45 : 0.2),
                    blurRadius: _isHovered ? 20 : 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: widget.child ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (widget.label != null)
                      Text(
                        widget.label!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Manrope',
                        ),
                      ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
