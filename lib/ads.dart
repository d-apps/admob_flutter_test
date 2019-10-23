import 'package:admob_flutter/admob_flutter.dart';

class Ads{

  static String appId = "ca-app-pub-3940256099942544~3347511713";
  static String bannerId = "ca-app-pub-3940256099942544/6300978111";
  static String interstitialId = "ca-app-pub-3940256099942544/1033173712";
  static String nativeId = "";
  static String rewardId = "ca-app-pub-3940256099942544/5224354917";

  static AdmobInterstitial interstitialAd;

  static init(){
    Admob.initialize(appId);
  }

  // INTERSTITIAL

  static Future loadInterstitial() async{

    interstitialAd = AdmobInterstitial(
        adUnitId: interstitialId,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {

        switch(event){

          case AdmobAdEvent.closed:
            Ads.loadInterstitial();
            break;
          case AdmobAdEvent.failedToLoad:
          case AdmobAdEvent.loaded:
          case AdmobAdEvent.clicked:
          case AdmobAdEvent.completed:
          case AdmobAdEvent.impression:
          case AdmobAdEvent.leftApplication:
          case AdmobAdEvent.opened:
          case AdmobAdEvent.started:
          case AdmobAdEvent.rewarded:

            print("EVENTO INTERSTITIAL: $event");
            break;

        }

        }

    );

    interstitialAd.load();

  }

  static Future showInterstitial() async{

    if(await interstitialAd.isLoaded){
      interstitialAd.show();
    } else {
      loadInterstitial().then((_)=> showInterstitial());

    }

  }

  static disposeInterstitial(){
    interstitialAd.dispose();
  }

  // double screenHeight = MediaQuery.of(context).size.height;
  // double screenWidth = MediaQuery.of(context).size.width;

  // Ads.getMargin(screenHeight)

  // Método para setar a margem de banner
  static double getMargin(double height){

    double margin;

    if(height <= 400){

      margin = 37;

    } else if(height >= 400 && height < 720){

      margin = 55;

    } else if(height >= 720){

      margin = 95;

    }

    return margin;

  }

}

  /*
  Test Id's from:
  https://developers.google.com/admob/ios/banner
  https://developers.google.com/admob/android/banner

  App Id
  Android: ca-app-pub-3940256099942544~3347511713
  iOS: ca-app-pub-3940256099942544~1458002511

  Banner
  Android: ca-app-pub-3940256099942544/6300978111
  iOS: ca-app-pub-3940256099942544/2934735716

  Interstitial
  Android: ca-app-pub-3940256099942544/1033173712
  iOS: ca-app-pub-3940256099942544/4411468910

  Reward Video
  Android: ca-app-pub-3940256099942544/5224354917
  iOS: ca-app-pub-3940256099942544/1712485313
  */