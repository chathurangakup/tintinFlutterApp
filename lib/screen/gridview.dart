

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tintin_app/models/api_responce.dart';
import 'package:tintin_app/models/gridview_model.dart';
import 'package:tintin_app/screen/titles.dart';
import 'package:tintin_app/service/tintinimages_services.dart';

import '../ad_helper.dart';
import 'fullscreen.dart';


class GridViewPage extends StatefulWidget{
  final int imgid;
   GridViewPage({Key? key,required this.imgid}) : super(key: key);
  _GridViewPageState createState()=> _GridViewPageState();
}


class _GridViewPageState extends State<GridViewPage> {
  TintinServeces get service => GetIt.I<TintinServeces>();
  List<GridViewModel>  gridview=[];
  bool isLoading =false;
  List<ImageStoryArr> gridImageStoryArray=[];
  // TODO: Add _bannerAd
  late BannerAd _bannerAd;
  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

@override
  void initState() {
    // TODO: implement initState
    _fetchNotes();
    super.initState();
    _initGoogleMobileAds();
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
          print('Failed to load a banner ad');
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }

  _fetchNotes() async{
    gridImageStoryArray=[];
        setState(() {
          isLoading=true;
        });
        try {
          for(var item in getImges()){
            print(item.imgtitleid);
            if(widget.imgid==item.imgtitleid){
              print(widget.imgid==item.imgtitleid);
              print(item.imageStoryArr.length);
              gridImageStoryArray.addAll(item.imageStoryArr);
            }
          }
         print(gridImageStoryArray[0].imageUrl);
          setState(() {
            isLoading=false;
          });

        } on SocketException catch (_) {
          print('not connected');
          setState(() {
            isLoading = false;
          });
        }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title:"Tin Tin",
        theme: ThemeData(
        ),
        home:Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Titles()));
                }),
            title: Text("Adventure of Tin Tin"),
          ),
          body: OrientationBuilder(builder: (context,orientation)
            {
              if(isLoading){
                return Center(child:CircularProgressIndicator() );
              }
              // TODO: Display a banner when ready
              if (_isBannerAdReady)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                );


              return Container(
                  padding: EdgeInsets.all(10.0),
                  child: GridView.builder(
                    itemCount:gridImageStoryArray.length ,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        child: Image.network(gridImageStoryArray[index].imageUrl),
                        onTap: () =>  this._showDialog(context,gridImageStoryArray[index].imgid)
                      );
                    },
                  ));
            }),

    ),
    );
  }

  void _showDialog(BuildContext context,int index) {
    // flutter defined function

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      List<FractionalOffset> fractionalOffsets = [];
      fractionalOffsets.add(FractionalOffset(1.0, 0.0));
      return FullscreenImage(fractionalOffsets:fractionalOffsets,indexImg:index,indexTitle:widget.imgid, key: null,);
    }));
  }

}

