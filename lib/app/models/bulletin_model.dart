class BulletinModel {
  int status;
  List<BulletinData> bulletinData;
  String message;
  String errors;

  BulletinModel({this.status, this.bulletinData, this.message, this.errors});

  BulletinModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['bulletin_data'] != null) {
      bulletinData = new List<BulletinData>();
      json['bulletin_data'].forEach((v) {
        bulletinData.add(new BulletinData.fromJson(v));
      });
    }
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bulletinData != null) {
      data['bulletin_data'] = this.bulletinData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
}

class BulletinData {
  int id;
  String bulletinTitle;
  String bulletinDescription;
  String startDate;
  String endDate;
  String userTypeId;
  int createdBy;
  int updatedBy;
  String deactivatedDate;
  int deactivatedBy;
  String activatedDate;
  int activatedBy;
  String updatedAt;
  String createdAt;
  String status;

  BulletinData(
      {this.id,
      this.bulletinTitle,
      this.bulletinDescription,
      this.startDate,
      this.endDate,
      this.userTypeId,
      this.createdBy,
      this.updatedBy,
      this.deactivatedDate,
      this.deactivatedBy,
      this.activatedDate,
      this.activatedBy,
      this.updatedAt,
      this.createdAt,
      this.status});

  BulletinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bulletinTitle = json['bulletin_title'];
    bulletinDescription = json['bulletin_description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    userTypeId = json['user_type_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deactivatedDate = json['deactivated_date'];
    deactivatedBy = json['deactivated_by'];
    activatedDate = json['activated_date'];
    activatedBy = json['activated_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bulletin_title'] = this.bulletinTitle;
    data['bulletin_description'] = this.bulletinDescription;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['user_type_id'] = this.userTypeId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deactivated_date'] = this.deactivatedDate;
    data['deactivated_by'] = this.deactivatedBy;
    data['activated_date'] = this.activatedDate;
    data['activated_by'] = this.activatedBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}
