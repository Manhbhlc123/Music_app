import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class StorageService
{
  final String cloudName = "dyk0npwps";
  final String uploadPreset = "Sq_Mp3";

  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    try {
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );

      //tạo request lên cloud
      final request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset
      //đọc file ảnh, chuyển thành dữ liệu nhị phân, đóng gói thành 1 phần request => thêm file vào request
      //upload_preset = sq_Mp3
      // file = IMG001.jpg
      //toán từ .. cho phép gọi nhiều phương thức trên cùng 1 đối tượng
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        return jsonMap['secure_url'];
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    return null;
  }
}