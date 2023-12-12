import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tintin_app/models/gridview_model.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

import '../ad_helper.dart';
import '../service/tintinimages_services.dart';



class FullscreenImage extends StatefulWidget{
  final List<FractionalOffset> fractionalOffsets;

  final int indexImg;
  final int indexTitle;
  FullscreenImage({required Key? key, required this.fractionalOffsets,required this.indexImg, required this.indexTitle}) : super(key: key);
  //FullscreenImage(this.fractionalOffsets,this.index);

  _FullStateImageState  createState()=>new  _FullStateImageState();

}

class _FullStateImageState extends State<FullscreenImage>{
  late Offset _startingFocalPoint;
  late Offset _previousOffset;
  Offset _offset = Offset.zero;

  late double _previousZoom;
  double _zoom = 1.0;
  int number=1;

  List<GridViewModel>  gridview=[];
  bool isLoading =false;
  List<ImageStoryArr> gridImageStoryArray=[];



  // TODO: Add _interstitialAd
  late InterstitialAd _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('Failed to load an interstitial ad');
              _isInterstitialAdReady = true;
            },
          );
          _isInterstitialAdReady = true;

        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }


  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      number=widget.indexImg-1;
    });
    print(widget.indexImg);
    _initGoogleMobileAds();
    _loadInterstitialAd();

    _getImageData();


  }

  _getImageData() async{
    gridImageStoryArray=[];
    setState(() {
      isLoading=true;
    });
    try {
      for(var item in getImges()){
        print(item.imgtitleid);
        if(widget.indexTitle==item.imgtitleid){
          print(item.imageStoryArr.length);
          gridImageStoryArray.addAll(item.imageStoryArr);
        }
      }
      setState(() {
        isLoading=false;
      });

    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait){
      //print("kiki"+index);

      // TODO: implement build
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  if (_isInterstitialAdReady) {
                    _interstitialAd?.show();
                  }
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Titles()));
                }),
            title: Text("Adventure of Tin Tin"),
          ),

          body:Center(

              child:Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onScaleStart: _handleScaleStart,
                      onScaleUpdate:_handleScaleUpdate,
                      onTapDown: (details){
                        setState(() {
                          widget.fractionalOffsets.add(_getFractionalOffset(context, details.globalPosition));
                        });
                      },
                      onDoubleTap: _handleScaleReset,
                      child: Padding(
                        padding:const EdgeInsets.all(4.0),
                        child: Transform(
                          alignment: FractionalOffset.center,

                          transform: Matrix4.diagonal3Values(_zoom, _zoom, 2.0) + Matrix4.translationValues(_offset.dx, _offset.dy, 0.0),
                          child:
                          CachedNetworkImage(
                            fadeInDuration: const Duration(milliseconds: 700),
                            imageUrl: gridImageStoryArray[number].imageUrl,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),

                          ),
                           //Image.network(gridImageStoryArray[number].imageUrl)
                        ),
                      ),
                    ),

                    Padding(
                      padding:const EdgeInsets.all(1.0),
                      child:  Row(
                        children: <Widget>[
                          Expanded(
                            child:ElevatedButton(
                              onPressed: () {
                                if(number<=0){

                                }else{
                                  setState(() {
                                    number = number -1 ;
                                  });

                                  if (_isInterstitialAdReady) {
                                    _interstitialAd?.show();
                                  }
                                  print(number);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  primary: Colors.purple
                              ),


                              child:Text("Prev",
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                      color: Colors.white
                                  ),

                            )
                            )

                          ),

                          Container(width: 30.0),

                          Expanded(
                              child:ElevatedButton(
                                  onPressed: () {
                                          if(number>gridImageStoryArray.length-2 ){

                                          }else{
                                            setState(() {
                                              number = number +1 ;
                                            });

                                            if (_isInterstitialAdReady) {
                                              _interstitialAd?.show();
                                            }
                                            print(number);
                                          }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      primary: Colors.purple
                                  ),


                                  child:Text("Next",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white
                                          ),

                                  )
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
      );
    }else{
// is landscape
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Adventure of Tin Tin"),
          ),

          body:Center(

              child:Container(

                child: Row(

                  children: <Widget>[
                    Expanded(
                      child:ElevatedButton(
                          onPressed: () {
                                  if(number<=0 ){

                                  }else{
                                    setState(() {
                                      number = number -1 ;

                                    });
                                    if (_isInterstitialAdReady) {
                                      _interstitialAd?.show();
                                    }
                                    print(number);
                                  }


                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              primary: Colors.purple
                          ),


                          child:Text("Prev",
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                      color: Colors.white
                                  ),

                          )
                      )

                    ),
                    Container(
                        width:100.0,
                        height: 100.0,
                      margin: const EdgeInsets.all(10.0)
                    ),


      GestureDetector(
//                onScaleStart: (ScaleStartDetails details){
//                  print(details);
//                  _previousScale=_scale;
//                  setState(() {
//
//                  });
//                },
//                onScaleUpdate: (ScaleUpdateDetails details){
//                  print(details);
//                  _scale= _previousScale * details.scale;
//                  setState(() {
//
//                  });
//                },
//                onScaleEnd: (ScaleEndDetails details) {
//                  print(details);
//                  _previousScale=1.0;
//                  setState(() {
//
//                  });
//                },

        onScaleStart: _handleScaleStart,
        onScaleUpdate:_handleScaleUpdate,
        onTapDown: (details){
          setState(() {
            widget.fractionalOffsets.add(_getFractionalOffset(context, details.globalPosition));
          });
        },
        onDoubleTap: _handleScaleReset,



        child: Padding(
          padding:const EdgeInsets.all(4.0),
          child: Transform(
            alignment: FractionalOffset.center,

            transform: Matrix4.diagonal3Values(_zoom, _zoom, 2.0) + Matrix4.translationValues(_offset.dx, _offset.dy, 0.0),
            child:
            CachedNetworkImage(

              maxHeightDiskCache: 100,
              maxWidthDiskCache: 100,
              imageUrl: gridImageStoryArray[number].imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),

            ),
          ),


        ),
      ),

                    Container(
                        width:100.0,
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0)
                    ),

                    Expanded(
                     child:ElevatedButton(
                         onPressed: () {
                                 if(number>gridImageStoryArray.length-2 ){

                                 }else{
                                   setState(() {
                                     number = number +1 ;

                                   });
                                   if (_isInterstitialAdReady) {
                                     _interstitialAd?.show();
                                   }
                                   print(number);
                                 }
                         },
                         style: ElevatedButton.styleFrom(
                             padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10.0)
                             ),
                             primary: Colors.purple
                         ),


                         child: Text("Next",
                                 textDirection: TextDirection.rtl,
                                 style: TextStyle(
                                   fontSize: 20.0
                                 ),

                         )
                     )
                  )
                  ],
                ),
              )
          )
      );
    }


  }

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });
  }


  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _zoom = _previousZoom * details.scale;

      // Ensure that item under the focal point stays in the same place despite zooming
      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * _zoom;
    });
  }

  void _handleScaleReset() {
    setState(() {
      _zoom = 1.0;
      _offset = Offset.zero;
      widget.fractionalOffsets.clear();
    });
  }

  // List<Widget> _getOverlays(BuildContext context) {
  //   return widget.fractionalOffsets
  //       .asMap()
  //       .map((i, fo) => MapEntry(
  //       i,
  //       Align(
  //           alignment: fo,
  //           child: _buildIcon((i + 1).toString(), context)
  //       )
  //   ))
  //       .values
  //       .toList();
  // }

  // Widget _buildIcon(String indexText, BuildContext context) {
  //   return FlatButton.icon(
  //     icon: Icon(Icons.location_on, color: Colors.red),
  //     label: Text(
  //       indexText,
  //       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }

  Widget _buildCircleIcon(String indexText) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child:  Text(
          indexText,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ));
  }

  FractionalOffset _getFractionalOffset(BuildContext context, Offset globalPosition) {
    var renderbox = context.findRenderObject() as RenderBox;
    var localOffset = renderbox.globalToLocal(globalPosition);
    var width = renderbox.size.width;
    var height = renderbox.size.height;
    return FractionalOffset(localOffset.dx/width,localOffset.dy/height);
  }


}