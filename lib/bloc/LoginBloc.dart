import 'package:rxdart/subjects.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/network/LoginNetwork.dart';

class LoginBloc {
  final LoginRepository _loginRepository = LoginRepository();
  final BehaviorSubject<StatusModel> _subject = BehaviorSubject<StatusModel>();

  Future<StatusModel> login(String email, String password) async {
    StatusModel response = await _loginRepository.Login(email, password);
    return response;
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<StatusModel> get subject => _subject;
}
final loginBloc = LoginBloc();