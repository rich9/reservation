import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'scopes.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    AppScope appScope = AppScope.of(context);

    return Hero(
      tag: "mainScaffold",
      child: Scaffold(
        appBar: AppBar(
          title: Text(appScope.authInstance.getUser().displayName),
          actions: <Widget>[
            _logoutButton(context),
          ],
        ),
        drawer: drawer,
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              tabBar,
              Expanded(
                child: TabBarView(
                  children: [
                    displayHome,
                    editTab,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Drawer drawer = Drawer(
  child: ListView(
    children: <Widget>[
      ListTile(
        title: Text("Hello"),
      ),
      ListTile(
        title: Text("World"),
      ),
      ListTile(
        title: Text("!"),
      ),
    ],
  ),
);

IconButton _logoutButton(context) => IconButton(
      icon: Icon(Icons.cancel),
      onPressed: () => Navigator.of(context).pushNamed('/logout'),
    );

TabBar tabBar = const TabBar(tabs: [
  Tab(
    child: Text("Display"),
  ),
  Tab(
    child: Text("Edit"),
  ),
]);

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController controllerHex = TextEditingController();
TextEditingController controllerName = TextEditingController();

Widget editTab = Builder(
  builder: (BuildContext context) => Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controllerName,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextFormField(
              controller: controllerHex,
              decoration: InputDecoration(
                labelText: "Hex",
              ),
            ),
            MaterialButton(
              child: Text("Create New Document!"),
              onPressed: () {
                Firestore.instance
                    .collection('Colors')
                    .document(controllerName.text)
                    .setData({"Hex": controllerHex.text});
              },
            ),
          ],
        ),
      ),
);

//Widget displayTab = Navigator(
//  initialRoute: '/home',
//  onGenerateRoute: (RouteSettings settings) {
//    String routeName = settings.name;
//    if (routeName == "home") {
//      return displayHome;
//    }
//    return MaterialPageRoute(
//      builder: (BuildContext context) => StreamBuilder<DocumentSnapshot>(
//            stream: Firestore.instance
//                .collection('Colors')
//                .document('routeName')
//                .snapshots(),
//            builder: (BuildContext context, snapshot) =>
//                colorTile(snapshot.data, context),
//          ),
//    );
//  },
//);

Widget displayHome = FutureBuilder<QuerySnapshot>(
  future: Firestore.instance.collection('Colors').getDocuments(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) return const Text('Loading...');
    return GridView.count(
      crossAxisCount: 3,
      children: snapshot.data.documents.map((DocumentSnapshot document) {
        Color color = Color(int.parse(document.data['Hex']));
        int newColor = 0x1FEFFFFFF - int.parse(document.data['Hex']);
        print(newColor);
        return Hero(
          tag: 'heroTest' + document.documentID,
          child: Material(
            color: color,
            child: ListTileTheme(
              textColor: Color(newColor),
              child: colorTile(document, context),
            ),
          ),
        );
      }).toList(),
    );
  },
);

colorTile(DocumentSnapshot document, BuildContext context) {
  Color backgroundColor = Color(int.parse(document.data['Hex']));
  Color textColor = Color(0x1FEFFFFFF - int.parse(document.data['Hex']));
  return myColorTile(context,
      title: document.documentID,
      backgroundColor: backgroundColor,
      textColor: textColor);
}

myColorTile(BuildContext context,
    {@required String title,
    @required Color backgroundColor,
    @required Color textColor}) {
  return ListTile(
    onTap: () {
      AppScope.of(context).heroState.setTest({title: backgroundColor});
      Navigator.of(context).pushNamed('/home/changed');
    },
    title: Text(title),
    subtitle: Text("Text Color: 0x${textColor.value.toRadixString(16)}"),
  );
}

class Replaceable extends StatefulWidget {
  Replaceable({@required this.child}) : super();
  final Widget child;

  @override
  State createState() => ReplaceableState();
}

class ReplaceableState extends State<Replaceable> {
  ReplaceableState();
  static Widget child;

  static void changeChild(Widget newChild) {
    child = newChild;
  }

  @override
  Widget build(BuildContext context) => child ?? widget.child;
}
