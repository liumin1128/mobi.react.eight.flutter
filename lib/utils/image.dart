import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

Future<File> pickerPicture() async {
  File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future uploadPicture({@required File image}) async {
  String path = image.path;
  var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

  FormData formData = new FormData.from(
    {
      "userId": "10000024",
      "file": new UploadFileInfo(new File(path), name, contentType: ContentType.parse("image/$suffix")),
    },
  );

  Dio dio = new Dio();
  var respone = await dio.post<String>("https://upload-z1.qiniup.com", data: formData);
  print('respone');
  print(respone);
  if (respone.statusCode == 200) {
    // aaa
  }
  // return action;
}
