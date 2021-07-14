


import 'package:flutter/material.dart';
import 'package:flutter_theme_project/state/state_container.dart';

class DialogScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            height: size.height*0.02,
            child: Text(
              "Theme",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),
            ),
          )
        ],
      ),
    );
  }
}


Future<T?> showAppDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  Widget? child,
  required WidgetBuilder builder,
}) {
  assert(child == null || builder == null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context);

  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: StateContainer.of(context).currentTheme.primaryColor!,
    transitionDuration: const Duration(milliseconds: 0),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}
Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}