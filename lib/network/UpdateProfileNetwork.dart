import 'package:dio/dio.dart';
import 'package:tmobiledev/model/StatusModel.dart';

import 'URLconstance.dart';

class UpdateProfileNetwork {

  Future<StatusModel> _updateProfile(String authen, String email, String name,
      String birth_date, String telephone, String address) async {
    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'email': email,
        'name': name,
        'birth_date': birth_date,
        'telephone': telephone,
        'address': address
      });
      var response = await dio.post(URLconstance.CHECK_IN_USER_UPDATE, data: formData,
          options: Options(headers: {'Authorization': authen},
        )
      );
      if(response.statusCode == 200){
        return StatusModel.fromJson(response.data);
      } else {
        return StatusModel.writeError(response.statusMessage);
      }
    } catch (error){
      return StatusModel.writeError("Update profile exception! : ${error}");
    }
  }
}

class UpdateProfileRepository {
  final UpdateProfileNetwork _updateProfileNetwork = UpdateProfileNetwork();

  Future<StatusModel> updateProfile(String authen, String email, String name,
      String birth_date, String telephone, String address){
    return _updateProfileNetwork._updateProfile(authen, email, name, birth_date,
        telephone, address);
  }
}

