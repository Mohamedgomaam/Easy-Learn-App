import 'package:firebase_auth/firebase_auth.dart';

class UserInformation{
  String _userId="";
  String _name="";
  String _phone="";
  String _email="";
  String _imageURL="https://i.pngimg.me/thumb/f/720/m2i8m2A0K9H7N4m2.jpg";
  List _enrolled=[];

  UserInformation(
      this._userId,
      this._name,
      this._phone,
      this._email,
      this._enrolled,
      [this._imageURL="https://i.pngimg.me/thumb/f/720/m2i8m2A0K9H7N4m2.jpg"]
  ){
    userId=FirebaseAuth.instance.currentUser?.uid?? "";

  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  UserInformation.fromMap(Map<dynamic ,dynamic> data){
    _email=data["email"];
    _enrolled=data["enrolled"];
    _userId=data["id"];
    _imageURL=data["imageURL"];
    _name=data["name"];
    _phone=data["phone"];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get imageURL => _imageURL;

  set imageURL(String value) {
    _imageURL = value;
  }

  List get enrolled => _enrolled;

  set enrolled(List value) {
    _enrolled = value;
  }

  Map<String ,dynamic> toMap(){
    return{
    "email":_email,
    "enrolled":_enrolled,
    "id":_userId,
    "imageURL":_imageURL,
    "name":_name,
    "phone":_phone,
    };
  }

}