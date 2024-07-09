import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {super.key,
      this.controller,
      required this.center,
      this.zoom = 13,
      this.style = MapWidgetStyleMap.road,
      this.markers = const [],
      this.polygons = const [],
      this.circles = const [],
      this.onTap});

  final MapController? controller;
  final MapWidgetMarker center;
  final double zoom;
  final List<MapWidgetMarker> markers;
  final List<MapWidgetCircle> circles;
  final List<Polygon> polygons;
  final MapWidgetStyleMap style;
  final Function(TapPosition position, LatLng point)? onTap;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final double _minZoom = 0;
  final double _maxZoom = 22;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.controller,
      options: MapOptions(
        initialCenter: LatLng(widget.center.latitude, widget.center.longitude),
        initialZoom: widget.zoom,
        onTap: widget.onTap,
        minZoom: _minZoom,
        maxZoom: _maxZoom,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.google.com/vt/lyrs=${widget.style.layerGoogleCaracter()}&x={x}&y={y}&z={z}&apistyle={apistyle}',
          additionalOptions: const {'apistyle': 's.t:2|s.e:l|p.v:off'},
          subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
          minZoom: _minZoom,
          maxZoom: _maxZoom,
        ),
        PolygonLayer(polygons: widget.polygons),
        CircleLayer(
          circles: widget.circles
              .map((circle) => CircleMarker(
                  point: LatLng(circle.latitude, circle.longitude),
                  radius: circle.radius,
                  color: circle.color,
                  useRadiusInMeter: circle.useRadiusInMeter))
              .toList(),
        ),
        MarkerLayer(
          markers: widget.markers
              .map((e) => Marker(
                    width: e.width,
                    height: e.height,
                    point: LatLng(e.latitude, e.longitude),
                    child: e.child ?? Container(),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class MapWidgetMarker {
  final double longitude;
  final double latitude;
  final double width;
  final double height;
  final Widget? child;

  MapWidgetMarker(
      {required this.latitude,
      required this.longitude,
      this.width = 30,
      this.height = 30,
      this.child});
}

class MapWidgetCircle {
  final double longitude;
  final double latitude;
  final Color color;
  final double radius;
  final bool useRadiusInMeter;

  MapWidgetCircle(
      {required this.latitude,
      required this.longitude,
      required this.radius,
      this.color = Colors.red,
      this.useRadiusInMeter = false});
}

enum MapWidgetStyleMap {
  hybrid,
  satellite,
  road,
}

extension MapWidgetStyleMapExtension on MapWidgetStyleMap {
  String layerGoogleCaracter() {
    switch (this) {
      case MapWidgetStyleMap.hybrid:
        return "y";
      case MapWidgetStyleMap.road:
        return "m";
      case MapWidgetStyleMap.satellite:
        return "s";
    }
  }
}
