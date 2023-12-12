import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2295070264667994/2282315696';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2295070264667994/2282315696';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    // ca-app-pub-2295070264667994/1837223446 add unit
    // ca-app-pub-3940256099942544/1033173712 test add unit
    if (Platform.isAndroid) {
      return "ca-app-pub-2295070264667994/1837223446";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2295070264667994/1837223446";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}