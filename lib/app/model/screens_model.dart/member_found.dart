// ignore_for_file: camel_case_types

class memberFound {
  int? status;
  int? error;
  Messages? messages;

  memberFound({this.status, this.error, this.messages});

  memberFound.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    messages =
        json['messages'] != null ? Messages.fromJson(json['messages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (messages != null) {
      data['messages'] = messages!.toJson();
    }
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
    data['success'] = success;
    return data;
  }
}
