import 'package:dio/dio.dart';
import 'package:tmobiledev/model/StatusModel.dart';

import 'URLconstance.dart';

class RegisterNetwork {

  Future<StatusModel> _Register(String email, String password, String name,
      String birth_date, String telephone, String address) async{
    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'email': email,
        'password': password,
        'name': name,
        'birth_date': birth_date,
        'telephone': telephone,
        'address': address
      });
      var response = await dio.post(URLconstance.CHECK_IN_REGISTER, data: formData);
      if(response.statusCode == 200){
        return StatusModel.fromJson(response.data);
      } else {
        return StatusModel.writeError(response.statusMessage);
      }
    } catch (error){
      return StatusModel.writeError("Register exception! : ${error}");
    }
  }
}

class RegisterRepository {
  final RegisterNetwork _registerNetwork = RegisterNetwork();

  Future<StatusModel> register(String email, String password, String name,
      String birth_date, String telephone, String address){
    return _registerNetwork._Register(email, password, name, birth_date, telephone, address);
  }
}