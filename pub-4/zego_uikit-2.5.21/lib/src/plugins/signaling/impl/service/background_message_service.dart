// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

/// @nodoc
mixin ZegoPluginBackgroundMessageService {
  Future<ZegoSignalingPluginSetBackgroundMessageHandlerResult>
  setBackgroundMessageHandler(
    ZegoSignalingPluginZPNsBackgroundMessageHandler handler,
  ) async {
    return ZegoPluginAdapter().signalingPlugin!.setBackgroundMessageHandler(
      handler,
    );
  }
}
