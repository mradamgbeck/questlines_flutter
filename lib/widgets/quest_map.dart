// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:questlines/constants/icons.dart';
import 'package:questlines/constants/strings.dart';
import 'package:questlines/constants/values.dart';
import 'package:questlines/services/location.dart';
import 'package:questlines/types/stage.dart';

class QuestMap extends StatefulWidget {
  List<Stage> stages;

  QuestMap(this.stages, {super.key});

  @override
  State<QuestMap> createState() => _QuestMapState();
}

class _QuestMapState extends State<QuestMap> {
  LatLng? location;
  bool _isLoading = true;
  Marker? playerMarker;
  MapController mapController = MapController();
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
      _isLoading = false;
    });
  }

  List<Marker> createMarkers() {
    var markerList = widget.stages
        .where((stage) => stage.hasLocation())
        .map((stage) => Marker(
            child: ACTIVE_STAGE_ICON,
            point: LatLng(stage.latitude!, stage.longitude!)))
        .toList();
    markerList.add(playerMarker!);
    return markerList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        initialCenter: location!,
                        initialZoom: INITIAL_ZOOM,
                        interactionOptions: InteractionOptions(
                            flags:
                                InteractiveFlag.all & ~InteractiveFlag.rotate)),
                    children: [
                      TileLayer(
                          urlTemplate: MAP_TILE_URL,
                          userAgentPackageName: PACKAGE_NAME),
                      MarkerLayer(
                          markers: widget.stages.isEmpty
                              ? [playerMarker!]
                              : createMarkers())
                    ],
                  ),
                  Positioned.fromRelativeRect(
                      rect: RelativeRect.fromLTRB(0, 450, 0, 0),
                      child: IconButton(
                        icon: RESET_LOCATION_ICON,
                        onPressed: () => {
                          mapController.moveAndRotate(
                              location!, INITIAL_ZOOM, 0)
                        },
                      )),
                ]),
        ));
  }
}
