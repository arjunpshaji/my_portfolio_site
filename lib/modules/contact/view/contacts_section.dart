import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/image_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        SizedBox(height: 12),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageButton(assetPath: "assets/icons/gmail_icon.png", onTap: () => {
              launchAppUrl('mailto:imarjunpshaji@gmail.com')
            }),
            ImageButton(assetPath: "assets/icons/linkedin_icon.png", onTap: () => {
              launchAppUrl('https://www.linkedin.com/in/arjun-p-shaji-0a10a51a6')
            }),
            ImageButton(assetPath: "assets/icons/github_logo.png", onTap: () => {
              launchAppUrl('https://github.com/arjunpshaji')
            }),
            ImageButton(assetPath: "assets/icons/instagram_icon.png", onTap: () => {
              launchAppUrl('https://www.instagram.com/arjunpshaji._/')
            }),
          ],
        ),
        SelectableText(
          'Email: imarjunpshaji@gmail.com',
          style: TextStyle(fontSize: 16, color: appColor(context)?.primaryText, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 12)
      ],
    );
  }
}
