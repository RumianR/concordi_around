import 'dart:collection';

import 'package:jaguar_orm/jaguar_orm.dart';

import 'coordinate.dart';
import 'floor.dart';
import 'path.dart';
import 'package:jaguar_query/jaguar_query.dart';


part 'building.jorm.dart';

class Building {
  

  List<Coordinate> _polygon; //A polygon includes a duplicated point for google maps
  @PrimaryKey()
  String _building;
  Map<String, Floor> _floors = HashMap<String, Floor>();


  Building({building, polygon}){
    _building = building;
    _polygon = polygon;
  }

  @HasMany(CoordinateBean)
  List<Coordinate> get polygon => _polygon;

  @HasMany(FloorBean)
  Map<String,Floor> get floors => _floors;

  set floors(Map<String, Floor> floors) => _floors = floors;

  void addFloor(Floor floor) {
    _floors[floor.floor] = floor;
  }

  //Would template method apply here to improve extensibility?
  //May set disability to true using optional named parameter
  //spans at most 2 floors per building
  Map<String, Path> shortestPath(Coordinate s, Coordinate d, {bool isDisabilityFriendly = false}) {
    assert (s != null && d != null);
    var indoorNavigationMap = LinkedHashMap<String, Path>();
    var sFloor = _floors[s.floor];
    var dFloor = _floors[d.floor];
    if(sFloor.floor == dFloor.floor) {
      indoorNavigationMap[s.floor] = sFloor.shortestPath(s, d);
      return indoorNavigationMap;
    }
    //How should I get the closest exit/entry coordinates in a
    // more efficient method than below? KTree/Graph method maybe?
    //Get all valid exits
    var exits = sFloor.validExitCoordinates(d.floor, isDisabilityFriendly: isDisabilityFriendly);
    //Get all paths to the exits found
    var exitPaths = <Path>[];
    for (var exit in exits) {
      if (s == exit) {
        exitPaths.add(Path(<Coordinate>[s, exit]));
      }
      exitPaths.add(sFloor.shortestPath(s, exit));
    }
    //Get the shortest of all the paths found
    var shortestExitPath = exitPaths[0];
    for (var exitPath in exitPaths) {
      if (exitPath.length() < shortestExitPath.length()) {
        shortestExitPath = exitPath;
      }
    }
    indoorNavigationMap[s.floor] = shortestExitPath;
    //Find the coordinate of the destination floor from the exit found
    var sExitAdjacentExitCoordinates = shortestExitPath.segments.last.destination.adjCoordinates;
    var dEntry;
    for (var sExitAdjacentCoordinate in sExitAdjacentExitCoordinates) {
      if (sExitAdjacentCoordinate.floor == dFloor.floor) {
        dEntry = sExitAdjacentCoordinate;
      }
    }
    indoorNavigationMap[d.floor] = dFloor.shortestPath(dEntry, d);
    return indoorNavigationMap;
  }
}

@GenBean()
class BuildingBean extends Bean<Building> with _BuildingBean {
  //CampusBean

  final String tableName = 'buildings';
  BuildingBean(Adapter adapter) : super(adapter);
}