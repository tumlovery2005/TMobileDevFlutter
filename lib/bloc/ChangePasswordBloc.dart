import 'package:rxdart/rxdart.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/network/ChangePasswordNetwork.dart';

class ChangePasswordBloc {
  final ChangePasswordRepository _changePasswordRepository = ChangePasswordRepository();
  final BehaviorSubject<UserStatusModel> _subject = BehaviorSubject<UserStatusModel>();

  Future<UserStatusModel> changePassword(String authen, String password_old, String password_new){
    var response = _changePasswordRepository.changePassword(authen, password_old, password_new);
    return response;
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<UserStatusModel> get subject => _subject;
}
final changePasswordBloc = ChangePasswordBloc();