import 'package:url_launcher/url_launcher.dart';

_launchUrl(Uri _url) async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
