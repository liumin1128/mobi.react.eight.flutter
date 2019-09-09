import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eight/graphql/schema/qiniu.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'graphql.dart';

Future<File> pickerPicture() async {
  File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> getQiniuToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String token;

  token = prefs.getString('qiniuToken');

  if (token != null) {
    return token;
  }

  final client = getClient();
  final QueryResult res = await client.query(QueryOptions(document: qiniuTokenSchema));
  if (res.hasErrors) {
    print('获取token失败');
  }

  token = res.data['qiniuToken']['token'];
  prefs.setString('qiniuToken', token);

  if (token != null) {
    return token;
  }

  return token;
}

Future<String> uploadToQiniu({@required File image}) async {
  String path = image.path;
  var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

  Dio dio = new Dio();

  String token = await getQiniuToken();

  FormData formData = new FormData.from({
    'token': token,
    "file": new UploadFileInfo(
      new File(path),
      name,
      contentType: ContentType.parse("image/$suffix"),
    ),
  });

  var respone = await dio.post<String>(
    "https://upload-z1.qiniup.com",
    data: formData,
  );

  String key = json.decode(respone.data)['key'];
  if (respone.statusCode == 200) {
    return 'https://imgs.react.mobi/' + key;
  }
  return null;
}

Future<List<Asset>> loadAssets() async {
  List<Asset> resultList;
  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 300,
    );
  } on Exception catch (e) {
    print(e);
    // error = e.message;
  }
  return resultList;
}
