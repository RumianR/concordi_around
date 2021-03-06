import '../model/coordinate.dart';
import '../service/map_constant.dart';
import '../widget/search/main_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GotoPage extends StatefulWidget {
  final Position currentPosition;
  final Coordinate destination;
  final Function(List<Coordinate>) startPointAndDestinationCoordinates;
  final Function(DrivingMode) drivingMode;

  const GotoPage(this.currentPosition,
      {this.destination,
      this.startPointAndDestinationCoordinates,
      this.drivingMode});

  @override
  _GotoPageState createState() => _GotoPageState();
}

class _GotoPageState extends State<GotoPage> {

  //global key is needed to obtain the right scaffold for the warning snackbar
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Coordinate _startPoint;
  Coordinate _destination;
  List<bool> travelMode = [true, false, false, false, false];

  @override
  void initState() {
    super.initState();
    this._startPoint = Coordinate(widget.currentPosition.latitude,
        widget.currentPosition.longitude, '', "Your location", '');
    this._destination = widget.destination;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: <Widget>[
                          //This field is always "filled" by a value, default is current location
                          TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: this._startPoint == null
                                      ? Colors.grey
                                      : Colors.black),
                              hintText: (this._startPoint != null)
                                  ? this._startPoint.toString()
                                  : "Choose starting point",
                              icon: Icon(Icons.my_location),
                            ),
                            key: Key('Origin Field'),
                            readOnly: true,
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: PositionedFloatingSearchBar(
                                    coordinate: (Future<Coordinate> val) {
                                  setState(() async {
                                    this._startPoint = await val;
                                    //Used to force a second refresh of the view
                                    setState(() {});
                                  });
                                }),
                              );
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: this._destination == null
                                      ? Colors.grey
                                      : Colors.black),
                              hintText: (this._destination != null)
                                  ? this._destination.toString()
                                  : 'Choose destination',
                              icon: Icon(Icons.location_on),
                            ),
                            key: Key('Destination Field'),
                            readOnly: true,
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: PositionedFloatingSearchBar(
                                    coordinate: (Future<Coordinate> val) {
                                  setState(() async {
                                    this._destination = await val;
                                    //Used to force a second refresh of the view
                                    setState(() {});
                                  });
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.swap_vert),
                        onPressed: () {
                          setState(() {
                            var tmp = this._startPoint;
                            this._startPoint = this._destination;
                            this._destination = tmp;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(flex: 1, child: Container()),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: ToggleButtons(
                          selectedColor: Colors.white,
                          color: Colors.black,
                          fillColor: Colors.transparent,
                          renderBorder: false,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                                color: travelMode[0]
                                    ? COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_walk),
                              key: Key("walk"),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                                color: travelMode[1]
                                    ? COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_transit),
                              key: Key("transit"),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                                color: travelMode[2]
                                    ? COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.airport_shuttle),
                              key: Key("shuttle"),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                                color: travelMode[3]
                                    ? COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_bike),
                              key: Key("bike"),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS),
                                color: travelMode[4]
                                    ? COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_car),
                              key: Key("car"),
                            ),
                          ],
                          isSelected: travelMode,
                          onPressed: (int index) {
                            setState(() {
                              travelMode = [
                                false,
                                false,
                                false,
                                false,
                                false
                              ]; // Available modes are: [walking, transit, shuttle, bicycling, car] respectively
                              travelMode[index] = true;
                            });
                          }),
                    ),
                    //Add a flexible padding to the row
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: COLOR_CONCORDIA,
          foregroundColor: Colors.white,
          key: Key("go button"),
          child: Text("GO"),
          onPressed: () {
            if (this._destination != null &&
                this._startPoint != this._destination) {
              widget.drivingMode(getSelectedMode(
                  travelMode)); // This callback must occur first
              widget.startPointAndDestinationCoordinates(
                  List<Coordinate>.from([this._startPoint, this._destination]));
              Navigator.pop(context);
            } else {
              final _warningToast = SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                backgroundColor: COLOR_CONCORDIA,
                content: Text("Please enter a valid destination"),
              );
              /*
              removing previous snackbar if they exist so the warning 
              isn't queued up for a long time if the user triggers the warning
              multiple time in a row
              */
              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(_warningToast);
            }
          }),
    );
  }

  DrivingMode getSelectedMode(List<bool> modes) {
    if (modes[0] == true) {
      return DrivingMode.walking;
    } else if (modes[1] == true) {
      return DrivingMode.transit;
    } else if (modes[2] == true) {
      return DrivingMode.shuttle;
    } else if (modes[3] == true) {
      return DrivingMode.bicycling;
    }
    return DrivingMode.driving;
  }
}
