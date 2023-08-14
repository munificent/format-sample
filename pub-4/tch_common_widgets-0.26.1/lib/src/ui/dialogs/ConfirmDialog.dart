import 'package:flutter/material.dart';
import 'package:tch_common_widgets/src/core/CommonTheme.dart';
import 'package:tch_common_widgets/src/ui/dialogs/DialogContainer.dart';
import 'package:tch_common_widgets/src/ui/dialogs/DialogFooter.dart';
import 'package:tch_common_widgets/src/ui/dialogs/DialogHeader.dart';
import 'package:tch_common_widgets/src/ui/widgets/CommonSpace.dart';

class ConfirmDialog extends StatelessWidget {
  final ConfirmDialogStyle? style;
  final String? title;
  final String? text;
  final String? noText;
  final String? yesText;
  final bool isDanger;

  /// ConfirmDialog initialization
  ConfirmDialog({
    this.style,
    this.title,
    this.text,
    this.noText,
    this.yesText,
    this.isDanger = false,
  });

  /// Show the dialog as a popup
  static Future<bool?> show(
    BuildContext context, {
    ConfirmDialogStyle? style,
    String? title,
    String? text,
    String? noText,
    String? yesText,
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: ConfirmDialog(
            style: style,
            title: title,
            text: text,
            noText: noText,
            yesText: yesText,
            isDanger: isDanger,
          ),
        );
      },
    );
  }

  /// Create view layout from widgets
  @override
  Widget build(BuildContext context) {
    final commonTheme = CommonTheme.of(context);

    final dialogContainerStyle = style?.dialogContainerStyle ??
        commonTheme?.dialogsStyle.confirmDialogStyle.dialogContainerStyle ??
        const DialogContainerStyle();
    final dialogHeaderStyle = style?.dialogHeaderStyle ??
        commonTheme?.dialogsStyle.confirmDialogStyle.dialogHeaderStyle ??
        const DialogHeaderStyle();
    final dialogFooterStyle = style?.dialogFooterStyle ??
        commonTheme?.dialogsStyle.confirmDialogStyle.dialogFooterStyle ??
        const DialogFooterStyle();

    final theText = text;
    TextStyle? textStyle = style?.textStyle ??
        commonTheme?.dialogsStyle.confirmDialogStyle.textStyle;
    if (textStyle != null && commonTheme != null) {
      textStyle = commonTheme.preProcessTextStyle(textStyle);
    }

    return DialogContainer(
      style: dialogContainerStyle,
      content: [
        DialogHeader(
          style: dialogHeaderStyle,
          title: title ?? 'Confirm Action',
        ),
        CommonSpaceVHalf(),
        if (theText != null) ...[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  theText,
                  style: textStyle,
                ),
              ),
            ],
          ),
          CommonSpaceVHalf(),
        ],
      ],
      dialogFooter: DialogFooter(
        style: dialogFooterStyle,
        noText: noText ?? 'No',
        yesText: yesText ?? 'Yes',
        noOnTap: () {
          Navigator.pop(context, false);
        },
        yesOnTap: () {
          Navigator.pop(context, true);
        },
        yesIsDanger: isDanger,
      ),
    );
  }
}

class ConfirmDialogStyle {
  final TextStyle textStyle;
  final DialogContainerStyle dialogContainerStyle;
  final DialogHeaderStyle dialogHeaderStyle;
  final DialogFooterStyle dialogFooterStyle;

  /// ConfirmDialogStyle initialization
  const ConfirmDialogStyle({
    this.textStyle = const TextStyle(color: Colors.black, fontSize: 16),
    this.dialogContainerStyle = const DialogContainerStyle(),
    this.dialogHeaderStyle = const DialogHeaderStyle(),
    this.dialogFooterStyle = const DialogFooterStyle(),
  });

  /// Create copy of this tyle with changes
  ConfirmDialogStyle copyWith({
    TextStyle? textStyle,
    DialogContainerStyle? dialogContainerStyle,
    DialogHeaderStyle? dialogHeaderStyle,
    DialogFooterStyle? dialogFooterStyle,
  }) {
    return ConfirmDialogStyle(
      textStyle: textStyle ?? this.textStyle,
      dialogContainerStyle: dialogContainerStyle ?? this.dialogContainerStyle,
      dialogHeaderStyle: dialogHeaderStyle ?? this.dialogHeaderStyle,
      dialogFooterStyle: dialogFooterStyle ?? this.dialogFooterStyle,
    );
  }
}
