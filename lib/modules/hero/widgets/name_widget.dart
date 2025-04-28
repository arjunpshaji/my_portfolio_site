import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:
          isMobile
              ? _NameText(fontSize: 28, textAlign: TextAlign.center)
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/icons/arrow.png", width: 250),
                  const SizedBox(width: 16),
                  Padding(padding: const EdgeInsets.only(top: 44.0), child: _NameText(fontSize: 34, textAlign: TextAlign.start)),
                ],
              ),
    );
  }
}

class _NameText extends StatelessWidget {
  final double fontSize;
  final TextAlign textAlign;

  const _NameText({required this.fontSize, required this.textAlign});

  @override
  Widget build(BuildContext context) {
    final primary = appColor(context)?.primaryText;
    final secondary = appColor(context)?.secondaryText;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'Hello! I am ', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: primary, fontFamily: 'Caveat')),
          TextSpan(text: 'Arjun P Shaji', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: secondary, fontFamily: 'Caveat')),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
