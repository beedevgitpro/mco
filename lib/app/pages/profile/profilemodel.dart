class ProfileModel {
  List<UserData> userData;

  ProfileModel({this.userData});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['user_data'] != null) {
      userData = new List<UserData>();
      json['user_data'].forEach((v) {
        userData.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int id;
  String code;
  String name;
  Null addressLine1;
  Null addressLine2;
  Null addressLine3;
  Null empSubPostcode;
  String empSubState;
  String empSubCity;
  String empSubTelNo;
  String empSubMobNo;
  String empSubEmail;
  String empSubGender;
  Null empSubDob;
  String empSubNationality;
  String updatedAt;
  String createdAt;
  int createdBy;
  Null updatedBy;
  Null deactivatedDate;
  Null activatedDate;
  Null deactivatedBy;
  Null activatedBy;
  String status;
  String relationship;
  String principalNricCode;
  String principalName;
  int relationshipCheck;
  Null substandardRemarks;

  UserData(
      {this.id,
      this.code,
      this.name,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.empSubPostcode,
      this.empSubState,
      this.empSubCity,
      this.empSubTelNo,
      this.empSubMobNo,
      this.empSubEmail,
      this.empSubGender,
      this.empSubDob,
      this.empSubNationality,
      this.updatedAt,
      this.createdAt,
      this.createdBy,
      this.updatedBy,
      this.deactivatedDate,
      this.activatedDate,
      this.deactivatedBy,
      this.activatedBy,
      this.status,
      this.relationship,
      this.principalNricCode,
      this.principalName,
      this.relationshipCheck,
      this.substandardRemarks});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    empSubPostcode = json['emp_sub_postcode'];
    empSubState = json['emp_sub_state'];
    empSubCity = json['emp_sub_city'];
    empSubTelNo = json['emp_sub_tel_no'];
    empSubMobNo = json['emp_sub_mob_no'];
    empSubEmail = json['emp_sub__email'];
    empSubGender = json['emp_sub_gender'];
    empSubDob = json['emp_sub_dob'];
    empSubNationality = json['emp_sub_nationality'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deactivatedDate = json['deactivated_date'];
    activatedDate = json['activated_date'];
    deactivatedBy = json['deactivated_by'];
    activatedBy = json['activated_by'];
    status = json['status'];
    relationship = json['relationship'];
    principalNricCode = json['principal_nric_code'];
    principalName = json['principal_name'];
    relationshipCheck = json['relationship_check'];
    substandardRemarks = json['substandard_remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['emp_sub_postcode'] = this.empSubPostcode;
    data['emp_sub_state'] = this.empSubState;
    data['emp_sub_city'] = this.empSubCity;
    data['emp_sub_tel_no'] = this.empSubTelNo;
    data['emp_sub_mob_no'] = this.empSubMobNo;
    data['emp_sub__email'] = this.empSubEmail;
    data['emp_sub_gender'] = this.empSubGender;
    data['emp_sub_dob'] = this.empSubDob;
    data['emp_sub_nationality'] = this.empSubNationality;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deactivated_date'] = this.deactivatedDate;
    data['activated_date'] = this.activatedDate;
    data['deactivated_by'] = this.deactivatedBy;
    data['activated_by'] = this.activatedBy;
    data['status'] = this.status;
    data['relationship'] = this.relationship;
    data['principal_nric_code'] = this.principalNricCode;
    data['principal_name'] = this.principalName;
    data['relationship_check'] = this.relationshipCheck;
    data['substandard_remarks'] = this.substandardRemarks;
    return data;
  }
}
