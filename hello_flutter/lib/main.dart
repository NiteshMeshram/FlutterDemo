
import 'package:flutter/material.dart';
import 'package:hello_flutter/Screens/home.dart';
import 'package:hello_flutter/Screens/SearchUI.dart';

import 'package:hello_flutter/ListViewExample.dart';

import 'package:hello_flutter/PassingData.dart';

import 'package:hello_flutter/Provider.dart';

class AppState extends ValueNotifier {
  AppState(value) : super(value);
}
var appState = new AppState(0);



void main() => runApp(new MyApp());



//void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Provider(
      data: appState,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePageData(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


/*
void main() => runApp(new HelloFlutterApp());

class HelloFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hello Fletter App",
        home: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: topAppBar,

//          bottomNavigationBar: BottomAppBar(
//            child: test(),
//          ),
        body: MyHomePageData(title: 'Flutter Demo Home Page'), // MyHomePage(), //test(),
          //Home()
//          body: SearchUI(),
        )
    );
  }

  Widget test() {
    return new Container(
//      height: 230.0,
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(35.0),
                child: TabBar(
                  indicator: BoxDecoration(color: Colors.red),
                  labelStyle: TextStyle(color: Colors.white),
                  unselectedLabelColor: Colors.red,
                  tabs: <Widget>[
                    Tab(child: Text('Test - 1', style: TextStyle(fontSize: 18.0))),
                    Tab(child: Text('Test - 2', style: TextStyle(fontSize: 18.0))),
                  ],
                ),
              ),
            )));
  }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text("Hello World"),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );
}

*/



class MyHomePageData extends StatelessWidget {
  MyHomePageData({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var _counter = Provider.of(context).value;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _incrementCounter(context),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  _incrementCounter(context) {
    var appState = Provider.of(context);
    appState.value += 1;
  }
}



/*
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData.dark(),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File imageFile;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  static const baseUrl = 'http://localhost:3000/api/profile/photo';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Upload image'),
      ),
      body: new Column(
        children: <Widget>[
          _buildPreviewImage(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildPreviewImage() {
    return new Expanded(
      child: new Card(
        elevation: 3.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(
            new Radius.circular(4.0),
          ),
        ),
        child: new Stack(
          children: <Widget>[
            new Container(
              constraints: new BoxConstraints.expand(),
              child: imageFile == null
                  ? new Image.asset('assets/bg.png', colorBlendMode: BlendMode.darken, color: Colors.black26, fit: BoxFit.cover)
                  : new Image.file(imageFile, fit: BoxFit.cover),
            ),
            new Align(
              alignment: AlignmentDirectional.center,
              child: imageFile == null
                  ? new Text(
                'No selected image',
                style: Theme.of(context).textTheme.title,
              )
                  : new Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new IconButton(
            icon: Icon(Icons.camera),
            onPressed: _takePhoto,
            tooltip: 'Take photo',
          ),
          new IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: _uploadImage,
            tooltip: 'Upload image',
          ),
          new IconButton(
            icon: Icon(Icons.image),
            onPressed: _selectGalleryImage,
            tooltip: 'Select from gallery',
          ),
        ],
      ),
    );
  }

  _takePhoto() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  _showSnackbar(String text) => scaffoldKey.currentState?.showSnackBar(
    new SnackBar(
      content: new Text(text),
    ),
  );

  _uploadImage() async {
    if (imageFile == null) {
      return _showSnackbar('Please select image');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Center(
          child: new CircularProgressIndicator(),
        );
      },
      barrierDismissible: false,
    );

    try {
//      final url = Uri.parse('$baseUrl/upload');
      final url = Uri.parse('$baseUrl');
      final fileName = path.basename(imageFile.path);
      final bytes = await compute(compress, imageFile.readAsBytesSync());
      Map<String, String> header = {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJBZGFtLmpvZUBncHMuY29tIiwiaWF0IjoxNTU0ODkyMjg1fQ.-e-mMcSuxaQwrhKz1xdafv_r1_pZFGRkMrImCnn49PI'};

//      request.headers.contentType = new ContentType("image", "jpeg");

      print(imageFile);
      print(fileName);

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(header)
        ..files.add(
          new http.MultipartFile.fromBytes(
            'newProfilePicture',
            bytes,
            filename: fileName,
            contentType: MediaType('image', 'jpg'),
          ),
        );



      var response = await request.send();
      var decoded = await response.stream.bytesToString().then(json.decode);

      Navigator.pop(context);
      print('response==>');
      print(response.statusCode);
      print('Done==> $response.');
      if (response.statusCode == HttpStatus.OK) {
//        print(object)
        _showSnackbar('Image uploaded, imageUrl = $baseUrl/${decoded['path']}');
      } else {
        _showSnackbar('Image failed: ${decoded['message']}');
      }
    } catch (e) {
      Navigator.pop(context);
      _showSnackbar('Image failed: $e');
    }
  }

  _selectGalleryImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}

List<int> compress(List<int> bytes) {
  var image = img.decodeImage(bytes);
  var resize = img.copyResize(image, 480);
  return img.encodePng(resize, level: 1);
}

*/