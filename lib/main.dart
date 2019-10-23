import 'package:admob_flutter/admob_flutter.dart';
import 'package:admob_flutter_test/ads.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'admob_flutter Plugin Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    Ads.init();
    Ads.loadInterstitial();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

     double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, Ads.getMargin(screenHeight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            SizedBox(
              height: 50,
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                child: Text("Show Interstitial!"),
                onPressed: (){
                  Ads.showInterstitial();
                },
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: Ads.getMargin(screenHeight),
                  child: AdmobBanner(
                      adUnitId: Ads.bannerId,
                      adSize: AdmobBannerSize.SMART_BANNER,
                      listener: (AdmobAdEvent event, Map<String, dynamic> args) {

                        switch (event){

                          case AdmobAdEvent.closed:
                          case AdmobAdEvent.failedToLoad:
                          case AdmobAdEvent.loaded:
                          case AdmobAdEvent.clicked:
                          case AdmobAdEvent.completed:
                          case AdmobAdEvent.impression:
                          case AdmobAdEvent.leftApplication:
                          case AdmobAdEvent.opened:
                          case AdmobAdEvent.started:
                          case AdmobAdEvent.rewarded:

                          print("EVENTO BANNER: $event");
                            break;

                        }

                      }
                  )
              ),
            ),


          ],
        ),
      )

    );
  }


}
