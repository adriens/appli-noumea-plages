import 'package:flutter/material.dart';
import 'Plage.dart';
import 'plageService.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: MyHomePage(title: 'Baignades Nouméa'),
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
  Future<List<Plage>> plages;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  _refresh() {
    plages = PlageService.getPlages();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Plage>>(
        future: plages,
        builder: (BuildContext context, AsyncSnapshot<List<Plage>> snapshot) {

          if ( !snapshot.hasData || snapshot.connectionState == ConnectionState.waiting )
            return Center(child: CircularProgressIndicator());

          return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) { return Divider(); },
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.flag, color: Plage.getFlagColor(snapshot.data[index]), size: 30,),
                  title: Text(snapshot.data[index].nomPlage, style: TextStyle(fontSize: 12.0),),
                  trailing: snapshot.data[index].videoStreamURL != null ? IconButton(icon: Icon(Icons.videocam), onPressed: () async {
                    await launch(snapshot.data[index].videoStreamURL);
                  } ,) : null,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { setState(() { _refresh(); });},
        child: Icon(Icons.refresh),
      ),


      /**ListView.builder(
          itemCount: plages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.flag, color: Plage.getFlagColor(plages[index])),
              trailing: Text(plages[index].baignadeMessage),
              title: Text(plages[index].nomPlage),
            );
          },
      ),**/
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

