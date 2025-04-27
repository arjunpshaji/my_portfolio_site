import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/icons/arrow.png", width: 250),
        Padding(
          padding: const EdgeInsets.only(top:44.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Hello! I am ', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: appColor(context)?.primaryText, fontFamily: 'Caveat')),
                TextSpan(text: 'Arjun P Shaji', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: appColor(context)?.secondaryText, fontFamily: 'Caveat')),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
