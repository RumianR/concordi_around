// import 'dart:math';

// // import 'package:latlong/latlong.dart';
// import 'package:kdtree/kdtree.dart';
// import 'package:collection/collection.dart';
// import 'dart:collection';

// import 'package:concordi_around/Edge.dart';
// import 'package:concordi_around/Vertex.dart';
// import 'package:concordi_around/Graph.dart';
// import 'package:concordi_around/DijkstraAlgorithm.dart';





// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // void main() {

// //     List<LatLng> _products = pointsFromListMap(same);

// //   for (int i = 0; i < _products.length; i++) {
// //     print(_products[i].latitude.toString() +" "+ _products[i].longitude.toString());
// //   }

// //   // var lol = new Coordis().lineFromPoints(LatLng(45.49755, -73.57899), LatLng(45.49734, -73.57855));
// //   // print(lol[1].toString());
// // }


// class Coords {


//   List<Vertex> nodes = new List<Vertex>();
//   List<Edge> edges = new List<Edge>();
//   Map< String, LatLng> pts = {"A": LatLng(45.49719, -73.57933), "B":LatLng(45.49735, -73.57918), "C":LatLng(45.49735, -73.57918), "D": LatLng(45.49698, -73.57888)} ;
        




//         pts.forEach((k,v) => (
//           nodes.add(new Vertex("Node_" + k, "Node_" + k.toString(), v)))); 
        
        
       


       

//           void addLane(String laneId, int sourceLocNo, int destLocNo,
//             int duration) {
//         Edge lane = new Edge(laneId,nodes[sourceLocNo], nodes[destLocNo], duration );
//         edges.add(lane);
//     }
//         addLane("Edge_0", 0, 1, 5);
//         addLane("Edge_1", 0, 3, 8);

//         addLane("Edge_0", 1, 0, 5);
//         addLane("Edge_0", 1, 2, 5);
//         addLane("Edge_2", 2, 1, 4);

//         addLane("Edge_2", 3, 0, 4);


    

    
      

//         // Lets check from location Loc_1 to Loc_10
//         Graph graph = new Graph(nodes, edges);
//         DijkstraAlgorithm dijkstra = new DijkstraAlgorithm(graph);
//         dijkstra.execute(nodes[2]);
//         LinkedList<Vertex> path = dijkstra.getPath(nodes[3]);
//         var lst = path.toList().reversed;

      
// List<LatLng> getPath2(LatLng start, LatLng end){



// }











// List<LatLng> getPath(){
//   var points = 
//   new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49735, -73.57918)) + //AB
//   new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49698, -73.57888))+  //AF
//   new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.49755, -73.57899))+  //BC
//   new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.4972, -73.57887))  + //BX
//   new Coords().getPoints(LatLng(45.49755, -73.57899), LatLng(45.49741, -73.57868))+  //CY
//    new Coords().getPoints(LatLng(45.49741, -73.57868), LatLng(45.4972, -73.57887))+ //YX
//       new Coords().getPoints(LatLng(45.49741, -73.57868), LatLng(45.49734, -73.57855))+ //YD
//    new Coords().getPoints(LatLng(45.49734, -73.57855), LatLng(45.49714, -73.57875)) + // DE
//       new Coords().getPoints(LatLng(45.49714, -73.57875), LatLng(45.4972, -73.57887)) + // EX
//          new Coords().getPoints(LatLng(45.49714, -73.57875), LatLng(45.49698, -73.57888)); //EF


// points = points.toSet().toList();
// var distance = (a, b) {
//   return sqrt(pow(a['x'] - b['x'], 2) + pow(a['y'] - b['y'], 2));
// };

// var tree = KDTree(points, distance, ['x', 'y']);

// var nearest = tree.nearest({'x': 45.49719,  'y':  -73.57933}, 3);
// // var nearest = tree.nearest({'x': 45.49739,  'y':  -73.57914}, 3);

// // var nearest2 = tree.nearest({'x': 45.49741,  'y':   -73.57868}, 3);
// var nearest2 = tree.nearest({'x': 45.49729,  'y':  -73.5788}, 2);




// // print(nearest);
// // print(nearest2);



// Function eq = const MapEquality().equals;

// var same = nearest+nearest2;



// for(int i = 0; i< nearest.length; i++){
//   for(int j=0; j<nearest2.length; j++){
//     if(eq(nearest[i][0],nearest2[j][0])){
//       same.add(nearest[i]);
//     }
//   }
// }

// // print(same);

// return pointsFromListMap(same);
// }

// //get all points in straight line in between a and b
//   List<Map<String, double>> getPoints(LatLng a, LatLng b) {
//     List<LatLng> ret = [];
//     List<Map<String, double>> ret2 = [];
//     List<double> equation = lineFromPoints(a, b);

//     double interval = ((b.latitude - a.latitude) / 1);

//     double begin = a.latitude;
//     for (int i = 0; i <= 2; i++) {
//       var lat = begin;
//       var long = equation[0] * lat + equation[1];
//       ret.add(LatLng(lat, long));
//       ret2.add({'x': lat, 'y': long});
//       begin += interval;
//     }

//     return ret2;
//   }

// //y = mx + b from two points and returns list containing m and b
//   List<double> lineFromPoints(LatLng p1, LatLng p2) {
//     List<double> equation = [];
//     double deltaY = p2.longitude - p1.longitude;
//     double deltaX = p2.latitude - p1.latitude;
//     double m = deltaY / deltaX;
//     double b = p1.longitude - (m * p1.latitude);

//     equation.add(m);
//     equation.add(b);
//     return equation;
//   }


//   List<LatLng> pointsFromListMap(List<dynamic> list) {
//     List<LatLng> ret = [];
    
//     for (int i = 0; i <list.length; i++) {
//       ret.add(LatLng(list[i][0]['x'], list[i][0]['y']));
//     }

    

//     return ret;
//   }

// }
