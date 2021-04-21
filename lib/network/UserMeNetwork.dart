import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/network/URLconstance.dart';

class UserMeProvider {
  Future<UserStatusModel> getUserMe(String authen) async {
    try {
      var dio = Dio();
      // var formData = FormData.fromMap({
      //   'email': email,
      // });
      var response = await dio.get(URLconstance.CHECK_IN_USER_ME, options: Options(
        headers: {'Authorization': authen},
      ));
      if(response.statusCode == 200){
        print('response : ${response.data}');
        return UserStatusModel.fromJson(response.data);
      } else {
        return UserStatusModel.writeError(response.statusMessage);
      }
    } catch (error) {
      print('user me : ${error}');
      return UserStatusModel.writeError("User me exception!");
    }
  }
}

class UserMeRepository {
  final UserMeProvider _userMeProvider = UserMeProvider();

  Future<UserStatusModel> getUserMe(String authen){
    return _userMeProvider.getUserMe(authen);
  }
}