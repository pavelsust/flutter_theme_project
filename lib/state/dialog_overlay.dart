import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_theme_project/state/state_container.dart';


class DialogOverlay extends StatefulWidget {
  final String title;
  final List<DialogListItem> optionsList;
  final bool warningStyle;
  final TextSpan? body;
  final bool feeDialog;
  final bool singleButton;

  DialogOverlay(
      {required this.title,
       required this.optionsList,
        this.body,
        this.warningStyle = false,
        this.singleButton = false,
        this.feeDialog = false});

  @override
  State<StatefulWidget> createState() => _DialogOverlayState();
}

class _DialogOverlayState extends State<DialogOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleAnimation = Tween(begin: 0.75, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _opacityAnimation = Tween(begin: 0.25, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildListItems(List<DialogListItem> optionsList) {
    List<Widget> widgets = [];
    for (var option in optionsList) {
      widgets.add(
        // Single Option
        Container(
          width: double.maxFinite,
          height: 50,
          child: FlatButton(
              onPressed: () {
                if (option.action == null || option.disabled) {
                  return;
                }
                option.action();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                alignment: Alignment(-1, 0),
                margin: EdgeInsetsDirectional.only(start: 24, end: 24),
                child: Text(
                  "Dialog",
                  style: TextStyle(
                    color: Colors.black12,
                    fontSize: 15
                  ),
                ),
              )),
        ),
      );
    }
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 20, end: 20),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: 280,
                ),
                decoration: BoxDecoration(
                  color: StateContainer.of(context).currentTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: StateContainer.of(context).currentTheme.primaryColor!,
                      offset: Offset(0, 30),
                      blurRadius: 60,
                      spreadRadius: -10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: double.maxFinite,
                        child: Container(
                          margin:
                          EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                          child: Text(
                            "Normal",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black26
                            ),
                          ),
                        ),
                      ),
                      // Options container
                      widget.body != null
                          ? Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.fromSTEB(
                                24, 16, 24, 16),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text("Rich Text",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16
                                  ),),
                                )
                              ],
                            ),
                          ),


                        ],
                      )
                          : Container(
                        constraints: BoxConstraints(
                            maxHeight:
                            MediaQuery.of(context).size.height * 0.6 -
                                60,
                            minHeight: 0),
                        // Options list
                        child: SingleChildScrollView(
                          padding: EdgeInsetsDirectional.only(
                              top: 8, bottom: 8),
                          child: buildListItems(widget.optionsList),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogListItem {
  final String option;
  final Function action;
  final bool disabled;
  DialogListItem({required this.option, required this.action, this.disabled = false});
}

/// Modified dialog function from flutter source. Modified for the backdrop blur effect

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

