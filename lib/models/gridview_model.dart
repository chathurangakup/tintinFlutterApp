
import 'dart:convert';

class GridViewModel {
  String img_id;
  int imgid;

  String imgname;

  GridViewModel({
    this.img_id,
    this.imgid,
    this.imgname});

}




ImageArray imageArrayFromJson(String str) => ImageArray.fromJson(json.decode(str));

String imageArrayToJson(ImageArray data) => json.encode(data.toJson());

class ImageArray {
  ImageArray({
    this.imgtitleid,
    this.imageStoryArr,
  });

  int imgtitleid;
  List<ImageStoryArr> imageStoryArr;

  factory ImageArray.fromJson(Map<String, dynamic> json) => ImageArray(
    imgtitleid: json["imgtitleid"],
    imageStoryArr: List<ImageStoryArr>.from(json["imageStoryArr"].map((x) => ImageStoryArr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "imgtitleid": imgtitleid,
    "imageStoryArr": List<dynamic>.from(imageStoryArr.map((x) => x.toJson())),
  };
}

class ImageStoryArr {
  ImageStoryArr({
    this.imgid,
    this.imageUrl,
  });

  int imgid;
  String imageUrl;

  factory ImageStoryArr.fromJson(Map<String, dynamic> json) => ImageStoryArr(
    imgid: json["imgid"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imgid": imgid,
    "imageUrl": imageUrl == null ? null : imageUrl,
  };
}
