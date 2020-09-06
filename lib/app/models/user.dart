class UserModel {
  List<Userdata> userdata;

  UserModel({this.userdata});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['userdata'] != null) {
      userdata = new List<Userdata>();
      json['userdata'].forEach((v) {
        userdata.add(new Userdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userdata != null) {
      data['userdata'] = this.userdata.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userdata {
  int id;
  String name;
  String username;
  String email;
  int userTypeId;
  String userProfileCode;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;
  int createdBy;
  Null updatedBy;
  int profileId;
  int isAdmin;

  Userdata(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.userTypeId,
      this.userProfileCode,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.profileId,
      this.isAdmin});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    userTypeId = json['user_type_id'];
    userProfileCode = json['user_profile_code'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    profileId = json['profile_id'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['user_type_id'] = this.userTypeId;
    data['user_profile_code'] = this.userProfileCode;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['profile_id'] = this.profileId;
    data['is_admin'] = this.isAdmin;
    return data;
  }
}
