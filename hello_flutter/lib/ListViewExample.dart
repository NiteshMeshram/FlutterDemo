import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool showDetails = false;
  String title = 'Resources';

  List<Resource> resources = [
    new Resource('1', 'one', null),
    new Resource('2', 'two',
        [new Resource('Child', 'Child', null)]
    ),
    new Resource('3', 'three', null),
    new Resource('4', 'four',
        [
          new Resource('Child', 'Child', null),
          new Resource('Child', 'Child', null)
        ]),
    new Resource('5', 'five', null)
  ];

  List<Resource> currentSource;

  @override
  Widget build(BuildContext context) {
    if (!showDetails) {
      currentSource = resources;
    }

    Widget showResourcesList() {
      return new ListView.builder(
          itemCount: currentSource.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
                title: Center(
                  child: Text(currentSource[index].name),
                ),
                onTap: () {
                  setState(() {
                    if (currentSource[index].children != null) {
                      title = 'Children for ' + currentSource[index].name;
                      currentSource = resources[index].children;
                      showDetails = true;
                    }
                  });
                });
          });
    }

    Widget showBackButton() {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            showDetails = false;
            currentSource = resources;
            title = 'Resources';
          });
        },
      );
    }

    Widget showSettingsButton() {
      return IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(0, 113, 188, 1.0),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
          ),
        ),
        leading: showDetails ? showBackButton() : showSettingsButton(),
      ),
      body: showResourcesList(),
    );
  }
}

class Resource {
  String name;
  String description;

  List<Resource> children;

  Resource(this.name, this.description, this.children);
}
