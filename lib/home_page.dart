import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'scopes.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    AppScope appScope = AppScope.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appScope.authInstance.getUser().displayName),
          actions: <Widget>[
            _logoutButton(context),
          ],
        ),
        body: Column(
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
    );
  }
}

IconButton _logoutButton(context) => IconButton(
      icon: Icon(Icons.cancel),
      onPressed: () => Navigator.of(context).pushNamed('/logout'),
    );

TabBar tabBar = TabBar(tabs: [
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

StreamBuilder<QuerySnapshot> displayHome = StreamBuilder<QuerySnapshot>(
  stream: Firestore.instance.collection('Colors').snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) return const Text('Loading...');
    print(snapshot.data.documentChanges);
    return GridView.count(
      crossAxisCount: 3,
      children: snapshot.data.documents.map((DocumentSnapshot document) {
        Color color = Color(int.parse(document.data['Hex']));
        int newColor = 0x1FEFFFFFF - int.parse(document.data['Hex']);
        print(newColor);
        return Material(
          color: color,
          child: ListTileTheme(
            textColor: Color(newColor),
            child: colorTile(document, context),
          ),
        );
      }).toList(),
    );
  },
);

ListTile colorTile(DocumentSnapshot document, BuildContext context) {
  int newColor = 0x1FEFFFFFF - int.parse(document.data['Hex']);
  return ListTile(
    onTap: () {
      NavigatorState nav = Navigator.of(context);
      Navigator.of(context).pushNamed(document.documentID);
    },
    title: Text(document.documentID),
    subtitle: Text("Text Color: 0x${newColor.toRadixString(16)}"),
  );
}

class ExpandingListTile extends ListTile {
  ExpandingListTile({@required title, @required subtitle})
      : super(title: title, subtitle: subtitle);
}
