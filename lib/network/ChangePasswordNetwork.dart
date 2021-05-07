import 'package:dio/dio.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';

import 'URLconstance.dart';

class ChangePasswordNetwork {

  Future<UserStatusModel> _changePassword(String authen, String password_old, String password_new) async {
    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'password_old': password_old,
        'password_new': password_new,
      });
      var response = await dio.post(URLconstance.CHECK_IN_USER_UPDATE, data: formData,
          options: Options(headers: {'Authorization': authen},
          )
      );
      print('response : ${response}');
      if(response.statusCode == 200){
        return UserStatusModel.fromJson(response.data);
      } else {
        return UserStatusModel.writeError(response.statusMessage);
      }
    } catch (error){
      return UserStatusModel.writeError("Change password exception! : ${error}");
    }
  }
}

class ChangePasswordRepository {
  final ChangePasswordNetwork _changePasswordNetwork = ChangePasswordNetwork();

  Future<UserStatusModel> changePassword(String authen, String password_old, String password_new){
    return _changePasswordNetwork._changePassword(authen, password_old, password_new);
  }
}