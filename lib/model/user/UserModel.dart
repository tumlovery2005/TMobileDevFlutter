class UserModel {
    String checkin_user_telephone = "";
    String checkin_user_address = "";
    String checkin_user_birth_date = "";
    String checkin_user_email = "";
    String checkin_user_name = "";
    String checkin_user_photo = "";

    UserModel({this.checkin_user_telephone, this.checkin_user_address,
        this.checkin_user_birth_date, this.checkin_user_email, this.checkin_user_name,
        this.checkin_user_photo});

    factory UserModel.fromJson(Map<String, dynamic> json) {
        return UserModel(
            checkin_user_telephone: json['checkin_user_telephone'],
            checkin_user_address: json['checkin_user_address'], 
            checkin_user_birth_date: json['checkin_user_birth_date'], 
            checkin_user_email: json['checkin_user_email'], 
            checkin_user_name: json['checkin_user_name'], 
            checkin_user_photo: json['checkin_user_photo'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['checkin_user_telephone'] = this.checkin_user_telephone;
        data['checkin_user_address'] = this.checkin_user_address;
        data['checkin_user_birth_date'] = this.checkin_user_birth_date;
        data['checkin_user_email'] = this.checkin_user_email;
        data['checkin_user_name'] = this.checkin_user_name;
        data['checkin_user_photo'] = this.checkin_user_photo;
        return data;
    }
}