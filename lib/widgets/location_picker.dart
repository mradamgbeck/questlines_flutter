// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:questlines/constants/icons.dart';
import 'package:questlines/constants/strings.dart';
import 'package:questlines/constants/values.dart';
import 'package:questlines/services/location.dart';
import 'package:questlines/services/sizes.dart';

class LocationPicker extends StatefulWidget {
  var locationCallback;

  LocationPicker(Null Function(LatLng latLng) callback, {super.key}) {
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
    return ClipRRect(
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
                  icon: RESET_LOCATION_ICON,
                  onPressed: () => {
                    mapController.moveAndRotate(location!, INITIAL_ZOOM, 0)
                  },
                ),
              ),
            ]),
    );
  }
}
