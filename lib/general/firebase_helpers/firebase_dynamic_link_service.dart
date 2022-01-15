import 'package:brandie_assessment/apps/product/model/product_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamicLinkService {
  static Future<String> createProductDynamicLinks(ProductModel product) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // The Dynamic Link URI domain. You can view created URIs on your Firebase console
      uriPrefix: 'https://brandyAssessment.page.link',
      // The deep Link passed to your application which you can use to affect change
      link: Uri.parse(
        'https://brandy.com.bd/product?id=${product.id}',
      ),
      // Android application details needed for opening correct app on device/Play Store
      androidParameters: const AndroidParameters(
        packageName: 'com.example.brandie_assessment',
      ),
      // iOS application details needed for opening correct app on device/App Store
      // iosParameters: const IOSParameters(
      //   bundleId: iosBundleId,
      //   minimumVersion: '2',
      // ),
    );
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri uri = shortDynamicLink.shortUrl;
    return uri.toString();
  }

  static Future<void> initDynamicLink(context) async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLinkData) {
        var path = dynamicLinkData.link.pathSegments;
        var isProudct = path.contains('product');
        if (isProudct) {
          //do routing
        }
      },
    );
  }
}
