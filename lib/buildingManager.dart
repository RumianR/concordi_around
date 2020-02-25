// Displays a list of all the buildings

import 'package:flutter/material.dart';

import './building.dart';

class DisplayBuildingListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DisplayBuildingList();
  }
}

class BuildingManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildingManagerState();
  }
}

class _BuildingManagerState extends State<BuildingManager> {
  bool _listVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        child: RaisedButton(
            child: Text("Building"),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _listVisible = (_listVisible ? false : true);
              });
            }));
  }
}

class DisplayBuildingList extends State<DisplayBuildingListManager> {
  final List<Building> _myBuildingList = new List<Building>();

  @override
  Widget build(BuildContext context) {
    _createBuildingList();
    return Expanded(
        flex: 8,
        child: Container(
            color: Colors.white,
            child: ListView(children: <Widget>[
              Text(_myBuildingList[0].toString()),
              Text("Item 2")
            ])));
  }

  void _createBuildingList() {
    _myBuildingList.clear();
    _myBuildingList
        .add(new Building("Henry F. Hall", "H", "none", "1455", "Maisonneuve"));
    _myBuildingList.add(new Building(
        "Engineering and Video", "EV", "none", "1495-1505", "Guy"));
  }
}
