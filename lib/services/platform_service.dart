import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformService {
  bool get isWeb => kIsWeb;

  bool get isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  bool get isAndroid => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600;
  }

  String wrapApiUrl(String url) {
    if (!isWeb) return url;
    // corsproxy.io for API data
    return 'https://corsproxy.io/?${Uri.encodeComponent(url)}';
  }

  String wrapImageUrl(String url) {
    if (!isWeb) return url;
    
    // If it's a Firebase Storage URL, don't proxy it. 
    // We already provided CORS instructions for the bucket.
    if (url.contains('firebasestorage.googleapis.com')) {
      return url;
    }

    // codetabs.com is often faster for binary image data than allorigins/corsproxy.io
    return 'https://api.codetabs.com/v1/proxy?quest=${Uri.encodeComponent(url)}';
  }
}
