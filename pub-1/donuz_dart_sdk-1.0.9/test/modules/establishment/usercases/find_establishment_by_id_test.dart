import 'dart:convert';

import 'package:donuz_dart_sdk/modules/common/common_module.dart';
import 'package:donuz_dart_sdk/modules/establishment/establishment_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../json/establisment/establishment_json.dart';
import '../../../mocks/common/base_config_mock.dart';
import '../../../mocks/establishment/repositories/establishment_repository_mock.dart';

void main() async {
  var establismentRepositoryMock = EstablishmentRepositoryMock();
  SharedPreferences.setMockInitialValues({});
  StorageService storageService =
      StorageService(await SharedPreferences.getInstance());
  var findEstablishmentById = FindEstablishmentByIdImpl(
      establismentRepositoryMock,
      BaseConfigMock("2234", 'alksdjlaksd'),
      storageService);

  group("FindEstablishmentById", () {
    test('Deve buscar um establecimento por id', () async {
      when(() => establismentRepositoryMock.findById("2234"))
          .thenAnswer((_) async {
        return EstabelishmentModel.fromJson(jsonDecode(establishimentJson))
            .estabelecimento;
      });
      var response = await findEstablishmentById();
      expect(response, isNotNull);
    });

    test("Deve retornar uma Nullable string  ao buscar o currentId", () async {
      await storageService.clearAll();
      var response = await findEstablishmentById.currentId();
      expect(response, isNull);
    });
    test("Deve retornar o currentID", () async {
      when(() => establismentRepositoryMock.findById("2234"))
          .thenAnswer((_) async {
        return EstabelishmentModel.fromJson(jsonDecode(establishimentJson))
            .estabelecimento;
      });
      await findEstablishmentById();
      var response = await findEstablishmentById.currentId();
      expect(response, isNotNull);
      expect(response, "2234");
    });
  });
}
