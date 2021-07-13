import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theme_project/state/ThemeSetting.dart';
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
                print("Click");
                StateContainer.of(context).updateTheme(ThemeOptions.LIGHT);
              },
              child: Text("Nothing")),
        ),
      )
    );
  }
}
