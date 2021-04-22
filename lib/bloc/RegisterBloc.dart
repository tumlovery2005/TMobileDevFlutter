import 'package:rxdart/rxdart.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/network/RegisterNetwork.dart';

class RegisterBloc {
  final RegisterRepository _registerRepository = RegisterRepository();
  final BehaviorSubject<StatusModel> _subject = BehaviorSubject<StatusModel>();

  Future<StatusModel> register(String email, String password, String name,
      String birth_date, String telephone, String address) async {
    StatusModel response = await _registerRepository.register(email, password,
        name, birth_date, telephone, address);
    return response;
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<StatusModel> get subject => _subject;
}
final registerBloc = RegisterBloc();