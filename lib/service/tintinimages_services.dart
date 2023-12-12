import 'dart:convert';
import 'dart:ffi';

import 'package:tintin_app/models/api_responce.dart';
import 'package:tintin_app/models/gridview_model.dart';
import 'package:http/http.dart' as http;
import 'package:tintin_app/models/gridview_title_model_new.dart';
import 'package:tintin_app/service/utils.dart';

import '../models/gridview_model_title.dart';

class TintinServeces{
  static const API='https://cryptic-citadel-37133.herokuapp.com';
  static const headers={'Content-Type':'application/json'};


  Future<Null> getimgList(){
    return http.get(Uri.parse(API + '/tintinimages') , headers:headers).then((data){
        // if(data.body!=null){
        //       final jsonDate = json.decode(data.body);
        //       final gridview =<GridViewModel>[];
        //       print(jsonDate);
        //       for (var item in jsonDate['prodcts']){
        //           final grid=GridViewModel(
        //               img_id: item['id'],
        //               imgname: item['imgname'],
        //           );
        //           gridview.add(grid);
        //       }
        //      return ApiResponse<List<GridViewModel>>(
        //        data: gridview,
        //      );
        //
        // }
        // return ApiResponse<List<GridViewModel>>(
        //   error: true,
        //   errormessage: "An error occord"
        // );
    }).catchError((_)=>
        ApiResponse<List<GridViewModel>>(
            error: true,
            errormessage: "An error occord", data: []
        )
    );
  }
}




List<GridViewModelTitleNew> getimgTitles(){
  List<GridViewModelTitleNew> gridview = [];
  if( TinTinImages.titles.length!=0) {
    // final gridview =<GridViewModelTitle>[];

   //  for (var i = 0; i < TinTinImages.titles.length; i++) {
   //    print('TinTinImages.titles[i]');
   //    print(TinTinImages.titles[i]);
   //    final grid=GridViewModelTitleNew(
   //              imgid: TinTinImages.titles[i],
   //              imgUrl: item['imageUrl'],
   // );
   //            gridview.add(grid);
   //  }
      for (var item in TinTinImages.titles){
        print('TinTinImages.titles');
        print(item['imgid']);
       // int imgid= Int(item['imgid']) as int;
        final grid=GridViewModelTitleNew(
          imgid: item['imgid'] as int,
          imgUrl: item['imageUrl'] as String,
        );
       gridview.add(grid);
      }
    }

  return gridview;
}


List<ImageArray> getImges() {
  List<ImageArray> gridview = [];
  if (TinTinImages.stories.length != 0) {
    // final gridview =<ImageArray>[];
    //  var gridSub =<ImageStoryArr>[];
    List<ImageStoryArr> gridSub = [];
    for (var item in TinTinImages.stories) {
      gridSub = [];
      for (var item1 in item['imageStoryArr'] as List) {
        final grid = ImageStoryArr(
            imgid: item1['imgid'],
            imageUrl: item1['imageUrl']
        );
        gridSub.add(grid);
      }
      final grid = ImageArray(
        imgtitleid: item['imgtitleid'] as int,
        imageStoryArr: gridSub,
      );
      gridview.add(grid);
    }
  }
    return gridview;
  }



