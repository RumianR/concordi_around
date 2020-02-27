import 'dart:collection';
//  import 'package:latlong/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'dart:async';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

import 'Coordinate.dart';

part 'Vertex.jorm.dart';


class Vertex  extends LinkedListEntry<Vertex>{

  @PrimaryKey(auto: true)
  int id;

  String name;

  @HasOne(CoordinateBean)
  Coordinate point;

  Vertex({this.id, this.name, this.point});

  String toString() => "User($id, $name, $point)";

  bool operator ==(final other) {
    if (other is Vertex)
      return id == other.id && name == other.name && point == other.point;
    return false;
  }

  @override
  int get hashCode => super.hashCode;

}

@GenBean()
class VertexBean extends Bean<Vertex> with _VertexBean {
  VertexBean(Adapter adapter ) : super(adapter);


  String get tableName => 'oto_simple_user';
}