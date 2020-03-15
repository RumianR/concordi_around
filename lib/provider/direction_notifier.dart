import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:concordi_around/service/map_direction.dart';
import 'package:flutter/cupertino.dart';

import '../service/map_constant.dart';

class DirectionNotifier extends ChangeNotifier {
  bool showDirectionPanel = false;
  DrivingMode mode = DrivingMode.walking;
  Direction direction;

  void setShowDirectionPanel(bool visiblity) {
    showDirectionPanel = visiblity;
    notifyListeners();
  }

  void setDrivingMode(DrivingMode mode) {
    this.mode = mode;
    notifyListeners();
  }

  Direction getDirection() {
    return direction;
  }

  Future<Direction> navigateByName(String origin, String destination) async {
    MapDirection _mapDirection = MapDirection();
    direction = await _mapDirection.getDirection(
        origin, destination, mode.toString().replaceAll("DrivingMode.", ""));
    return direction;
  }

  Future<Direction> navigateByCoordinates(
      Coordinate originCoordinates, Coordinate destinationCoordinates) async {
    String originLatitude = originCoordinates.lat.toString();
    String originLongitude = originCoordinates.lng.toString();
    String destinationLatitude = destinationCoordinates.lat.toString();
    String destinationLongitude = destinationCoordinates.lng.toString();
    String origin = "$originLatitude,$originLongitude";
    String destination = "$destinationLatitude,$destinationLongitude";

    return navigateByName(origin, destination);
  }

  String getDuration() {
    String duration = "0 min";
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          duration = leg.duration.text;
        }
      }
    }
    return duration;
  }

  String getDistance() {
    String distance = "0 km";
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          distance = leg.distance.text;
        }
      }
    }
    return distance;
  }

  List<String> getStepDirections() {
    List<String> directions = List();
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          for (Steps step in leg.steps) {
            directions.add(step.htmlInstructions
                .replaceAll("<b>", "")
                .replaceAll("</b>", "")
                .replaceAll("<b>", "")
                .replaceAll("/<wbr/>", " "));
          }
        }
      }
    }
    return directions;
  }
}
