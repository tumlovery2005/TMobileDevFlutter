class LoginRequestModel {
    String email;
    String password;

    LoginRequestModel({this.email, this.password});

    factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
        return LoginRequestModel(
            email: json['email'], 
            password: json['password'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['password'] = this.password;
        return data;
    }
}