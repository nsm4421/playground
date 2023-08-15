import 'dart:io';

import 'package:http/http.dart';

class ImageUploadService {
  final String _url;

  ImageUploadService(this._url);

  Future<String> uploadImage(File image) async {
    final req = MultipartRequest('POST', Uri.parse(_url));
    req.files.add(await MultipartFile.fromPath('picture', image.path));
    final result = await req.send();
    if (result.statusCode != 200) return null;
    final response = await Response.fromStream(result);
    return Uri.parse(_url).origin + response.body;
  }
}
