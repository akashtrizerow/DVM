class PaymentModel {
  int? status;
  Data? data;
  int? actual;
  int? paid;
  int? unpaid;
  Messages? messages;

  PaymentModel(
      {this.status,
      this.data,
      this.actual,
      this.paid,
      this.unpaid,
      this.messages});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    actual = json['Actual'];
    paid = json['Paid'];
    unpaid = json['Unpaid'];
    messages = json['messages'] != null
        ? new Messages.fromJson(json['messages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['Actual'] = this.actual;
    data['Paid'] = this.paid;
    data['Unpaid'] = this.unpaid;
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    return data;
  }
}

class Data {
  List<Paid>? paid;
  List<UnPaid>? unpaid;

  Data({this.paid, this.unpaid});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['paid'] != null) {
      paid = <Paid>[];
      json['paid'].forEach((v) {
        paid!.add(new Paid.fromJson(v));
      });
    }
    if (json['unpaid'] != null) {
      unpaid = <UnPaid>[];
      json['unpaid'].forEach((v) {
        unpaid!.add(new UnPaid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paid != null) {
      data['paid'] = this.paid!.map((v) => v.toJson()).toList();
    }
    if (this.unpaid != null) {
      data['unpaid'] = this.unpaid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paid {
  String? id;
  String? title;
  String? amount;
  String? createdDate;

  Paid({this.id, this.title, this.amount, this.createdDate});

  Paid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class UnPaid {
  String? id;
  String? title;
  String? amount;
  String? createdDate;

  UnPaid({this.id, this.title, this.amount, this.createdDate});

  UnPaid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['amount'] = this.amount;
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
