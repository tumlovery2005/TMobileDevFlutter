class StatusModel {
    String messge;
    bool status;
    String error;

    StatusModel(this.error, {this.messge, this.status});

    factory StatusModel.fromJson(Map<String, dynamic> json) {
        return StatusModel(
            "",
            messge: json['messge'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['messge'] = this.messge;
        data['status'] = this.status;
        return data;
    }

    StatusModel.writeError(String valueError) : error = valueError;
}