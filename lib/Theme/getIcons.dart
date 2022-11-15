import 'package:flutter/material.dart';
import 'package:employee_app/Theme/colors.dart';
import 'package:employee_app/Theme/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple),
    Icon(IconData(refreshIcon, fontFamily:  'MaterialIcons'), color: gray),
  ];
}
