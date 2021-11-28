import 'dart:convert';

import 'package:tintin_app/models/api_responce.dart';
import 'package:tintin_app/models/gridview_model.dart';
import 'package:http/http.dart' as http;

class TintinServeces{
  static const API='https://cryptic-citadel-37133.herokuapp.com';
  static const headers={'Content-Type':'application/json'};


  Future<ApiResponse<List<GridViewModel>>> getimgList(){
    return http.get(API + '/tintinimages', headers:headers).then((data){
         print("fff");
        // print(data.body);
        if(data.body!=null){

              final jsonDate = json.decode(data.body);
              final gridview =<GridViewModel>[];
              print(jsonDate);
              for (var item in jsonDate['prodcts']){
                print("lloo");
                  final grid=GridViewModel(
                      img_id: item['id'],
                      imgname: item['imgname'],
                  );
                  gridview.add(grid);
                  //print(gridview);
              }

             return ApiResponse<List<GridViewModel>>(
               data: gridview,
             );

        }
        return ApiResponse<List<GridViewModel>>(
          error: true,
          errormessage: "An error occord"
        );
    }).catchError((_)=>
        ApiResponse<List<GridViewModel>>(
            error: true,
            errormessage: "An error occord"
        )
    );
  }
}