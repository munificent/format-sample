// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:wakelock/wakelock.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit/src/services/services.dart';

// import 'dart:html';

part 'zego_uikit_core_data.dart';

// Project imports:
part 'zego_uikit_core_defines.dart';

part 'zego_uikit_core_event.dart';

part 'zego_uikit_core_message.dart';

/// @nodoc
class ZegoUIKitCore with ZegoUIKitCoreEvent {
  ZegoUIKitCore._internal();

  static final ZegoUIKitCore shared = ZegoUIKitCore._internal();

  final ZegoUIKitCoreData coreData = ZegoUIKitCoreData();
  final ZegoUIKitCoreMessage coreMessage = ZegoUIKitCoreMessage();

  bool isInit = false;
  bool isNeedDisableWakelock = false;
  List<StreamSubscription<dynamic>?> subscriptions = [];

  Future<String> getZegoUIKitVersion() async {
    final expressVersion = await ZegoExpressEngine.getVersion();
    const zegoUIKitVersion = 'zego_uikit:2.5.21; ';
    return '${zegoUIKitVersion}zego_express:$expressVersion';
  }

  Future<void> init({
    required int appID,
    String appSign = '',
    ZegoScenario scenario = ZegoScenario.Default,
  }) async {
    if (isInit) {
      ZegoLoggerService.logWarn('core had init', tag: 'uikit', subTag: 'core');
      return;
    }

    isInit = true;

    final profile = ZegoEngineProfile(appID, scenario, appSign: appSign);
    initEventHandle();

    ZegoLoggerService.logInfo(
      'create engine with profile',
      tag: 'uikit',
      subTag: 'core',
    );
    await ZegoExpressEngine.createEngineWithProfile(profile);

    ZegoLoggerService.logInfo(
      'get network time info',
      tag: 'uikit',
      subTag: 'core',
    );
    await ZegoExpressEngine.instance.getNetworkTimeInfo().then((timeInfo) {
      coreData.initNetworkTimestamp(timeInfo.timestamp);

      ZegoLoggerService.logInfo(
        'network time info is init, timestamp:${timeInfo.timestamp}, max deviation:${timeInfo.maxDeviation}',
        tag: 'uikit',
        subTag: 'core',
      );
    });

    ZegoExpressEngine.setEngineConfig(ZegoEngineConfig(
      advancedConfig: {
        'notify_remote_device_unknown_status': 'true',
        'notify_remote_device_init_status': 'true',
        'keep_audio_session_active': 'true',
      },
    ));

    final initAudioRoute = await ZegoExpressEngine.instance.getAudioRouteType();
    coreData.localUser.audioRoute.value = initAudioRoute;
    coreData.localUser.lastAudioRoute = initAudioRoute;

    subscriptions.add(coreData.customCommandReceivedStreamCtrl.stream.listen(
      onInternalCustomCommandReceived,
    ));
  }

  Future<void> uninit() async {
    if (!isInit) {
      ZegoLoggerService.logWarn(
        'core is not init',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    isInit = false;

    uninitEventHandle();
    clear();

    for (final subscription in subscriptions) {
      subscription?.cancel();
    }

    await ZegoExpressEngine.destroyEngine();
  }

  void clear() {
    coreData.clear();
    coreMessage.clear();
  }

  @override
  void uninitEventHandle() {}

  int getNetworkTimeStamp() {
    return coreData.networkDateTime.millisecondsSinceEpoch;
  }

  void login(String id, String name) {
    coreData.login(id, name);
  }

  void logout() {
    coreData.logout();
  }

  Future<ZegoRoomLoginResult> joinRoom(
    String roomID, {
    bool markAsLargeRoom = false,
  }) async {
    ZegoLoggerService.logInfo(
      'join room, room id:"$roomID", markAsLargeRoom:$markAsLargeRoom',
      tag: 'uikit',
      subTag: 'core',
    );

    clear();
    coreData.setRoom(roomID, markAsLargeRoom: markAsLargeRoom);

    final originWakelockEnabledF = Wakelock.enabled;

    final joinRoomResult = await ZegoExpressEngine.instance.loginRoom(
      roomID,
      coreData.localUser.toZegoUser(),
      config: ZegoRoomConfig(0, true, ''),
    );
    ZegoLoggerService.logInfo(
      'join room result: ${joinRoomResult.errorCode} ${joinRoomResult.extendedData}',
      tag: 'uikit',
      subTag: 'core',
    );

    if (joinRoomResult.errorCode == 0) {
      coreData.startPublishOrNot();
      syncDeviceStatusByStreamExtraInfo();

      final originWakelockEnabled = await originWakelockEnabledF;
      if (originWakelockEnabled) {
        isNeedDisableWakelock = false;
      } else {
        isNeedDisableWakelock = true;
        Wakelock.enable();
      }

      ZegoExpressEngine.instance.startSoundLevelMonitor();
    } else if (joinRoomResult.errorCode == ZegoErrorCode.RoomCountExceed) {
      ZegoLoggerService.logInfo(
        'room count exceed',
        tag: 'uikit',
        subTag: 'core',
      );

      await leaveRoom();
      return joinRoom(roomID);
    } else {
      ZegoLoggerService.logInfo(
        'joinRoom failed: ${joinRoomResult.errorCode}, ${joinRoomResult.extendedData}',
        tag: 'uikit',
        subTag: 'core',
      );
    }

    return joinRoomResult;
  }

  Future<ZegoRoomLogoutResult> leaveRoom() async {
    ZegoLoggerService.logInfo('leave room', tag: 'uikit', subTag: 'core');

    if (isNeedDisableWakelock) {
      Wakelock.disable();
    }

    clear();

    await ZegoExpressEngine.instance.stopSoundLevelMonitor();

    final leaveResult = await ZegoExpressEngine.instance.logoutRoom();
    if (leaveResult.errorCode != 0) {
      ZegoLoggerService.logInfo(
        'leaveRoom failed: ${leaveResult.errorCode}, ${leaveResult.extendedData}',
        tag: 'uikit',
        subTag: 'core',
      );
    }

    return leaveResult;
  }

  Future<bool> removeUserFromRoom(List<String> userIDs) async {
    ZegoLoggerService.logInfo(
      'remove users from room:$userIDs',
      tag: 'uikit',
      subTag: 'core',
    );

    if (ZegoUIKitCore.shared.coreData.room.isLargeRoom ||
        ZegoUIKitCore.shared.coreData.room.markAsLargeRoom) {
      ZegoLoggerService.logInfo(
        'remove all users, because is a large room',
        tag: 'uikit',
        subTag: 'core',
      );
      return ZegoUIKitCore.shared.sendInRoomCommand(const JsonEncoder()
          .convert({removeUserInRoomCommandKey: userIDs}), []);
    } else {
      return ZegoUIKitCore.shared.sendInRoomCommand(const JsonEncoder()
          .convert({removeUserInRoomCommandKey: userIDs}), userIDs);
    }
  }

  Future<bool> setRoomProperty(String key, String value) async {
    return ZegoUIKitCore.shared.updateRoomProperties({key: value});
  }

  Future<bool> updateRoomProperties(Map<String, String> properties) async {
    ZegoLoggerService.logInfo(
      'set room property: $properties',
      tag: 'uikit',
      subTag: 'core',
    );

    if (coreData.room.propertiesAPIRequesting) {
      properties.forEach((key, value) {
        coreData.room.pendingProperties[key] = value;
      });
      ZegoLoggerService.logInfo(
        'room property is updating, pending: ${coreData.room.pendingProperties}',
        tag: 'uikit',
        subTag: 'core',
      );
      return false;
    }

    if (!isInit) {
      ZegoLoggerService.logError(
        'core had not init',
        tag: 'uikit',
        subTag: 'core',
      );
      return false;
    }

    if (coreData.room.id.isEmpty) {
      ZegoLoggerService.logError(
        'room is not login',
        tag: 'uikit',
        subTag: 'core',
      );
      return false;
    }

    final localUser = ZegoUIKit().getLocalUser();

    var isAllPropertiesSame = coreData.room.properties.isNotEmpty;
    properties.forEach((key, value) {
      if (coreData.room.properties.containsKey(key) &&
          coreData.room.properties[key]!.value == value) {
        ZegoLoggerService.logInfo(
          'key exist and value is same, ${coreData.room.properties}',
          tag: 'uikit',
          subTag: 'core',
        );
        isAllPropertiesSame = false;
      }
    });
    if (isAllPropertiesSame) {
      ZegoLoggerService.logInfo(
        'all key exist and value is same',
        tag: 'uikit',
        subTag: 'core',
      );
      // return true;
    }

    final oldProperties = <String, RoomProperty?>{};
    properties
      ..forEach((key, value) {
        if (coreData.room.properties.containsKey(key)) {
          oldProperties[key] = RoomProperty.copyFrom(
            coreData.room.properties[key]!,
          );
          oldProperties[key]!.updateUserID = localUser.id;
        }
      })

      /// local update
      ..forEach((key, value) {
        if (coreData.room.properties.containsKey(key)) {
          coreData.room.properties[key]!.oldValue =
              coreData.room.properties[key]!.value;
          coreData.room.properties[key]!.value = value;
          coreData.room.properties[key]!.updateTime =
              coreData.networkDateTime.millisecondsSinceEpoch;
          coreData.room.properties[key]!.updateFromRemote = false;
        } else {
          coreData.room.properties[key] = RoomProperty(
            key,
            value,
            coreData.networkDateTime.millisecondsSinceEpoch,
            localUser.id,
            false,
          );
        }
      });

    /// server update
    final extraInfoMap = <String, String>{};
    coreData.room.properties.forEach((key, value) {
      extraInfoMap[key] = value.value;
    });
    final extraInfo = const JsonEncoder().convert(extraInfoMap);
    // if (extraInfo.length > 128) {
    //   ZegoLoggerService.logInfo("value length out of limit");
    //   return false;
    // }
    ZegoLoggerService.logInfo(
      'call set room extra info, $extraInfo',
      tag: 'uikit',
      subTag: 'core',
    );

    ZegoLoggerService.logInfo(
      'call setRoomExtraInfo',
      tag: 'uikit',
      subTag: 'core',
    );
    coreData.room.propertiesAPIRequesting = true;
    return ZegoExpressEngine.instance
        .setRoomExtraInfo(coreData.room.id, 'extra_info', extraInfo)
        .then((ZegoRoomSetRoomExtraInfoResult result) {
          ZegoLoggerService.logInfo(
            'setRoomExtraInfo finished',
            tag: 'uikit',
            subTag: 'core',
          );
          if (0 == result.errorCode) {
            properties.forEach((key, value) {
              final updatedProperty = coreData.room.properties[key]!
                ..updateFromRemote = true;
              coreData.room.propertyUpdateStream.add(updatedProperty);
              coreData.room.propertiesUpdatedStream.add({key: updatedProperty});
            });
          } else {
            properties.forEach((key, value) {
              if (coreData.room.properties.containsKey(key)) {
                coreData.room.properties[key]!.copyFrom(oldProperties[key]!);
              }
            });
            ZegoLoggerService.logError(
              'fail to set room properties:$properties! error code:${result.errorCode}',
              tag: 'uikit',
              subTag: 'core',
            );
          }

          coreData.room.propertiesAPIRequesting = false;
          if (coreData.room.pendingProperties.isNotEmpty) {
            final pendingProperties = Map<String, String>.from(
              coreData.room.pendingProperties,
            );
            coreData.room.pendingProperties.clear();
            ZegoLoggerService.logInfo(
              'update pending properties:$pendingProperties',
              tag: 'uikit',
              subTag: 'core',
            );
            updateRoomProperties(pendingProperties);
          }

          return 0 != result.errorCode;
        });
  }

  Future<bool> sendInRoomCommand(String command, List<String> toUserIDs) async {
    ZegoLoggerService.logInfo(
      'send in-room command:$command to $toUserIDs',
      tag: 'uikit',
      subTag: 'core',
    );

    return ZegoExpressEngine.instance
        .sendCustomCommand(
          coreData.room.id,
          command,
          toUserIDs.isEmpty
              // empty mean send to all users
                ? coreData.remoteUsersList.map(
                  (ZegoUIKitCoreUser user) => ZegoUser(user.id, user.name),
                ).toList()
              : toUserIDs.map(
                  (String userID) => coreData.remoteUsersList.firstWhere(
                    (element) => element.id == userID,
                    orElse: ZegoUIKitCoreUser.empty,
                  ).toZegoUser(),
                ).toList(),
        )
        .then((ZegoIMSendCustomCommandResult result) {
          ZegoLoggerService.logInfo(
            'send custom command result, code:${result.errorCode}',
            tag: 'uikit',
            subTag: 'core',
          );

          return 0 == result.errorCode;
        });
  }

  void useFrontFacingCamera(bool isFrontFacing) {
    if (isFrontFacing == coreData.localUser.isFrontFacing.value) {
      return;
    }

    ZegoExpressEngine.instance.useFrontCamera(isFrontFacing);
    coreData.localUser.isFrontFacing.value = isFrontFacing;

    ZegoExpressEngine.instance.setVideoMirrorMode(
      isFrontFacing
          ? (coreData.localUser.isVideoMirror.value
                ? ZegoVideoMirrorMode.BothMirror
                : ZegoVideoMirrorMode.NoMirror)
          : ZegoVideoMirrorMode.NoMirror,
    );
  }

  void enableVideoMirroring(bool isVideoMirror) {
    coreData.localUser.isVideoMirror.value = isVideoMirror;

    ZegoExpressEngine.instance.setVideoMirrorMode(
      isVideoMirror
          ? ZegoVideoMirrorMode.BothMirror
          : ZegoVideoMirrorMode.NoMirror,
    );
  }

  void setAudioVideoResourceMode(ZegoAudioVideoResourceMode mode) {
    coreData.playResourceMode = mode;

    ZegoLoggerService.logInfo(
      'set audio video resource mode: $mode',
      tag: 'uikit',
      subTag: 'core',
    );
  }

  void startPlayAllAudioVideo() {
    coreData.muteAllPlayStreamAudioVideo(false);
  }

  void stopPlayAllAudioVideo() {
    coreData.muteAllPlayStreamAudioVideo(true);
  }

  void muteUserAudioVideo(String userID, bool mute) {
    coreData.muteUserAudioVideo(userID, mute);
  }

  void setAudioOutputToSpeaker(bool useSpeaker) {
    if (!isInit) {
      ZegoLoggerService.logError(
        'set audio output to speaker, core had not init',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    if (useSpeaker ==
        (coreData.localUser.audioRoute.value == ZegoAudioRoute.Speaker)) {
      return;
    }

    ZegoExpressEngine.instance.setAudioRouteToSpeaker(useSpeaker);

    // TODO: use sdk callback to update audioRoute
    if (useSpeaker) {
      coreData.localUser.lastAudioRoute = coreData.localUser.audioRoute.value;
      coreData.localUser.audioRoute.value = ZegoAudioRoute.Speaker;
    } else {
      coreData.localUser.audioRoute.value = coreData.localUser.lastAudioRoute;
    }
  }

  void turnCameraOn(String userID, bool isOn) {
    ZegoLoggerService.logInfo(
      "turn ${isOn ? "on" : "off"} $userID camera",
      tag: 'uikit',
      subTag: 'core',
    );

    if (coreData.localUser.id == userID) {
      turnOnLocalCamera(isOn);
    } else {
      final isLargeRoom =
          coreData.room.isLargeRoom || coreData.room.markAsLargeRoom;
      ZegoLoggerService.logInfo(
        'is large room:$isLargeRoom',
        tag: 'uikit',
        subTag: 'core',
      );

      if (isOn) {
        sendInRoomCommand(const JsonEncoder().convert({
          turnCameraOnInRoomCommandKey: userID,
        }), isLargeRoom ? [] : [userID]);
      } else {
        sendInRoomCommand(const JsonEncoder().convert({
          turnCameraOffInRoomCommandKey: userID,
        }), isLargeRoom ? [] : [userID]);
      }
    }
  }

  void turnOnLocalCamera(bool isOn) {
    ZegoLoggerService.logInfo(
      "turn ${isOn ? "on" : "off"} local camera",
      tag: 'uikit',
      subTag: 'core',
    );

    if (!isInit) {
      ZegoLoggerService.logError(
        'turn on local camera, core had not init',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    if (isOn == coreData.localUser.camera.value) {
      ZegoLoggerService.logInfo(
        'turn on local camera, value is equal',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    if (isOn) {
      coreData.startPreview();
    } else {
      coreData.stopPreview();
    }

    ZegoExpressEngine.instance.enableCamera(isOn);

    coreData.localUser.camera.value = isOn;

    coreData.startPublishOrNot();

    syncDeviceStatusByStreamExtraInfo();
  }

  void turnMicrophoneOn(String userID, bool isOn, {bool muteMode = false}) {
    ZegoLoggerService.logInfo(
      "turn ${isOn ? "on" : "off"} $userID microphone, muteMode:$muteMode",
      tag: 'uikit',
      subTag: 'core',
    );

    if (coreData.localUser.id == userID) {
      turnOnLocalMicrophone(isOn, muteMode: muteMode);
    } else {
      final isLargeRoom =
          coreData.room.isLargeRoom || coreData.room.markAsLargeRoom;
      ZegoLoggerService.logInfo(
        'is large room:$isLargeRoom',
        tag: 'uikit',
        subTag: 'core',
      );

      if (isOn) {
        sendInRoomCommand(const JsonEncoder().convert({
          turnMicrophoneOnInRoomCommandKey: userID,
        }), isLargeRoom ? [userID] : []);
      } else {
        sendInRoomCommand(const JsonEncoder().convert({
          turnMicrophoneOffInRoomCommandKey: userID,
        }), isLargeRoom ? [userID] : []);
      }
    }
  }

  void turnOnLocalMicrophone(bool isOn, {bool muteMode = false}) {
    ZegoLoggerService.logInfo(
      "turn ${isOn ? "on" : "off"} local microphone${muteMode ? ', muteMode:$muteMode' : ''}",
      tag: 'uikit',
      subTag: 'core',
    );

    if (!isInit) {
      ZegoLoggerService.logError(
        'turn ${isOn ? "on" : "off"} local microphone, core had not init',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    if ((isOn == coreData.localUser.microphone.value) &&
        (muteMode == coreData.localUser.microphoneMuteMode.value)) {
      ZegoLoggerService.logInfo(
        'turn ${isOn ? "on" : "off"} local microphone, value is equal isOn:$isOn, muteMode:$muteMode',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    if (isOn) {
      ZegoExpressEngine.instance.muteMicrophone(false);
      ZegoExpressEngine.instance.mutePublishStreamAudio(false);
      coreData.localUser.microphoneMuteMode.value = false;
    } else {
      if (muteMode) {
        ZegoExpressEngine.instance.muteMicrophone(false);
        ZegoExpressEngine.instance.mutePublishStreamAudio(true);
        coreData.localUser.microphoneMuteMode.value = true;

        /// local sound level should be mute too
        coreData.localUser.soundLevel.add(0.0);
      } else {
        ZegoExpressEngine.instance.muteMicrophone(true);
        ZegoExpressEngine.instance.mutePublishStreamAudio(false);
        coreData.localUser.microphoneMuteMode.value = false;
      }
    }

    coreData.localUser.microphone.value = isOn;
    coreData.startPublishOrNot();

    syncDeviceStatusByStreamExtraInfo();
  }

  void syncDeviceStatusByStreamExtraInfo() {
    // sync device status via stream extra info
    final streamExtraInfo = <String, dynamic>{
      streamExtraInfoCameraKey: coreData.localUser.camera.value,
      streamExtraInfoMicrophoneKey: coreData.localUser.microphone.value,
    };

    final extraInfo = jsonEncode(streamExtraInfo);
    ZegoExpressEngine.instance.setStreamExtraInfo(extraInfo);
    syncDeviceStatusByMixerSEI();
  }

  void syncDeviceStatusByMixerSEI() {
    final seiMap = <String, dynamic>{
      streamSEIKeyCamera: coreData.localUser.camera.value,
      streamSEIKeyMicrophone: coreData.localUser.microphone.value,
    };
    coreData.sendSEI(ZegoUIKitInnerSEIType.zegoMixerDeviceState.name, seiMap);
  }

  void updateTextureRendererOrientation(Orientation orientation) {
    switch (orientation) {
      case Orientation.portrait:
        ZegoExpressEngine.instance.setAppOrientation(
          DeviceOrientation.portraitUp,
        );
        break;
      case Orientation.landscape:
        ZegoExpressEngine.instance.setAppOrientation(
          DeviceOrientation.landscapeLeft,
        );
        break;
    }
  }

  void setVideoConfig(ZegoVideoConfig config) {
    ZegoExpressEngine.instance.setVideoConfig(config);
    coreData.localUser.viewSize.value = Size(
      config.captureWidth.toDouble(),
      config.captureHeight.toDouble(),
    );
  }

  void setInternalVideoConfig(ZegoUIKitVideoConfig config) {
    if (coreData.pushVideoConfig.needUpdateVideoConfig(config)) {
      final zegoVideoConfig = config.toZegoVideoConfig();
      ZegoExpressEngine.instance.setVideoConfig(zegoVideoConfig);
      coreData.localUser.viewSize.value = Size(
        zegoVideoConfig.captureWidth.toDouble(),
        zegoVideoConfig.captureHeight.toDouble(),
      );
    }
    if (coreData.pushVideoConfig.needUpdateOrientation(config)) {
      ZegoExpressEngine.instance.setAppOrientation(config.orientation);
    }

    coreData.pushVideoConfig = config;
  }

  void updateAppOrientation(DeviceOrientation orientation) {
    if (coreData.pushVideoConfig.orientation == orientation) {
      ZegoLoggerService.logInfo(
        'app orientation is equal',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    } else {
      ZegoLoggerService.logInfo(
        'update app orientation:$orientation',
        tag: 'uikit',
        subTag: 'core',
      );

      setInternalVideoConfig(
        coreData.pushVideoConfig.copyWith(orientation: orientation),
      );
    }
  }

  void setVideoConfigByPreset(ZegoPresetResolution resolution) {
    if (coreData.pushVideoConfig.resolution == resolution) {
      ZegoLoggerService.logInfo(
        'video config preset is equal',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    } else {
      ZegoLoggerService.logInfo(
        'update video config preset:$resolution',
        tag: 'uikit',
        subTag: 'core',
      );

      setInternalVideoConfig(
        coreData.pushVideoConfig.copyWith(resolution: resolution),
      );
    }
  }

  void updateVideoViewMode(bool useVideoViewAspectFill) {
    if (coreData.pushVideoConfig.useVideoViewAspectFill ==
        useVideoViewAspectFill) {
      ZegoLoggerService.logInfo(
        'video view mode is equal',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    } else {
      coreData.pushVideoConfig.useVideoViewAspectFill = useVideoViewAspectFill;
      // TODO: need re preview, and re playStream
    }
  }

  void onInternalCustomCommandReceived(
    ZegoInRoomCommandReceivedData commandData,
  ) {
    dynamic commandJson;
    try {
      commandJson = jsonDecode(commandData.command);
    } catch (e) {
      ZegoLoggerService.logInfo(
        'custom command is not a json, $e',
        tag: 'uikit',
        subTag: 'core',
      );
    }

    if (commandJson is! Map<String, dynamic>) {
      ZegoLoggerService.logInfo(
        'custom command is not a map',
        tag: 'uikit',
        subTag: 'core',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'on map custom command received, from user:${commandData.fromUser}, command:${commandData.command}',
      tag: 'uikit',
      subTag: 'core',
    );

    final extraInfos = Map.from(commandJson);
    if (extraInfos.keys.contains(removeUserInRoomCommandKey) &&
        (extraInfos[removeUserInRoomCommandKey]! as List<dynamic>).contains(
          coreData.localUser.id,
        )) {
      ZegoLoggerService.logInfo(
        'local user had been remove by ${commandData.fromUser.id}, auto leave room',
        tag: 'uikit',
        subTag: 'core',
      );
      leaveRoom();

      coreData.meRemovedFromRoomStreamCtrl.add(commandData.fromUser.id);
    } else if (extraInfos.keys.contains(turnCameraOnInRoomCommandKey) &&
        extraInfos[turnCameraOnInRoomCommandKey]!.toString() ==
            coreData.localUser.id) {
      ZegoLoggerService.logInfo(
        'local camera request turn on by ${commandData.fromUser}',
        tag: 'uikit',
        subTag: 'core',
      );
      coreData.turnOnYourCameraRequestStreamCtrl.add(commandData.fromUser.id);
    } else if (extraInfos.keys.contains(turnCameraOffInRoomCommandKey) &&
        extraInfos[turnCameraOffInRoomCommandKey]!.toString() ==
            coreData.localUser.id) {
      ZegoLoggerService.logInfo(
        'local camera request turn off by ${commandData.fromUser}',
        tag: 'uikit',
        subTag: 'core',
      );
      turnCameraOn(coreData.localUser.id, false);
    } else if (extraInfos.keys.contains(turnMicrophoneOnInRoomCommandKey) &&
        extraInfos[turnMicrophoneOnInRoomCommandKey]!.toString() ==
            coreData.localUser.id) {
      ZegoLoggerService.logInfo(
        'local microphone request turn on by ${commandData.fromUser}',
        tag: 'uikit',
        subTag: 'core',
      );
      coreData.turnOnYourMicrophoneRequestStreamCtrl.add(
        commandData.fromUser.id,
      );
    } else if (extraInfos.keys.contains(turnMicrophoneOffInRoomCommandKey) &&
        extraInfos[turnMicrophoneOffInRoomCommandKey]!.toString() ==
            coreData.localUser.id) {
      ZegoLoggerService.logInfo(
        'local microphone request turn off by ${commandData.fromUser}',
        tag: 'uikit',
        subTag: 'core',
      );
      turnMicrophoneOn(coreData.localUser.id, false);
    }
  }

  void enableCustomVideoProcessing(
    bool enable,
    ZegoCustomVideoProcessConfig config,
  ) {
    ZegoLoggerService.logInfo(
      '${enable ? "enable" : "disable"} custom video processing, buffer type:${config.bufferType}',
      tag: 'uikit',
      subTag: 'core',
    );

    ZegoExpressEngine.instance.enableCustomVideoProcessing(enable, config);
  }
}

extension ZegoUIKitCoreBaseBeauty on ZegoUIKitCore {
  Future<void> enableBeauty(bool isOn) async {
    ZegoLoggerService.logInfo(
      '${isOn ? "enable" : "disable"} beauty',
      tag: 'uikit',
      subTag: 'core',
    );

    ZegoExpressEngine.instance.enableEffectsBeauty(isOn);
  }

  Future<void> startEffectsEnv() async {
    ZegoLoggerService.logInfo(
      'start effects env',
      tag: 'uikit',
      subTag: 'core',
    );

    await ZegoExpressEngine.instance.startEffectsEnv();
  }

  Future<void> stopEffectsEnv() async {
    ZegoLoggerService.logInfo('stop effects env', tag: 'uikit', subTag: 'core');

    await ZegoExpressEngine.instance.stopEffectsEnv();
  }
}

extension ZegoUIKitCoreMixer on ZegoUIKitCore {
  Future<ZegoMixerStartResult> startMixerTask(ZegoMixerTask task) async {
    final ret = await ZegoExpressEngine.instance.startMixerTask(task);
    ZegoLoggerService.logInfo(
      'startMixerTask, code:${ret.errorCode},extendedData:${ret.extendedData}',
      tag: 'uikit',
      subTag: 'core',
    );

    if (ret.errorCode == 0) {
      if (coreData.mixerSEITimer?.isActive ?? false) {
        coreData.mixerSEITimer?.cancel();
      }
      coreData.mixerSEITimer = Timer.periodic(
        const Duration(milliseconds: 300),
        (timer) {
          ZegoUIKitCore.shared.syncDeviceStatusByMixerSEI();
        },
      );
    }
    return ret;
  }

  Future<ZegoMixerStopResult> stopMixerTask(ZegoMixerTask task) async {
    final ret = await ZegoExpressEngine.instance.stopMixerTask(task);
    ZegoLoggerService.logInfo(
      'stopMixerTask, code:${ret.errorCode}',
      tag: 'uikit',
      subTag: 'core',
    );
    if (coreData.mixerSEITimer?.isActive ?? false) {
      coreData.mixerSEITimer?.cancel();
    }
    return ret;
  }

  Future<void> startPlayMixAudioVideo(String mixerID, List<String> users) {
    return coreData.startPlayMixAudioVideo(mixerID, users);
  }

  Future<void> stopPlayMixAudioVideo(String mixerID) {
    return coreData.stopPlayMixAudioVideo(mixerID);
  }
}

extension ZegoUIKitCoreAudioVideo on ZegoUIKitCore {
  Future<void> startPlayAnotherRoomAudioVideo(
    String roomID,
    String userID,
    String userName,
  ) async {
    return coreData.startPlayAnotherRoomAudioVideo(roomID, userID, userName);
  }

  Future<void> stopPlayAnotherRoomAudioVideo(String userID) async {
    return coreData.stopPlayAnotherRoomAudioVideo(userID);
  }

  Future<void> muteAudio(String userID, bool mute) async {
    return coreData.muteAudio(userID, mute);
  }
}

extension ZegoUIKitCoreScreenShare on ZegoUIKitCore {}
