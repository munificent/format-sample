import 'package:blayz_pay/gaj_model/gam_model.dart';

import '/backend/api_requests/api_calls.dart';

import 'package:flutter/material.dart';


class LoanInitiaDepositConfirmModel extends GajModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Bottom Sheet - pinAuth] action in Button widget.
  String? transactionToken;
  // Stores action output result for [Backend Call - API (finalizeLoan)] action in Button widget.
  ApiCallResponse? apiResultkg0;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Additional helper methods are added here.

}
