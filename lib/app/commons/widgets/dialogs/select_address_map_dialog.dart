import 'dart:async';

import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/commons/infra/repositories/tomtom_repository.dart';
import 'package:eatagain/app/commons/utils/map_client.dart';
import 'package:eatagain/app/commons/widgets/custom_card_with_icon.dart';
import 'package:eatagain/app/commons/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';
import 'package:melo_ui/melo_ui.dart';

class SelectAddressMapDialog extends StatefulWidget {
  const SelectAddressMapDialog(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<SelectAddressMapDialog> createState() => _SelectAddressMapDialogState();
}

class _SelectAddressMapDialogState extends State<SelectAddressMapDialog> {
  final _mapRepository = Modular.get<MapClient>();
  final MapController _mapController = MapController();
  late StreamSubscription _subscription;
  late LatLng _marker;
  AddressModel? _address;

  bool _isMoving = false;

  @override
  void initState() {
    super.initState();

    _marker = LatLng(widget.latitude, widget.longitude);
    _subscription = _mapController.mapEventStream.listen((MapEvent mapEvent) {
      if (mapEvent is MapEventMoveStart) {
        setState(() => _isMoving = true);
      }
      if (mapEvent is MapEventWithMove) {
        setState(() => _marker = LatLng(
            mapEvent.camera.center.latitude, mapEvent.camera.center.longitude));
      }
      if (mapEvent is MapEventMoveEnd) {
        setState(() {
          _isMoving = false;
          _marker = LatLng(mapEvent.camera.center.latitude,
              mapEvent.camera.center.longitude);
        });
        getAddressByGeopoint();
      }
    });
  }

  Future<void> getAddressByGeopoint() async {
    var response = await _mapRepository.getAddressByGeopoint(
        latitude: _marker.latitude, longitude: _marker.longitude);
    setState(() {
      _address = response;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      contentPadding:
          const EdgeInsets.only(top: 0, right: 40, left: 40, bottom: 40),
      actionsPadding:
          const EdgeInsets.only(top: 8, right: 40, left: 40, bottom: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      actionsAlignment: MainAxisAlignment.center,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const MeloUIText(
          'Selecione o endereço no mapa (Mova ou clique no mapa)',
        ),
        IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: const Icon(Icons.close))
      ]),
      content: SizedBox(
        width: 600,
        height: 600,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MapWidget(
                    zoom: 15,
                    onTap: (position, point) {
                      setState(() {
                        _marker = LatLng(point.latitude, point.longitude);
                      });
                      getAddressByGeopoint();
                    },
                    controller: _mapController,
                    markers: [
                      MapWidgetMarker(
                          latitude: _marker.latitude,
                          longitude: _marker.longitude,
                          width: 80,
                          height: 80,
                          child: Stack(
                            children: _isMoving
                                ? [
                                    const Positioned(
                                        bottom: 24,
                                        child: Icon(Icons.location_on,
                                            size: 60.0, color: Colors.black)),
                                    Positioned(
                                        bottom: 22,
                                        left: 17,
                                        child: Container(
                                          width: 24,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(24, 4)),
                                          ),
                                        ))
                                  ]
                                : [
                                    Icon(Icons.location_on,
                                        size: 60.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    Positioned(
                                        bottom: 22,
                                        left: 17,
                                        child: Container(
                                          width: 24,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(24, 4)),
                                          ),
                                        ))
                                  ],
                          ))
                    ],
                    center: MapWidgetMarker(
                        latitude: widget.latitude,
                        longitude: widget.longitude)),
              )),
              const SizedBox(
                height: 16,
              ),
              if (_address != null)
                CustomCardWithIcon(
                  height: 140,
                  icon: Icons.place,
                  title: 'Endereço escolhido',
                  subTitle: _address!.formatted,
                  border: Border.all(color: Colors.grey),
                ),
              MeloUIButton(
                title: 'Confirmar',
                onPressed: () {
                  Modular.to.pop(_address);
                },
                isDisabled: _address == null,
                height: 56,
              )
            ]),
      ),
    );
  }
}
