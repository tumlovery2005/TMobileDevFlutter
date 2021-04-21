import 'UserModel.dart';

class UserStatusModel {
    UserModel data;
    String messge;
    bool status;
    String error;

    UserStatusModel(this.error, {this.data, this.messge, this.status});

    factory UserStatusModel.fromJson(Map<String, dynamic> json) {
        return UserStatusModel(
            "",
            data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
            messge: json['messge'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['messge'] = this.messge;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }

    UserStatusModel.writeError(String valueError) : error = valueError;
}