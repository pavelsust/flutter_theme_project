
import 'package:flutter/material.dart';

abstract class BaseTheme{
  int? themeID;

  Color? primaryColor ;
  Color? secondaryColor;

  /// Operator overrides
  bool operator ==(o) => (o.hashCode == hashCode);
  int get hashCode => themeID.hashCode;
}

class LightTheme extends BaseTheme{

  Color normalColor = Colors.orange;
  Color secondNormalColor = Colors.green;

  @override
  int? get themeID => 1;

  @override
  Color? get primaryColor => Colors.yellow;

  @override
  Color? get secondaryColor => Colors.blueGrey;

}

class DarkTheme extends BaseTheme{

  Color normalColor = Colors.black26;
  Color secondNormalColor = Colors.black12;
  @override
  int? get themeID => 2;

  @override
  Color? get primaryColor => Colors.grey;

  @override
  Color? get secondaryColor => Colors.black54;
}