// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:questlines/constants.dart';
import 'package:questlines/services/location.dart';

class LocationPicker extends StatefulWidget {
  var locationCallback;

  LocationPicker(Null Function( dynamic latLng) callback,
      {super.key}) {
    locationCallback = callback;
  }

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? location;
  bool _isLoading = true;
  MapController mapController = MapController();
  Marker? playerMarker;
  List<Marker> markers = [];

  _LocationPickerState();
  @override
  void initState() {
    super.initState();
    setLocation();
  }

  setLocation() async {
    Position position = await getLocation();
    setState(() {
      location = LatLng(position.latitude, position.longitude);
      playerMarker = Marker(child: PLAYER_ICON, point: location!);
      markers.add(playerMarker!);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(fit: StackFit.expand, children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        onTap: (position, latLng) => {
                              setState(() => {
                                    if (markers.length > 1)
                                      {markers.removeLast()},
                                    markers.add(Marker(
                                        child: ACTIVE_STAGE_ICON,
                                        point: latLng)),
                                    widget.locationCallback(latLng)
                                  })
                            },
                        initialCenter: location!,
                        initialZoom: INITIAL_ZOOM),
                    children: [
                      TileLayer(
                          urlTemplate: MAP_TILE_URL,
                          userAgentPackageName: PACKAGE_NAME),
                      MarkerLayer(markers: markers)
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: IconButton(
                      icon: Icon(
                        Icons.adjust_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          {mapController.move(location!, INITIAL_ZOOM)},
                    ),
                  ),
                ]),
        ));
  }
}
