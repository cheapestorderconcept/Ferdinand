class ProfileModel {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  num? points;
  String? role;
  String? password;
  String? profilePictures;
  String? createdAt;
  String? updatedAt;
  String? referralID;
  String? image;
  static String clientrole = 'client';
  ProfileModel? myprofileModel;
  ProfileModel(
      {this.sId,
      image,
      firstName,
      lastName,
      profilePictures,
      points,
      email,
      role,
      phoneNumber,
      referralID,
      password,
      createdAt,
      updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    points = json["points"];
    phoneNumber = json["phone_number"];
    referralID = json["referral_id"];
    image = json["image"];
    profilePictures = json["profile_pictures"];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data["points"] = points;
    data["phone_number"] = phoneNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data["referral_id"] = referralID;
    data['role'] = role;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
