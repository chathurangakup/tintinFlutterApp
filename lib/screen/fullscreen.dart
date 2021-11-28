import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tintin_app/models/gridview_model.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';



class FullscreenImage extends StatefulWidget{
  final List<FractionalOffset> fractionalOffsets;

  final int index;
  FullscreenImage({Key key, this.fractionalOffsets,this.index}) : super(key: key);
  //FullscreenImage(this.fractionalOffsets,this.index);

  _FullStateImageState  createState()=>new  _FullStateImageState();

}

class _FullStateImageState extends State<FullscreenImage>{
  Offset _startingFocalPoint;
  Offset _previousOffset;
  Offset _offset = Offset.zero;

  double _previousZoom;
  double _zoom = 1.0;
  int number;

  final grid=[
    new GridViewModel(
        img_id:"wsse1",
        imgid:0,
        imgname:"https://cryptic-citadel-37133.herokuapp.com/img0.jpg"
    ),
    new GridViewModel(
        img_id:"wsse2",
        imgid:1,
        imgname:"https://cryptic-citadel-37133.herokuapp.com/img1.jpg"
    ),
    new GridViewModel(
        img_id:"wsse3",
        imgid:2,
        imgname:"https://cryptic-citadel-37133.herokuapp.com/img2.jpg"
    ),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      number=widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait){
      //print("kiki"+index);

      // TODO: implement build
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Adventure of Tin Tin"),
          ),

          body:Center(

              child:Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
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
                            imageUrl: "https://cryptic-citadel-37133.herokuapp.com/img$number.jpg",
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),

                          ),


                          //  Image.network('https://cryptic-citadel-37133.herokuapp.com/img$number.jpg')


                        ),


                      ),
                    ),

                    Padding(
                      padding:const EdgeInsets.all(1.0),

                      child:  Row(

                        children: <Widget>[
                          Expanded(
                            child:RaisedButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)),
                                child: Text("Prev",
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 20.0,


                                  ),
                                ),
                                color: Colors.red,
                                textColor: Colors.white,
                                onPressed:(){
                                  if(number<=0 ){

                                  }else{
                                    setState(() {
                                      number = number -1 ;

                                    });
                                    print(number);
                                  }

                                }

                            ),



                          ),

                          Container(width: 30.0),

                          Expanded(

                              child:RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)),
                                  child:  Text("Next",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 20.0,

                                    ),
                                  ),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPressed:(){
                                    if(number>61 ){

                                    }else{
                                      setState(() {
                                        number = number +1 ;

                                      });
                                      print(number);
                                    }

                                  }

                              )



                          )
                        ],

                      ),
                    )


                  ],
                ),
              )
//        Padding(
//            padding: const EdgeInsets.all(8.0),
//            child:
//            Image.network('https://cryptic-citadel-37133.herokuapp.com/img0.jpg'),
//
//        )
          )




      );
    }else{
// is landscape
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Adventure of Tin Tin"),
          ),

          body:Center(

              child:Container(

                child: Row(

                  children: <Widget>[
                    Expanded(
                      child:RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          child: Text("Prev",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 20.0,


                            ),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed:(){
                            if(number<=0 ){

                            }else{
                              setState(() {
                                number = number -1 ;

                              });
                              print(number);
                            }

                          }

                      ),



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
              imageUrl: "https://cryptic-citadel-37133.herokuapp.com/img$number.jpg",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),

            ),


            //  Image.network('https://cryptic-citadel-37133.herokuapp.com/img$number.jpg')


          ),


        ),
      ),




                    Container(
                        width:100.0,
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0)
                    ),

                    Expanded(
                     child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),

                      child:  Text("Next",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 10.0,

                        ),
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed:(){
                        if(number>61 ){

                        }else{
                          setState(() {
                            number = number +1 ;

                          });
                          print(number);
                        }

                      }

                  )
                                        ,
                  )








//                    Padding(
//                      padding:const EdgeInsets.all(1.0),
//
//                      child:  Row(
//
//                        children: <Widget>[
//                          Expanded(
//                            child:RaisedButton(
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius: new BorderRadius.circular(18.0),
//                                    side: BorderSide(color: Colors.red)),
//                                child: Text("Prev",
//                                  textDirection: TextDirection.ltr,
//                                  style: TextStyle(
//                                    fontSize: 20.0,
//
//
//                                  ),
//                                ),
//                                color: Colors.red,
//                                textColor: Colors.white,
//                                onPressed:(){
//                                  if(number<=0 ){
//
//                                  }else{
//                                    setState(() {
//                                      number = number -1 ;
//
//                                    });
//                                    print(number);
//                                  }
//
//                                }
//
//                            ),
//
//
//
//                          ),
//
//                          Container(width: 30.0),
//
//                          Expanded(
//
//                              child:RaisedButton(
//                                  shape: new RoundedRectangleBorder(
//                                      borderRadius: new BorderRadius.circular(18.0),
//                                      side: BorderSide(color: Colors.red)),
//                                  child:  Text("Next",
//                                    textDirection: TextDirection.rtl,
//                                    style: TextStyle(
//                                      fontSize: 20.0,
//
//                                    ),
//                                  ),
//                                  color: Colors.red,
//                                  textColor: Colors.white,
//                                  onPressed:(){
//                                    if(number>62 ){
//
//                                    }else{
//                                      setState(() {
//                                        number = number +1 ;
//
//                                      });
//                                      print(number);
//                                    }
//
//                                  }
//
//                              )
//
//
//
//                          )
//                        ],
//
//                      ),
//                    )


                  ],
                ),
              )
//        Padding(
//            padding: const EdgeInsets.all(8.0),
//            child:
//            Image.network('https://cryptic-citadel-37133.herokuapp.com/img0.jpg'),
//
//        )
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

  List<Widget> _getOverlays(BuildContext context) {
    return widget.fractionalOffsets
        .asMap()
        .map((i, fo) => MapEntry(
        i,
        Align(
            alignment: fo,
            child: _buildIcon((i + 1).toString(), context)
        )
    ))
        .values
        .toList();
  }

  Widget _buildIcon(String indexText, BuildContext context) {
    return FlatButton.icon(
      icon: Icon(Icons.location_on, color: Colors.red),
      label: Text(
        indexText,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

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