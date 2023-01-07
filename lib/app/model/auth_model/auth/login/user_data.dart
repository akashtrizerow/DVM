class UserData {
  int? status;
  String? token;
  Data? data;
  Messages? messages;

  UserData({this.status, this.token, this.data, this.messages});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    messages = json['messages'] != null
        ? new Messages.fromJson(json['messages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? memberNumber;
  String? name;
  String? village;
  String? liveIn;
  String? mobileNo;
  dynamic email;
  String? status;
  String? updatedBy;
  String? updatedDate;
  String? createdBy;
  String? createdDate;

  Data(
      {this.id,
      this.memberNumber,
      this.name,
      this.village,
      this.liveIn,
      this.mobileNo,
      this.email,
      this.status,
      this.updatedBy,
      this.updatedDate,
      this.createdBy,
      this.createdDate});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberNumber = json['member_number'];
    name = json['name'];
    village = json['village'];
    liveIn = json['live_in'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    status = json['status'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_number'] = this.memberNumber;
    data['name'] = this.name;
    data['village'] = this.village;
    data['live_in'] = this.liveIn;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['status'] = this.status;
    data['updated_by'] = this.updatedBy;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class Messages {
  String? success;

  Messages({this.success});

  Messages.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}
