import 'package:flutter/material.dart';

// https://fedinand-coffee.herokuapp.com/
class Constants {
  // Cannot be extended
  Constants._();
  static const List<String> postalCode = [
    "3000",
    "3001",
    "3004",
    "3005",
    "3006",
    "3007",
    "3008",
    "3011",
    "3012",
    "3013",
    "3014",
    "3015",
    "3018",
    "3019",
    "3027",
    "3097",
    "3098",
    "3047",
    "3072",
    "3032",
    "3033"
  ];
  static const Color primaryColor = Color.fromRGBO(37, 29, 29, 1);
  static const Color secondaryColor = Color.fromRGBO(224, 192, 151, 1);
  static const Color greyColor = Color.fromRGBO(221, 221, 221, 1);
  static const Color orangeColor = Color.fromRGBO(222, 101, 59, 1);
  static const Color greenColor = Color(0xff577860);
  static const Color rustColor = Color.fromRGBO(184, 92, 56, 1);
  static const Color lightGrayColor = Color.fromRGBO(66, 59, 59, 1);
  static const Color scaffoldColor = Color.fromRGBO(44, 36, 36, 1);
  static const Color drawerBgColor = Color.fromRGBO(44, 36, 36, 1);
  static const Color deepBrownColor = Color(0xff251D1D);
  static const Color darkBrown = Color.fromRGBO(56, 41, 41, 1);
  static const Color buttoncolor = Color(0xffB9B8B8);
  static const Color lightbrown = Color(0xff3D3332);
  static const String baseUrl = "https://fedinand-coffee.herokuapp.com/api/v1";
  static const imageBucket = "demo-bucket";
}


//TODO: Implemet remember me
//TODO: fix the my account controller

//REMOVE THE HEART IN PRODUCT DETAIL

//MAKE WISHLIST NAVIGATE TO PRODUCTDETAIL

//CHECKOUT MUST BE 2