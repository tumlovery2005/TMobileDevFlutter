import 'package:rxdart/subjects.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/network/UserMeNetwork.dart';

class UserMeBloc {
  final UserMeRepository _userMeRepository = UserMeRepository();
  final BehaviorSubject<UserStatusModel> _subject = BehaviorSubject<UserStatusModel>();

  Future<UserStatusModel> getUserMe(String authen) async {
    var response = await _userMeRepository.getUserMe(authen);
    return response;
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<UserStatusModel> get subject => _subject;
}
final userMeBloc = UserMeBloc();