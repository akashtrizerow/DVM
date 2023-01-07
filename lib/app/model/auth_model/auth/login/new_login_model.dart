// ignore_for_file: non_constant_identifier_names

// aaya TModel hatu eni jagya e me UserLoginModel karyu che
class UserLoginModel {
  late String? id;
  late String? member_number;
  late String? name;
  late String? village;
  late String? live_in;
  late String? mobile_no;
  late String? email;
  late String? status;
  late String? updated_by;
  late String? updated_date;
  late String? created_by;
  late String? created_date;
  UserLoginModel({
    required this.id,
    required this.member_number,
    required this.name,
    required this.village,
    required this.live_in,
    required this.mobile_no,
    required this.email,
    required this.status,
    required this.updated_by,
    required this.updated_date,
    required this.created_by,
    required this.created_date,
  });

  UserLoginModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        member_number = map["member_number"],
        name = map["name"],
        village = map["village"],
        live_in = map["live_in"],
        mobile_no = map["mobile_no"],
        email = map["email"],
        status = map["status"],
        created_by = map["created_by"],
        created_date = map["created_date"],
        updated_by = map["updated_by"],
        updated_date = map["updated_date"];
}
