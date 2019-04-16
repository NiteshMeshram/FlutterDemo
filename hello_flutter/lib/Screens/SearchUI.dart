import 'package:flutter/material.dart';

//void main() => runApp(new MyApp());

class SearchUI extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
        primarySwatch: Colors.blue,
    ),
    home: new SearchUIPage(title: 'ListView with Search'),
    );
  }
}

class SearchUIPage extends StatefulWidget {
  SearchUIPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchUIPageState createState() => new _SearchUIPageState();
}

class _SearchUIPageState extends State<SearchUIPage> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                    new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 3.0, top: 3),
                    color: Colors.lightBlue,

                    child: ListTile(
//                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      title: Text('${items[index]}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}