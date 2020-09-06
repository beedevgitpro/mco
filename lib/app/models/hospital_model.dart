
class HospitalModel {
  int status;
  List<HospitalData> hospitalData;
  String message;
  String errors;

  HospitalModel({this.status, this.hospitalData, this.message, this.errors});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['hospital_data'] != null) {
      hospitalData = new List<HospitalData>();
      json['hospital_data'].forEach((v) {
        hospitalData.add(new HospitalData.fromJson(v));
      });
    }
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.hospitalData != null) {
      data['hospital_data'] = this.hospitalData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
}

class HospitalData {
  int id;
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
  int hospitalCreditLimit;
  String hospitalLat;
  String hospitalLong;
  String createdBy;
  String updatedBy;
  String deactivatedDate;
  String activatedDate;
  String deactivatedBy;
  String activatedBy;
  String updatedAt;
  String createdAt;
  String status;

  HospitalData(
      {this.id,
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
      this.hospitalCreditLimit,
      this.hospitalLat,
      this.hospitalLong,
      this.createdBy,
      this.updatedBy,
      this.deactivatedDate,
      this.activatedDate,
      this.deactivatedBy,
      this.activatedBy,
      this.updatedAt,
      this.createdAt,
      this.status});

  HospitalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    hospitalCreditLimit = json['hospital_credit_limit'];
    hospitalLat = json['hospital_lat'];
    hospitalLong = json['hospital_long'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deactivatedDate = json['deactivated_date'];
    activatedDate = json['activated_date'];
    deactivatedBy = json['deactivated_by'];
    activatedBy = json['activated_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['hospital_credit_limit'] = this.hospitalCreditLimit;
    data['hospital_lat'] = this.hospitalLat;
    data['hospital_long'] = this.hospitalLong;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deactivated_date'] = this.deactivatedDate;
    data['activated_date'] = this.activatedDate;
    data['deactivated_by'] = this.deactivatedBy;
    data['activated_by'] = this.activatedBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}
