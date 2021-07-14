


import 'package:flutter/material.dart';
import 'package:flutter_theme_project/state/ThemeSetting.dart';
import 'package:flutter_theme_project/state/base_theme.dart';

class _InheritedStateContainer extends InheritedWidget{

  final StateContainerState data;


  _InheritedStateContainer({required this.data ,required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;

}


class StateContainer extends StatefulWidget{

  final Widget child;
  StateContainer( {required this.child});

  static StateContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
    as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();

}

class StateContainerState extends State<StateContainer>{

  BaseTheme currentTheme = DarkTheme();

  // // Change the theme
  // Future<void> updateTheme(ThemeOptions themeOptions) async {
  //   ThemeSetting theme = ThemeSetting(themeOptions);
  //
  //   if(theme.getTheme()!=currentTheme){
  //     if(mounted){
  //       setState(() {
  //         this.currentTheme = theme.getTheme();
  //       });
  //     }
  //   }
  // }

  // Change the theme
  Future<void> updateTheme(ThemeSetting theme) async {

    if (theme.getTheme() != currentTheme) {
      if (mounted) {
        setState(() {
          this.currentTheme = theme.getTheme();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //updateTheme(ThemeOptions.DARK);
    updateTheme(ThemeSetting(ThemeOptions.values[0]));
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child
    );
  }

}