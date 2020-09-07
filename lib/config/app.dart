import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appPrimaryColor = Color(0xFFF8F8F8); // ###F8F8F8
const appSecondaryColor = Color(0xFF075BB3); // #075BB3
const appTextBodyColor = Color(0xFF4F4F4F); // #4F4F4F
const appTextTitleColor = Color(0xFF1F1F1F); // ##1F1F1F
const appTextPrimaryColor = Color(0xFF4F4F4F); // #4F4F4F
const appScaffoldBackgroundColor = appPrimaryColor;
const facebookAppID = "618815765675430";
double appBodyTextFontSize = 15;
double appSecondaryTitleTextFontSize = 20;
double appTitleTextFontSize = 30;
TextStyle appBodyTextStyle =
    GoogleFonts.lato(color: appTextBodyColor, fontSize: appBodyTextFontSize);
TextStyle appSecondaryTitleTextStyle = GoogleFonts.lato(
    color: appTextBodyColor,
    fontSize: appSecondaryTitleTextFontSize,
    fontWeight: FontWeight.w600);
TextStyle appBodyBoldTextStyle = GoogleFonts.lato(
    color: appTextBodyColor,
    fontSize: appBodyTextFontSize,
    fontWeight: FontWeight.bold);
TextStyle appTitleTextStyle = GoogleFonts.lato(
    color: appTextTitleColor,
    fontSize: appTitleTextFontSize,
    fontWeight: FontWeight.bold);
BorderRadius appDefaultBorderRadius = BorderRadius.all(Radius.circular(20));
double appDefaultPadding = 30.0;
const apiUrl = "http://128.199.253.64:1337";
List<BoxShadow> appDefaultShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: 3,
    blurRadius: 7,
    offset: Offset(0, 0), // changes position of shadow
  ),
];
