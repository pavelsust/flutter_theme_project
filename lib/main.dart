import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theme_project/state/ThemeSetting.dart';
import 'package:flutter_theme_project/state/dialog_overlay.dart';
import 'package:flutter_theme_project/state/dialog_screen.dart';
import 'package:flutter_theme_project/state/state_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(StateContainer(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: StateContainer.of(context).currentTheme.primaryColor,
        accentColor: StateContainer.of(context).currentTheme.secondaryColor
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: StateContainer.of(context).currentTheme.secondaryColor,
        child: Center(
          child: GestureDetector(
              onTap: (){
                //StateContainer.of(context).updateTheme(ThemeOptions.LIGHT);
                showAppDialog(
                    context: context,
                    builder: (_) => DialogOverlay(
                        title: "Testing purpose",
                        optionsList: getThemeList(),));
              },
              child: Text("Nothing")),
        ),
      )
    );
  }



  List<DialogListItem> getThemeList() {
    List<DialogListItem> ret = [];
    ThemeOptions.values.forEach((ThemeOptions value) {
      ThemeSetting theme = ThemeSetting(value);
      ret.add(DialogListItem(
          option: theme.getDisplayName(context),
          action: () {
            StateContainer.of(context).updateTheme(ThemeSetting(value));
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }
}
