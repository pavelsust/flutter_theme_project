
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_theme_project/state/SettingSelectionItem.dart';
import 'package:flutter_theme_project/state/base_theme.dart';

enum ThemeOptions {LIGHT , DARK}

class ThemeSetting extends SettingSelectionItem{

  ThemeOptions theme;
  ThemeSetting(this.theme);

  @override
  String getDisplayName(BuildContext context) {
    switch(theme){
      case ThemeOptions.LIGHT:
        return "Light Theme";
      case ThemeOptions.DARK:
        return "Dark Theme";
      default:
        return "Light Theme";
    }
  }

  BaseTheme getTheme(){
    switch(theme){
      case ThemeOptions.LIGHT:
        return LightTheme();
      case ThemeOptions.DARK:
        return DarkTheme();
      default:
        return LightTheme();
    }
  }

  int getIndex(){
    return theme.index;
  }

}