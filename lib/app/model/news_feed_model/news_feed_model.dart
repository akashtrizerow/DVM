class NewsFeedModel {
  var status;
  List<Posts>? posts;
  String? page;
  String? limit;
  Messages? messages;

  NewsFeedModel(
      {this.status, this.posts, this.page, this.limit, this.messages});

  NewsFeedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    messages = json['messages'] != null
        ? new Messages.fromJson(json['messages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    return data;
  }
}

class Posts {
  String? id;
  String? title;
  String? description;
  String? file;
  String? type;
  String? amount;
  String? status;
  String? isPaid;

  Posts(
      {this.id,
      this.title,
      this.description,
      this.file,
      this.type,
      this.amount,
      this.status,
      this.isPaid});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    type = json['type'];
    amount = json['amount'];
    status = json['status'];
    isPaid = json['is_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['file'] = this.file;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['is_paid'] = this.isPaid;
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
