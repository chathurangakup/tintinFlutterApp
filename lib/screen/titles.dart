
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tintin_app/screen/fullscreen.dart';
import 'package:tintin_app/service/utils.dart';

import '../service/tintinimages_services.dart';
import 'gridview.dart';

class Titles extends StatefulWidget {


  @override
  State<Titles> createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  @override
  Widget build(BuildContext context) {
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
          return Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: getimgTitles().length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        child: Image.network(getimgTitles()[index].imgUrl),
                      ),

                      onTap: () =>  {
                       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GridViewPage(imgid: getimgTitles()[index].imgid)))
                        this._showDialog(context,getimgTitles()[index].imgid)
                      }
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
      // List<FractionalOffset> fractionalOffsets = new List<FractionalOffset>();
      fractionalOffsets.add(FractionalOffset(1.0, 0.0));
      return FullscreenImage(fractionalOffsets:fractionalOffsets,indexImg:1,indexTitle:index, key: null,);
    }));
  }
}
