class ClinicModel {
  int status;
  List<ClinicData> clinicData;
  String message;
  String errors;

  ClinicModel({this.status, this.clinicData, this.message, this.errors});

  ClinicModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['clinic_data'] != null) {
      clinicData = new List<ClinicData>();
      json['clinic_data'].forEach((v) {
        clinicData.add(new ClinicData.fromJson(v));
      });
    }
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.clinicData != null) {
      data['clinic_data'] = this.clinicData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
}

class ClinicData {
  int id;
  String clinicType;
  String code;
  String name;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String postcode;
  String state;
  String city;
  String telNo;
  String faxNo;
  String email;
  String contactPersonName;
  String contactDesignation;
  String contactTelNo;
  String contactMobNo;
  String contactEmail;
  String clinicLat;
  String clinicLong;
  String updatedAt;
  String createdAt;
  int createdBy;
  int updatedBy;
  String deactivatedDate;
  int deactivatedBy;
  int activatedBy;
  String activatedDate;
  String status;

  ClinicData(
      {this.id,
      this.clinicType,
      this.code,
      this.name,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.postcode,
      this.state,
      this.city,
      this.telNo,
      this.faxNo,
      this.email,
      this.contactPersonName,
      this.contactDesignation,
      this.contactTelNo,
      this.contactMobNo,
      this.contactEmail,
      this.clinicLat,
      this.clinicLong,
      this.updatedAt,
      this.createdAt,
      this.createdBy,
      this.updatedBy,
      this.deactivatedDate,
      this.deactivatedBy,
      this.activatedBy,
      this.activatedDate,
      this.status});

  ClinicData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicType = json['clinic_type'];
    code = json['code'];
    name = json['name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    postcode = json['postcode'];
    state = json['state'];
    city = json['city'];
    telNo = json['tel_no'];
    faxNo = json['fax_no'];
    email = json['email'];
    contactPersonName = json['contact_person_name'];
    contactDesignation = json['contact_designation'];
    contactTelNo = json['contact_tel_no'];
    contactMobNo = json['contact_mob_no'];
    contactEmail = json['contact_email'];
    clinicLat = json['clinic_lat'];
    clinicLong = json['clinic_long'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deactivatedDate = json['deactivated_date'];
    deactivatedBy = json['deactivated_by'];
    activatedBy = json['activated_by'];
    activatedDate = json['activated_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_type'] = this.clinicType;
    data['code'] = this.code;
    data['name'] = this.name;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['city'] = this.city;
    data['tel_no'] = this.telNo;
    data['fax_no'] = this.faxNo;
    data['email'] = this.email;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_designation'] = this.contactDesignation;
    data['contact_tel_no'] = this.contactTelNo;
    data['contact_mob_no'] = this.contactMobNo;
    data['contact_email'] = this.contactEmail;
    data['clinic_lat'] = this.clinicLat;
    data['clinic_long'] = this.clinicLong;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deactivated_date'] = this.deactivatedDate;
    data['deactivated_by'] = this.deactivatedBy;
    data['activated_by'] = this.activatedBy;
    data['activated_date'] = this.activatedDate;
    data['status'] = this.status;
    return data;
  }
}
