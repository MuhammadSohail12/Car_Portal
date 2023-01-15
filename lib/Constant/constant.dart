import 'package:flutter/material.dart';


class Constant {
  static const TextStyle selectedStyle = TextStyle(
      fontFamily: "Poppins", fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff000000));
  static const TextStyle unSelectedStyle = TextStyle(
      fontFamily: "Poppins", fontSize: 15, fontWeight: FontWeight.w400, color: Color(0x33000000));

  static const Color selectedColor = Color(0xff000000);
  static const Color unSelectedColor = Color(0x33000000);
  static const Color greyColor = Color(0xffF3F3F3);
  static const Color lightBlackColor = Color(0xff34302F);

  static const TextStyle text = TextStyle(
      fontFamily: "Poppins", fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black);
  static const TextStyle text1 = TextStyle(
      fontFamily: "Poppins", fontSize: 13, fontWeight: FontWeight.w500, color: lightBlackColor);


  static emailValidator(String? v) {
    bool _emailValid = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(v!);

    if (v.isEmpty) {
      return 'Please enter your email';
    } else if (!_emailValid) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  static passwordValidator(String? v) {
    bool _isPassword =
    RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$")
        .hasMatch(v!);
    if (v.isEmpty) {
      return 'Please enter the password like (A-123-@)';
    } else if (v.length < 6 || v.length > 25) {
      return 'Password length should be in between 6 and 25';
    } else if (!_isPassword) {
      return 'Please enter a valid password like (A-123-@) ';
      // return Constants.passwordValidator(v);}
    }
  }

  static userNameValidator(String? v) {

    if(v!.isEmpty){
      return 'Please enter a username';
    } else if(v.length<3){
      return 'Username must be at least 3 characters';
    } else{

      return null;
    }


  }

  static phoneNumberValidator(String? v) {

    bool isNumber= RegExp(r'^(03|04|05|06|07)[0-9]{9}$').hasMatch(v!);

    if(v.isEmpty){

      return "Enter a valid 11 digit  Number like(0316 3433343)";


    }else if( v.length<11){

      return 'Phone Number digit length should be 11';


    } else if(!isNumber){
      return "Enter a valid 11 digit  Number like(0316 3433343)";

    }


  }


  static makeValidator(String? v) {
    // List of pre-defined car makes
    final List<String> carMakes = [
      'Toyota',
      'Honda',
      'Ford',
      'Chevrolet',
      'Nissan'
    ];

    if (v!.isEmpty) {
      return 'Please enter a car make';
    }else if (!carMakes.contains(v)) {
      return 'Invalid car make';
    } else{
      return null;
    }



  }

  static modelNumberValidator(String? v){

    bool  carModelNumberExp = RegExp(r'^[A-Z]{3}-\d{4}$').hasMatch(v!);

    if (v.isEmpty) {
      return 'Please enter a car model number';
    } else if(!carModelNumberExp){
      return 'Invalid car model number format';

    }else{

      return null;
    }



  }
  static registerationNumberValidator(String? v){

  bool  carRegistrationNumberExp = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$').hasMatch(v!);
    if (v.isEmpty) {
      return 'Please enter a car registration number';
    } else if(!carRegistrationNumberExp){
      return 'Invalid car registration number format';

    }else{

      return null;
    }



  }


  static carColorValidation(String? v) {
    // List of pre-defined car colors
    final List<String> carColors = [
      'black',
      'white',
      'silver',
      'red',
      'blue'
    ];

    if (v!.isEmpty) {
      return 'Please enter a car color';
    }else  if (!carColors.contains(v.toLowerCase())) {
      return 'Invalid car color(try in lower case of alphebat)';
    }else{
      return null;
    }



  }









}
