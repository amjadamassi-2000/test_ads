



import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper{

static const bool _testMode = true ;

static String get bannerAduitId {
  if(_testMode){
    return BannerAd.testAdUnitId;   // TEST BANNER
  }
  return "ca-app-pub-8701400149786904/1520957851" ;
}




static String get  rewardedAdUnitId {

  if(_testMode){
    return RewardedAd.testAdUnitId;
  }
  return  "ca-app-pub-8701400149786904/1041062818";
}


}
