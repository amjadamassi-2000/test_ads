import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/next_screen.dart';
import 'package:test_ads/pdf_test.dart';

import 'ads/ad_helper.dart';
import 'ads/banner_ad_model.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfScreen(),

    );
  }
}



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  static RewardedAd _rewardedAd;
  static bool _isAdReady = false;
  static bool adShowed = false;



  static void loadAd(){
    adShowed =false;

    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request:  const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad){
          _rewardedAd = ad;
          _isAdReady = true;
        },
        onAdFailedToLoad: (error){
          log("failed to load rewarded ad: ${error.message}");
        },
      ),
    );
  }


  static void showAd (){
    if(_isAdReady){
      _rewardedAd.show(
          onUserEarnedReward: (ad , rewaredItem){
            log("rewarded item type = ${rewaredItem.type}");
            log("rewarded item amount = ${rewaredItem.amount}");

            adShowed = true;
          }
      );
    }

    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          log("ad dismissed");
          ad.dispose();

        } ,
        onAdFailedToShowFullScreenContent: (ad , error){
          ad.dispose();
        }
    );



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            ElevatedButton(
              child: Text(" To Next Screen >") ,

              onPressed: () {

                if(!adShowed){
                  loadAd();

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text("In order to move to the next interface, you must watch the ad"),
                        content: Text("show the ad"),
                        actions: <Widget>[

                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('close'),
                          ),


                          TextButton(
                            onPressed: () {
                              showAd();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'show',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );



                }else{
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) => NextScreen()));
                }













              }
            ),


            Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Text("Back>>>>>>>>>"),
              color: Colors.blue,
            ),

            Spacer(),

            AdBanner2(),
          ],
        ),
      ),
    );
  }
}
