import 'package:url_launcher/url_launcher.dart';

// Launches the URL in the app
Future<void> launchAppUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw 'Could not launch $url';
    }
  }