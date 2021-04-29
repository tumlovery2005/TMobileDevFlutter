import 'package:rxdart/rxdart.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/network/UpdateProfileNetwork.dart';

class UpdateProfileBloc {
  final UpdateProfileRepository _updateProfileRepository = UpdateProfileRepository();
  final BehaviorSubject<StatusModel> _subject = BehaviorSubject<StatusModel>();

  Future<StatusModel> updateProfile(String authen, String email, String name,
      String birth_date, String telephone, String address) async {
    StatusModel response = await _updateProfileRepository.updateProfile(authen,
        email, name, birth_date, telephone, address);
    return response;
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<StatusModel> get subject => _subject;
}
final updateProfileBloc = UpdateProfileBloc();