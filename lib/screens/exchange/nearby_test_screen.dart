import 'dart:async';

import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

class NearbyExchangeService {
  final NearbyService _nearbyService = NearbyService();

  StreamSubscription<List<Device>>? _deviceSubscription;

  Future<void> start({
    required void Function(List<Device>) onDevicesChanged,
  }) async {
    await _nearbyService.init(
      serviceType: 'hakocha',
      strategy: Strategy.P2P_CLUSTER,
    );

    _deviceSubscription = _nearbyService.stateChangedSubscription(
      callback: (devices) {
        onDevicesChanged(devices);
      },
    );

    // 自分の端末を周囲から見つけられるようにする
    await _nearbyService.startAdvertisingPeer();

    // 周囲の端末を探す
    await _nearbyService.startBrowsingForPeers();
  }

  Future<void> stop() async {
    await _deviceSubscription?.cancel();

    _nearbyService.stopAdvertisingPeer();
    _nearbyService.stopBrowsingForPeers();
  }
}
