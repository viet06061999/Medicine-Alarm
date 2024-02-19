import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF012D6D);
const Color kScaffoldColor = Color(0xFFF3F4F8);
const Color kSecondaryColor = Color(0xFFF95C54);
const Color kOtherColor = Color(0xFF59C1BD);
const Color kErrorBorderColor = Color(0xFFE74C3C);
const Color kTextLightColor = Color(0xFFC5BDCD);
const Color kTextColor = Color(0xFF553E5C);
const Color kTitleColor = Color(0xFFE58F75);
const Color kTextPrime = Color(0xFF012D6D);
const Color kOrange = Color(0xFFFF7900);
const Color kBackground = Color(0xFFE0F0FF);
const Color kStroke = Color(0xFFCBCBCB);
const Color kHint = Color(0xFFEFC39B);
const Color kGray = Color(0xFFDADADA);

InputBorder noOutLineBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(10),
);

InputBorder outLineBorder = OutlineInputBorder(
  borderSide: const BorderSide(
    color: kStroke, // Màu viền khi không được nhấn vào
    width: 1.0, // Độ dày của viền
  ),
  borderRadius: BorderRadius.circular(10),
);