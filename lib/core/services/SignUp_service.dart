import 'package:emails_validator/emails_validator.dart';

class SignUpService
{

  //check valid data
  String? checkValidate(
      String phone,
      String email,
      String password,
      String repassword,
      int birthday_year,
      String selecteCountry,
      String language,
      ) {
    if (phone.isEmpty) {
      return "bạn phải nhập số điện thoại";
    } else {
      if (phone.length != 10 && RegExp(r'^[0-9]+$').hasMatch(phone)) {
        return "số điện thoại phải đúng 10 chữ số";
      }
    }

    if (email.isEmpty) {
      return "bạn phải nhập email";
    } else {
      if (!EmailsValidator.validate(email)) {
        return "Email bạn nhập không hợp lệ";
      }
    }

    if (password.isEmpty) {
      return "bạn phải nhập mật khẩu";
    } else {
      if (password.length <= 6) {
        return "bạn phải nhập mật khẩu ít nhất 6 ký tự";
      }
    }

    if (repassword.isEmpty) {
      return "bạn phải nhập mật khẩu xác nhận";
    } else {
      if (password != repassword) {
        return "bạn phải nhập mật khẩu xác nhận trùng với mật khẩu";
      }
    }

    if (birthday_year == 0) {
      return "bạn chưa chọn năm sinh";
    }

    if (selecteCountry.isEmpty) {
      return "bạn chưa chọn đất nước";
    }

    if (language.isEmpty) {
      return "bạn chưa chọn ngôn ngữ";
    }
    return null;
  }


  List<int> getBirthDayYear() {
    return List.generate(
      DateTime.now().year - 1970 + 1,
          (index) => 1970 + index,
    );
  }
}