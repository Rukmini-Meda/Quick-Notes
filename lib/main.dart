import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/auth_screen.dart';
import 'package:notes_app/widgets/notes_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasData) {
              return MyHomePage(title: "Notes App",);
            } else {
              return AuthScreen();
            }
          }),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    String title = "Title", category = "Category";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
              NotesCard(title: title,category: category,),
          ]
        )
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Header"),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text("Home"),
              onTap: (){},
            ),
            ListTile(
              title: Text("Sign Out"),
              onTap: (){},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.camera_alt
        )
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
