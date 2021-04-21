import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/model/login/LoginRequestModel.dart';
import 'package:tmobiledev/network/URLconstance.dart';

class LoginProvider {

  Future<StatusModel> _Login(String email, String password) async{
    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      var response = await dio.post(URLconstance.CHECK_IN_LOGIN, data: formData);
      if(response.statusCode == 200){
        return StatusModel.fromJson(response.data);
      } else {
        return StatusModel.writeError(response.statusMessage);
      }
    } catch (error){
      return StatusModel.writeError("Login exception! : ${error}");
    }
  }
}

class LoginRepository {
  final LoginProvider _loginProvider = LoginProvider();

  Future<StatusModel> Login(String email, String password){
    return _loginProvider._Login(email, password);
  }
}