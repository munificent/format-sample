import 'dart:convert';
import 'dart:math';

import 'package:vnpttech_pkg/src/core/devices_management/device_info_provider.dart';
import 'package:vnpttech_pkg/src/core/vnpttech_enums.dart';
import 'package:vnpttech_pkg/src/core/vnpttech_ol_api.dart';
import 'package:vnpttech_pkg/src/data_management/device_management/vnpttech_device_model.dart';
import 'package:vnpttech_pkg/src/data_management/models/connuserinfo_config_out.dart';
import 'package:vnpttech_pkg/src/data_management/models/ping_test_out.dart';
import 'package:vnpttech_pkg/src/data_management/models/trace_test_out.dart';

import '../../data_management/device_management/vnpttech_device_management.dart';
import '../../data_management/device_management/vnpttech_device_storage.dart';
import 'package:vnpttech_pkg/src/vnpttech_sdk_log.dart';
import '../authentication/vnpttech_authentication.dart';
import '../connection_management/vnpttech_connection_management.dart';
import '../vnpttech_agent_operator.dart';
import '../vnpttech_constants.dart';
import '../vnpttech_ma_api.dart';
import '../vnpttech_ol_operator.dart';
import '../vnpttech_response.dart';

class ControlProvider {
  final _deviceRepository = DeviceRepository(DeviceStorage());

  ///reboot device
  Future<dynamic> rebootDevice(dynamic rebootDeviceRequest) async {
    try {
      String serialNumber = rebootDeviceRequest['serialNumber'];
      String? userName = rebootDeviceRequest["userName"];
      bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
      String modelName = rebootDeviceRequest['modelName'];

      if (isLocal) {
        return _rebootDeviceLocal(rebootDeviceRequest);
      }
      return _rebootDevicePlatform(serialNumber, modelName, userName);
    } catch (e) {
      printLog(e);
      return SDKResponse(errorCode: 407, errorMessage: messageFail).toJson();
    }
  }

  /// reboot thiết bị khi kết nối trực tiếp đến mobile agent.
  Future<dynamic> _rebootDeviceLocal(dynamic rebootDeviceRequest) async {
    try {
      String serialNumber = rebootDeviceRequest['serialNumber'];
      var currentDevice = await _deviceRepository.getString(serialNumber.toUpperCase());
      if (currentDevice != null) {
        var ipAddr = currentDevice["ipAddr"];
        var cookie = currentDevice["cookies"];
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;
        var macList = rebootDeviceRequest['macList'] ?? "";
        final Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookie};

        var requestParam = {"action": getActionTypes(ActionTypes.reboot), "macList": macList, "requestId": requestId.toInt()};

        var response = await VNPTTechAgentOperator.shared.postWithHeader(ipAddr, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent), params: requestParam);
        var res = AgentResponse.fromJson(response);
        var sdkResponse = convertToSDKResponseNoneData(res);
        printLog("rebootResponse: $sdkResponse");
        return sdkResponse;
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

/*
  reboot thiết bị qua ONELink platform.
*/
  Future<dynamic> _rebootDevicePlatform(String serialNumber, String modelName, String? userName) async {
    try {
      String key = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deviceConfig);
      String? accessToken;
      // kiem tra thoi han checktoken
      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {"Content-Type": "application/json", 'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null
          ? {"command": getCommandTypes(CommandTypes.reboot), "modelName": modelName, "serialNumber": serialNumber, 'username': userName}
          : {
              "command": getCommandTypes(CommandTypes.reboot),
              "modelName": modelName,
              "serialNumber": serialNumber,
            };
      var response = await VNPTTechOLOperator.shared.post(key, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      if (res.errorCode == 200) {
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  ///reset device
  Future<dynamic> resetDevice(dynamic resettDeviceRequest) async {
    try {
      String serialNumber = resettDeviceRequest['serialNumber'];
      String? userName = resettDeviceRequest["userName"];
      bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);

      String modelName = resettDeviceRequest['modelName'];

      if (isLocal) {
        return _resetDeviceLocal(resettDeviceRequest);
      }
      return _resetDevicePlatform(serialNumber, modelName, userName);
    } catch (e) {
      printLog(e);
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  /// reset thiết bị qua ONELink platform.
  Future<dynamic> _resetDevicePlatform(String serialNumber, String modelName, String? userName) async {
    try {
      String key = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deviceConfig);
      String? accessToken;
      // kiem tra thoi han checktoken
      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {"Content-Type": "application/json", 'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null
          ? {"command": getCommandTypes(CommandTypes.resetFactory), "modelName": modelName, "serialNumber": serialNumber, 'username': userName}
          : {
              "command": getCommandTypes(CommandTypes.resetFactory),
              "modelName": modelName,
              "serialNumber": serialNumber,
            };
      var response = await VNPTTechOLOperator.shared.post(key, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      var sdkResponse = toSDKresponseNoneData(res);
      printLog("resetResponse: $sdkResponse");
      return sdkResponse;
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  /// Reset thiết bị khi kết nối trực tiếp đến mobile agent.
  Future<dynamic> _resetDeviceLocal(dynamic resettDeviceRequest) async {
    try {
      String serialNumber = resettDeviceRequest['serialNumber'];
      var macList = resettDeviceRequest['macList'] ?? "";
      var currentDevice = await _deviceRepository.getString(serialNumber.toUpperCase());
      if (currentDevice != null) {
        var ipAddr = currentDevice["ipAddr"];
        var cookie = currentDevice["cookies"];
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;

        final Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookie};

        var requestParam = {"action": getActionTypes(ActionTypes.reset), "macList": macList, "requestId": requestId.toInt()};

        var response = await VNPTTechAgentOperator.shared.postWithHeader(ipAddr, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent), params: requestParam);
        var res = AgentResponse.fromJson(response);
        var sdkResponse = convertToSDKResponseNoneData(res);
        printLog("resetResponse: $sdkResponse");
        return sdkResponse;
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  ///start update firmware\
  ///updateFirmwareRequest {\
  /// modelName: device model\
  /// serialNumber: device Serial | list device serial: "serial1, serial2, ..."\
  /// macAddress: device mac address | list devices mac address: "mac1, mac2, ..."\
  /// url: firmware url\
  /// uri: firmware file path was browsered\
  ///}
  Future<dynamic> updateFirmware(dynamic updateFirmwareRequest) async {
    try {
      String serialNumber = updateFirmwareRequest['serialNumber'];
      bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
      String modelName = updateFirmwareRequest['modelName'];

      String? macAddress = updateFirmwareRequest['macAddress'];
      String? userName = updateFirmwareRequest["userName"];
      String? url = updateFirmwareRequest['url'];
      String? uri = updateFirmwareRequest['uri'];

      List<String> listMac = List.empty();
      if (macAddress != null && macAddress.isNotEmpty) {
        listMac = macAddress.trim().split(",");
      }

      List<String> listSerial = List.empty();
      if (serialNumber.isNotEmpty) {
        listSerial = serialNumber.trim().split(",");
      }
      printLog(listMac);
      printLog(listSerial);
      if (uri != null && uri.isNotEmpty) {
        if (isLocal) {
          //update throw local
          if (listMac.isNotEmpty && listSerial.isNotEmpty) {
            if (listSerial.length == 1) {
              return await _updateFirmwareLocal(listSerial.first, macAddress!, uri);
            } else {
              for (var serial in listSerial) {
                var cachedDevice = await _deviceRepository.getString(serial.toUpperCase());
                if (cachedDevice != null && cachedDevice["cookies"] != null) {
                  return await _updateFirmwareLocal(serial, macAddress!, uri);
                }
              }
            }
          }
        }
        //NOT local, URI => can't update via platform with file path
        return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
      }

      //update throw platform
      if (listSerial.isNotEmpty && url != null) {
        List<OLResponse> results = [];

        await Future.wait(listSerial.map((serial) async {
          OLResponse result = await _updateFirmwareOnline(serial.trim(), modelName, userName, url);
          results.add(result);
        }));

        return SDKResponse(
                errorCode: results.isEmpty
                    ? 400
                    : results.where((element) => element.errorCode != 200).isNotEmpty
                        ? 400
                        : 200,
                errorMessage: results.isEmpty
                    ? messageFail
                    : results.where((element) => element.errorCode != 200).isNotEmpty
                        ? results.where((element) => element.errorCode != 200).map((e) => e.errorMessage).toString()
                        : messageSuccess)
            .toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  Future<dynamic> _updateFirmwareLocal(String serialNumber, String listMac, String uri) async {
    try {
      String md5sum = await calculateMD5SumFile(uri) ?? "";

      var fileName = uri.split('/').last;
      var currentDevice = await _deviceRepository.getString(serialNumber.toUpperCase());
      if (currentDevice != null) {
        String? ipAddr = currentDevice["ipAddr"];
        String? cookie = currentDevice["cookies"];
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;

        final Map<String, String> headers = {"Content-Type": "application/octet-stream", "Cookie": cookie ?? ""};

        var uploadFileResponse =
            await VNPTTechAgentOperator.shared.upoadFileWithHeader(ipAddr ?? defaultIP, headers, "${getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent)}/files/$fileName", uri, true);
        var res = AgentResponse.fromJson(uploadFileResponse);
        printLog("updateResuploadFileResponseponse: ${res.toJson()}");
        if (res.status == 0) {
          final Map<String, String> headers = {"Content-Type": "application/json", "Cookie": cookie ?? ""};
          var updateResponse = await VNPTTechAgentOperator.shared.postWithHeader(ipAddr ?? defaultIP, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent),
              params: updateFirmwareRequest(getActionTypes(ActionTypes.upgradeFirmware), requestId.toInt(), listMac, fileName, md5sum).toJson());
          printLog(" updateResponse-------------------\n $updateResponse");
          var res = AgentResponse.fromJson(updateResponse);
          if (res.status == 0) {
            return convertToSDKResponseNoneData(res);
          }

          return SDKResponse(errorCode: res.status, errorMessage: res.message).toJson();
        }
      }
    } catch (e) {
      printLog(e);
      return SDKResponse(errorCode: 407, errorMessage: messageFail).toJson();
    }
    return SDKResponse(errorCode: 407, errorMessage: messageFail).toJson();
  }

  Future<dynamic> _updateFirmwareOnline(String serialNumber, String modelName, String? userName, String url) async {
    String command = getCommandTypes(CommandTypes.updateFirm);
    String key = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deviceConfig);
    String? accessToken;
    // kiem tra thoi han checktoken
    bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
    if (tokenExpired) {
      accessToken = await VNPTTechAuthentication().refreshToken();
    } else {
      accessToken = await VNPTTechAuthentication().getAccessToken();
    }

    var requestHeaders = {"Content-Type": "application/json", 'Authorization': 'Bearer $accessToken'};

    var requestParams = userName != null
        ? {
            "command": command,
            "modelName": modelName,
            "serialNumber": serialNumber,
            "body": {"fileURL": url},
            'username': userName
          }
        : {
            "command": command,
            "modelName": modelName,
            "serialNumber": serialNumber,
            "body": {"fileURL": url}
          };
    var response = await VNPTTechOLOperator.shared.post(key, headers: requestHeaders, params: requestParams);
    var res = OLResponse.fromJson(response);
    // var sdkResponse = toSDKresponseNoneData(res);
    // printLog("updateFirmwareOnline: $sdkResponse");
    return res;
  }

  Future<dynamic> updateFirmwareMesh(dynamic updateFirmwareRequest) async {
    try {
      String serialNumber = updateFirmwareRequest['serialNumber'];
      bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
      String modelName = updateFirmwareRequest['modelName'];

      String? macAddress = updateFirmwareRequest['macAddress'];
      String? userName = updateFirmwareRequest["userName"];
      String? url = updateFirmwareRequest['url'];
      String? uri = updateFirmwareRequest['uri'];

      List<String> listMac = List.empty();
      if (macAddress != null && macAddress.isNotEmpty) {
        listMac = macAddress.trim().split(",");
      }

      List<String> listSerial = List.empty();
      if (serialNumber.isNotEmpty) {
        listSerial = serialNumber.trim().split(",");
      }
      printLog(listMac);
      printLog(listSerial);
      if (uri != null && uri.isNotEmpty) {
        if (isLocal) {
          //update throw local
          if (listMac.isNotEmpty && listSerial.isNotEmpty) {
            if (listSerial.length == 1) {
              return await _updateFirmwareLocal(listSerial.first, macAddress!, uri);
            } else {
              for (var serial in listSerial) {
                var cachedDevice = await _deviceRepository.getString(serial.toUpperCase());
                if (cachedDevice != null && cachedDevice["cookies"] != null) {
                  return await _updateFirmwareLocal(serial, macAddress ?? "", uri);
                }
              }
            }
          }
        }
        //NOT local, URI => can't update via platform with file path
        return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
      }

      //update throw platform
      if (listSerial.isNotEmpty && url != null) {
        List<OLResponse> results = [];

        await Future.wait(listSerial.map((serial) async {
          OLResponse result = await _updateFirmwareMeshOnline(serial.trim(), modelName, userName, url, listMac);
          results.add(result);
        }));

        return SDKResponse(
                errorCode: results.isEmpty
                    ? 400
                    : results.where((element) => element.errorCode != 200).isNotEmpty
                        ? 400
                        : 200,
                errorMessage: results.isEmpty
                    ? messageFail
                    : results.where((element) => element.errorCode != 200).isNotEmpty
                        ? results.where((element) => element.errorCode != 200).map((e) => e.errorMessage).toString()
                        : messageSuccess)
            .toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  Future<dynamic> _updateFirmwareMeshOnline(String serialNumber, String modelName, String? userName, String url, List<String> listMac) async {
    String command = getCommandTypes(CommandTypes.updateFirm);
    String key = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deviceConfig);
    String? accessToken;
    // kiem tra thoi han checktoken
    bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
    if (tokenExpired) {
      accessToken = await VNPTTechAuthentication().refreshToken();
    } else {
      accessToken = await VNPTTechAuthentication().getAccessToken();
    }

    var requestHeaders = {"Content-Type": "application/json", 'Authorization': 'Bearer $accessToken'};

    var requestParams = userName != null
        ? {
            "command": command,
            "modelName": modelName,
            "serialNumber": serialNumber,
            "body": {"fileURL": url, "macList": listMac},
            'username': userName
          }
        : {
            "command": command,
            "modelName": modelName,
            "serialNumber": serialNumber,
            "body": {"fileURL": url, "macList": listMac}
          };
    var response = await VNPTTechOLOperator.shared.post(key, headers: requestHeaders, params: requestParams);
    var res = OLResponse.fromJson(response);
    // var sdkResponse = toSDKresponseNoneData(res);
    // printLog("updateFirmwareOnline: $sdkResponse");
    return res;
  }

  /// Ping Test
  Future<dynamic> pingTest(dynamic pingTestRequest) async {
    var serialNumber = pingTestRequest["serialNumber"];
    bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
    if (isLocal) {
      return _pingTestAgent(pingTestRequest);
    } else {
      return _pingTestPlatform(pingTestRequest);
    }
  }

  /// Ping test Agent
  Future<dynamic> _pingTestAgent(dynamic pingTestRequest) async {
    try {
      var serialNumber = pingTestRequest["serialNumber"];
      var host = pingTestRequest["host"];
      var pingCode = 1;
      var currentDevice = await _deviceRepository.getString(serialNumber.toUpperCase());
      if (currentDevice != null) {
        var ipAddr = currentDevice["ipAddr"];
        var cookie = currentDevice["cookies"];
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;

        final Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookie};

        var response = await VNPTTechAgentOperator.shared.postWithHeader(ipAddr ?? defaultIP, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent),
            params: pingTestAgentRequest(getActionTypes(ActionTypes.ping), pingCode, host, requestId.toInt()).toJson());
        var res = AgentResponse.fromJson(response);
        // kiểm tả nếu status = 0 thì dữ liệu trả về chỉ lấy phần tử đầu tiên của listJson trả về
        if (res.status == 0) {
          var pingOutput = res.data["results"];
          var pingTestOutput = PingTestOutput.fromJson(pingOutput[0]);
          res.data["results"] = pingTestOutput.toJson();
        }
        var sdkResponse = convertToSDKResponse(res);
        printLog("pingResponse: $sdkResponse");
        return sdkResponse;
      }
    } catch (e) {
      return {"errorCode": "400", "errorMessage": messageFail};
    }
    return {"errorCode": "400", "errorMessage": messageFail};
  }

  /// Ping test platform
  Future<dynamic> _pingTestPlatform(dynamic pingTestRequest) async {
    try {
      var serialNumber = pingTestRequest["serialNumber"];
      var modelName = pingTestRequest["modelName"];
      var host = pingTestRequest["host"];
      String? userName = pingTestRequest["userName"];
      String? accessToken;
      String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.ping);

      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {'Authorization': 'Bearer $accessToken'};

      var requestParams =
          userName != null ? {'modelName': modelName, 'serialNumber': serialNumber, 'host': host, 'username': userName} : {'modelName': modelName, 'serialNumber': serialNumber, 'host': host};
      var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      printLog("PingResponse: $response");

      //nếu ping thành công thì biến đổi dữ liệu trả về đúng với sdk Respponse
      if (res.errorCode == 200) {
        var pingTestOutput = PingTestOutput.fromJson(res.body);
        res.body = pingTestOutput.toJson();
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess, data: res.body).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  /// Trace Test
  Future<dynamic> traceTest(dynamic traceTestRequest) async {
    var serialNumber = traceTestRequest["serialNumber"];
    bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
    if (isLocal) {
      return _traceTestAgent(traceTestRequest);
    } else {
      return _traceTestPlatform(traceTestRequest);
    }
  }

  /// Trace Test Agent
  Future<dynamic> _traceTestAgent(dynamic traceTestRequest) async {
    try {
      var serialNumber = traceTestRequest["serialNumber"];
      var host = traceTestRequest["host"];
      var tracerouteCode = 1;
      var currentDevice = await _deviceRepository.getString(serialNumber.toUpperCase());
      if (currentDevice != null) {
        var ipAddr = currentDevice["ipAddr"];
        var cookie = currentDevice["cookies"];
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;

        final Map<String, String> headers = <String, String>{"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookie};

        var response = await VNPTTechAgentOperator.shared.postWithHeader(ipAddr ?? defaultIP, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent),
            params: traceTestAgentRequest(getActionTypes(ActionTypes.traceroute), tracerouteCode, host, requestId.toInt()).toJson());
        var res = AgentResponse.fromJson(response);
        List<dynamic> listTraceOutput = [];
        if (res.status == 0) {
          var listTraceResultAgent = jsonDecode(jsonEncode(res.data['results']));

          for (var i = 0; i < listTraceResultAgent.length; i++) {
            if (listTraceResultAgent[i].isNotEmpty) {
              var errorCode = res.data['tracerouteCode'];
              var ipAddress = listTraceResultAgent[i]['hopAddress'] ?? '';
              var host = listTraceResultAgent[i]['hopHost'] ?? '';
              var rtTimes = double.parse(listTraceResultAgent[i]['hopRTTimes'].toString());
              var itemTrace = TraceTestOutput(errorCode: errorCode, ipAddress: ipAddress, host: host, rtTimes: rtTimes);
              listTraceOutput.add(itemTrace.toJson());
            }
          }
        }
        res.data['results'] = listTraceOutput;
        var sdkResponse = convertToSDKResponse(res);
        printLog("traceResponse: $sdkResponse");
        return sdkResponse;
      }
    } catch (e) {
      return {"errorCode": "400", "errorMessage": messageFail};
    }
    return {"errorCode": "400", "errorMessage": messageFail};
  }

  /// Trace Test paltform
  Future<dynamic> _traceTestPlatform(dynamic traceTestRequest) async {
    var serialNumber = traceTestRequest["serialNumber"];
    var modelName = traceTestRequest["modelName"];
    var host = traceTestRequest["host"];
    String? userName = traceTestRequest["userName"];
    String? accessToken;
    String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.trace);

    bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
    if (tokenExpired) {
      accessToken = await VNPTTechAuthentication().refreshToken();
    } else {
      accessToken = await VNPTTechAuthentication().getAccessToken();
    }

    var requestHeaders = {'Authorization': 'Bearer $accessToken'};

    var requestParams =
        userName != null ? {'modelName': modelName, 'serialNumber': serialNumber, 'host': host, 'username': userName} : {'modelName': modelName, 'serialNumber': serialNumber, 'host': host};
    var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
    var res = OLResponse.fromJson(response);
    printLog("TraceResponse: $response");
    List<dynamic> listTraceOutput = [];
    if (res.errorCode == 200) {
      var listTraceResultPlatform = jsonDecode(jsonEncode(res.body['routeHops']));
      for (var i = 0; i < listTraceResultPlatform.length; i++) {
        if (listTraceResultPlatform[i].isNotEmpty) {
          var errorCode = int.parse(listTraceResultPlatform[i]['hopErrorCode']);
          var ipAddress = listTraceResultPlatform[i]['hopAddress'] ?? '';
          var host = listTraceResultPlatform[i]['hopHost'] ?? '';
          var rtTimes = double.parse(listTraceResultPlatform[i]['hopRTTime'].toString());
          var itemTrace = TraceTestOutput(errorCode: errorCode, ipAddress: ipAddress, host: host, rtTimes: rtTimes);

          listTraceOutput.add(itemTrace.toJson());
        }
      }

      return SDKResponse(errorCode: 200, errorMessage: messageSuccess, data: listTraceOutput).toJson();
    } else {
      return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
    }
  }

  ///start restore config
  Future<dynamic> restoreConfig(dynamic restoreConfigRequest) async {
    String modelName = restoreConfigRequest['modelName'];
    String serialNumber = restoreConfigRequest['serialNumber'];
    String? userName = restoreConfigRequest["userName"];
    String? url = restoreConfigRequest['url'];
    String? backupDate = restoreConfigRequest['backupDate'].toString();
    String? softwareVersion = restoreConfigRequest['softwareVersion'];

    String command = getCommandTypes(CommandTypes.restore);
    String key = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deviceConfig);
    String? accessToken;
    // kiem tra thoi han checktoken
    bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
    if (tokenExpired) {
      accessToken = await VNPTTechAuthentication().refreshToken();
    } else {
      accessToken = await VNPTTechAuthentication().getAccessToken();
    }

    var requestHeaders = {"Content-Type": "application/json", 'Authorization': 'Bearer $accessToken'};
    var body = {"backup_date": backupDate, "url": url, "softwareVersion": softwareVersion};
    final requestParams = userName != null
        ? {"command": command, "modelName": modelName, "serialNumber": serialNumber, "body": body, 'username': userName}
        : {"command": command, "modelName": modelName, "serialNumber": serialNumber, "body": body};
    var response = await VNPTTechOLOperator.shared.post(key, headers: requestHeaders, params: requestParams);
    printLog(response);
    var res = OLResponse.fromJson(response);
    if (res.errorCode == 200) {
      return SDKResponse(errorCode: 200, errorMessage: messageSuccess, data: res.body).toJson();
    } else {
      return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
    }
  }

  /// Speed Test
  Future<dynamic> speedTest(dynamic speedTestRequest) async {
    var serialNumber = speedTestRequest["serialNumber"];
    bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
    if (isLocal) {
      return _speedTestAgent(speedTestRequest);
    } else {
      return _speedTestPlatform(speedTestRequest);
    }
  }

  ///SpeedTest Platform
  Future<dynamic> _speedTestPlatform(dynamic speedTestRequest) async {
    try {
      var serialNumber = speedTestRequest["serialNumber"];
      var modelName = speedTestRequest["modelName"];
      String? userName = speedTestRequest["userName"];
      String? accessToken;
      String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.speedTest);

      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null
          ? {'modelName': modelName, 'serialNumber': serialNumber, 'username': userName}
          : {
              'modelName': modelName,
              'serialNumber': serialNumber,
            };
      var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      printLog("PingResponse: $response");

      if (res.errorCode == 200) {
        var speedData = res.body;
        var downloadSpeed = double.parse((speedData["downloadSpeed"] ?? '0').toString());
        var uploadSpeed = double.parse((speedData["uploadSpeed"] ?? '0').toString());

        var latency = double.parse((speedData["latency"] ?? '0').toString());
        var speedTestOutput = {"downloadSpeed": downloadSpeed, "uploadSpeed": uploadSpeed, "latency": latency};
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess, data: speedTestOutput).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  /// Speed Test Agent
  Future<dynamic> _speedTestAgent(dynamic speedTestRequest) async {
    try {
      var serialNumber = speedTestRequest["serialNumber"];
      var speedtestCode = 1;
      var currentDevice = await _deviceRepository.getString(serialNumber.toUpperCase());
      if (currentDevice != null) {
        var ipAddr = currentDevice["ipAddr"];
        var cookie = currentDevice["cookies"];
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;

        final Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookie};

        var param = {"action": getActionTypes(ActionTypes.speedtest), "speedtestCode": speedtestCode, "requestId": requestId};

        var response = await VNPTTechAgentOperator.shared.postWithHeader(ipAddr ?? defaultIP, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent), params: param);
        var res = AgentResponse.fromJson(response);
        if (res.status == 0) {
          var speedOutput = res.data["results"];
          var speedData = speedOutput[0];

          var downloadSpeed = double.parse((speedData["downloadSpeed"] ?? '0').toString());
          var uploadSpeed = double.parse((speedData["uploadSpeed"] ?? '0').toString());

          var latency = double.parse((speedData["latency"] ?? '0').toString());
          res.data["results"] = {"downloadSpeed": downloadSpeed, "uploadSpeed": uploadSpeed, "latency": latency};
        }
        var sdkResponse = convertToSDKResponse(res);
        printLog("SpeedTest : $sdkResponse");
        return sdkResponse;
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  ///Delete device
  Future<dynamic> deleteDevice(dynamic deleteDeviceRequest) async {
    try {
      String modelName = deleteDeviceRequest['modelName'];
      String serialNumber = deleteDeviceRequest['serialNumber'];
      String? userName = deleteDeviceRequest["userName"];
      String? accessToken;
      String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deleteDevice);

      // kiem tra thoi han checktoken
      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null ? {'modelName': modelName, 'serialNumber': serialNumber, 'username': userName} : {'modelName': modelName, 'serialNumber': serialNumber};

      var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      printLog("deleteDevice: $response");

      if (res.errorCode == 200) {
        DeviceInfoProvider().clearDeviceCache(serialNumber, removeDevice: true);
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      printLog(e);
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  ///Delete all backup files
  Future<dynamic> deleteAllBackupFile(dynamic deleteBackupRequest) async {
    try {
      String modelName = deleteBackupRequest['modelName'];
      String serialNumber = deleteBackupRequest['serialNumber'];
      String? userName = deleteBackupRequest["userName"];
      String? accessToken;
      String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deleteBackup);

      // kiem tra thoi han checktoken
      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null ? {'modelName': modelName, 'serialNumber': serialNumber, 'username': userName} : {'modelName': modelName, 'serialNumber': serialNumber};

      var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      printLog("deleteAllBackupFile: $response");

      if (res.errorCode == 200) {
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      printLog(e);
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  ///Delete backup files
  Future<dynamic> deleteBackupFile(dynamic deleteBackupFileRequest) async {
    try {
      String modelName = deleteBackupFileRequest['modelName'];
      String serialNumber = deleteBackupFileRequest['serialNumber'];
      List<String> backupList = deleteBackupFileRequest['backupList'];
      String? userName = deleteBackupFileRequest["userName"];
      String key = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.deleteBackupFile);
      String? accessToken;
      // kiem tra thoi han checktoken
      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {"Content-Type": "application/json", 'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null
          ? {
              "modelName": modelName,
              "serialNumber": serialNumber,
              "body": {
                "urls": backupList,
              },
              'username': userName
            }
          : {
              "modelName": modelName,
              "serialNumber": serialNumber,
              "body": {
                "urls": backupList,
              }
            };
      var response = await VNPTTechOLOperator.shared.post(key, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      if (res.errorCode == 200) {
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  // get Connected User Info
  Future<dynamic> getConnectedUserInfo(dynamic getConnectedUserInfoRequest) async {
    String serialNumber = getConnectedUserInfoRequest['serialNumber'];
    bool isLocal = ConnectionManagement.shared.getMoblieAgentConnect(serialNumber);
    if (isLocal) {
      return _getConnectedUserInfoAgent(getConnectedUserInfoRequest);
    } else {
      return _getConnectedUserInfoPlatform(getConnectedUserInfoRequest);
    }
  }

  // get ConnectedUserInfo
  Future<dynamic> _getConnectedUserInfoPlatform(dynamic getConnectedUserRequest) async {
    try {
      String modelName = getConnectedUserRequest['modelName'];
      String serialNumber = getConnectedUserRequest['serialNumber'];
      String? userName = getConnectedUserRequest["userName"];
      String? accessToken;
      String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.getDeviceConfig);
      String command = getCommandTypes(CommandTypes.getConnectedUserInfo);

      // kiem tra thoi han checktoken
      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }

      var requestHeaders = {'Authorization': 'Bearer $accessToken'};

      final requestParams = userName != null
          ? {'modelName': modelName, 'serialNumber': serialNumber, 'command': command, 'username': userName}
          : {'modelName': modelName, 'serialNumber': serialNumber, 'command': command};

      var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      printLog("getConnectedUserInfo: $response");

      if (res.errorCode == 200) {
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess, data: res.body).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      printLog(e);
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  /// getConnectedUserInfoAgent
  Future<dynamic> _getConnectedUserInfoAgent(dynamic getConnectedUserInfoRequest) async {
    try {
      String serialNumber = getConnectedUserInfoRequest['serialNumber'];
      serialNumber = serialNumber.toUpperCase();
      String ipAddr = defaultIP;
      ActionTypes actionTypes = ActionTypes.topology;

      var deviceData = await _deviceRepository.getString(serialNumber);
      var modelDevice = DeviceManagement.fromJson(deviceData);
      String? cookies = modelDevice.cookies;

      if (cookies != null) {
        ipAddr = modelDevice.ipAddr;
        final Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json", "Cookie": cookies};
        var requestId = DateTime.now().millisecondsSinceEpoch / 1000;
        var getTopologyResponse = await VNPTTechAgentOperator.shared
            .postWithHeader(ipAddr, headers, getMobbileAgentAPIs(MobbileAgentAPIs.onelinkagent), params: rebootDevicesQuery(getActionTypes(actionTypes), requestId.toInt()).toJson());
        AgentResponse response = AgentResponse.fromJson(getTopologyResponse);
        if (response.status == 0) {
          var sdkResponse = convertToSDKResponse(response);
          var dataResponse = sdkResponse['data'];
          var data = [];
          for (var i = 0; i < dataResponse.length; i++) {
            var clientInfo = dataResponse[i]['clientInfo'];
            for (var j = 0; j < clientInfo.length; j++) {
              var interfaceType = clientInfo[j]['interfaceType'];
              switch (interfaceType) {
                case 0:
                  interfaceType = '2.4GHz';
                  break;
                case 1:
                  interfaceType = '5GHz';
                  break;
                case 2:
                  interfaceType = 'Ethernet';
                  break;
                default:
                  interfaceType = '';
              }
              var out = ConnectedUserInfo(
                status: clientInfo[j]['status'],
                hostName: clientInfo[j]['hostName'],
                interfaceType: interfaceType,
                clientIp: clientInfo[j]['clientIp'],
                clientMac: clientInfo[j]['clientMac'],
                clientRssi: clientInfo[j]['clientRssi'],
                clientRxrate: clientInfo[j]['clientRxrate'],
                clientTxrate: clientInfo[j]['clientTxrate'],
              );
              data.add(out.toJson());
            }
          }
          return SDKResponse(errorCode: 200, errorMessage: messageSuccess, data: data).toJson();
        } else {
          return SDKResponse(errorCode: response.status, errorMessage: response.message).toJson();
        }
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }

  /// backup cấu hình của thiết bị
  Future<dynamic> backupConfig(dynamic backupConfigRequest) async {
    try {
      String modelName = backupConfigRequest['modelName'];
      String serialNumber = backupConfigRequest['serialNumber'];
      String fileName = backupConfigRequest['fileName'];
      String? userName = backupConfigRequest["userName"];
      String? accessToken;
      String api = getOneLinkPlatformAPIs(OneLinkPlatformAPIs.backup);

      bool tokenExpired = await VNPTTechAuthentication().checkTokenExpired();
      if (tokenExpired) {
        accessToken = await VNPTTechAuthentication().refreshToken();
      } else {
        accessToken = await VNPTTechAuthentication().getAccessToken();
      }
      var requestHeaders = {'Authorization': 'Bearer $accessToken'};

      var requestParams = userName != null
          ? {'modelName': modelName, 'serialNumber': serialNumber, 'backupName': fileName, 'username': userName}
          : {'modelName': modelName, 'serialNumber': serialNumber, 'backupName': fileName};

      var response = await VNPTTechOLOperator.shared.get(api, headers: requestHeaders, params: requestParams);
      var res = OLResponse.fromJson(response);
      printLog("backupConfig: $response");
      if (res.errorCode == 200) {
        return SDKResponse(errorCode: 200, errorMessage: messageSuccess).toJson();
      } else {
        return SDKResponse(errorCode: res.errorCode, errorMessage: res.errorMessage).toJson();
      }
    } catch (e) {
      return SDKResponse(errorCode: 400, errorMessage: messageFail).toJson();
    }
  }
}
