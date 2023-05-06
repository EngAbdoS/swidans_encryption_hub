
///////////////////////////////////////////////////////////////////////////

//login models


class UserDataModel {
  UserDataModel(this.uId, this.email, this.mobileNumber, this.countryMobileCode,
      this.profilePicture, this.name, this.password, this.isVerefide);

  String? uId;
  String? email;
  String? mobileNumber;
  String? countryMobileCode;
  String? profilePicture;
  String? name;
  String? password;
  bool? isVerefide;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    countryMobileCode = json['countryMobileCode'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    password = json['password'];
    isVerefide = json['isVerefide'];
  }
}
