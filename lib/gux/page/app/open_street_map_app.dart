import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '/styles.dart' as styles;

class OpenStreetMapApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => OpenStreetMapAppState();

}

class OpenStreetMapAppState extends State<OpenStreetMapApp> {

  MapController _controller = MapController(
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west:  5.9559113,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('asset/image/logo/openstreetmap.png', width: 32, height: 32, fit: BoxFit.cover,),
      ),
      // body: Container(),
      body: OSMFlutter(
          controller: _controller,
          osmOption: OSMOption(
            userTrackingOption: UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: ZoomOption(
              initZoom: 8,
              minZoomLevel: 3,
              maxZoomLevel: 19,
              stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: RoadOption(
              roadColor: Colors.yellowAccent,
            ),
            // markerOption: MarkerOption(
            //     defaultMarker: MarkerIcon(
            //       icon: Icon(
            //         Icons.person_pin_circle,
            //         color: Colors.blue,
            //         size: 56,
            //       ),
            //     )
            // ),
          )
      ),
    );
  }
}