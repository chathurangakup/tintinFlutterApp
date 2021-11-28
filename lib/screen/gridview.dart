

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tintin_app/models/api_responce.dart';
import 'package:tintin_app/models/gridview_model.dart';
import 'package:tintin_app/service/tintinimages_services.dart';

import 'fullscreen.dart';


class GridViewPage extends StatefulWidget{
  _GridViewPageState createState()=> _GridViewPageState();
}


class _GridViewPageState extends State<GridViewPage>{

  TintinServeces get service => GetIt.I<TintinServeces>();
  List<GridViewModel>  gridview=[];
  bool isLoading =false;

  ApiResponse<List<GridViewModel>> _apiResponce;

@override
  void initState() {
    // TODO: implement initState
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async{
        setState(() {
          isLoading=true;
          print('ppppppooo');
        });
        try {
          _apiResponce=await service.getimgList();
          final result = await InternetAddress.lookup('google.com');
          print(result);
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
            _apiResponce=await service.getimgList();
            setState(() {
              isLoading=false;
            });
          }
        } on SocketException catch (_) {
          print('not connected');
          setState(() {
            isLoading=false;
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
         // primaryColor: new Color(value)
        ),
        home:Scaffold(
          appBar: AppBar(
            title: Text(
                'Adventure of TinTin',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          body: OrientationBuilder(builder: (context,orientation)
            {
              if(isLoading){
                return Center(child:CircularProgressIndicator() );
              }

             print(_apiResponce.error);
              print("oooioioioi");

              if(_apiResponce.error){
                return Center(child: Text(_apiResponce.errormessage));
              }

              return Container(
                  padding: EdgeInsets.all(10.0),
                  child: GridView.builder(
                    itemCount:_apiResponce.data.length ,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        child: Image.network('https://cryptic-citadel-37133.herokuapp.com/'+_apiResponce.data[index].imgname+'.jpg'),
                        onTap: () =>  this._showDialog(context,index)
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
      List<FractionalOffset> fractionalOffsets = new List<FractionalOffset>();
      fractionalOffsets.add(FractionalOffset(1.0, 0.0));
      return FullscreenImage(fractionalOffsets:fractionalOffsets,index:index);
    }));
  }

}

