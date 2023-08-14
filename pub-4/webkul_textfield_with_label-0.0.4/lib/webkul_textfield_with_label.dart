library textfield_with_label;

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webkul_textfield_with_label/widget/textfield.dart';
import 'utils/input_decoration.dart';

class TextFieldWithLabel extends StatefulWidget {
  final double? padding;
  final String labelText;
  final TextStyle? labelTextStyle;
  final double? gapBtwLblAndField;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool? autoCorrect;
  final bool? autoFocus;
  final AutovalidateMode? autoValidateMode;
  final bool? readOnly;
  final int? maxLines;
  final bool? obscureText;
  final Radius? cursorRadius;
  final VoidCallback? onTap;
  final bool? enabled;
  final double? cursorHeight;
  final Color? cursorColor;
  final String? obscureCharacter;
  final TextAlign? textAlign;
  final TextStyle? textFieldTextStyle;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSaved;
  final int? minLines;
  final Iterable<String>? autoFillHints;
  final Brightness? keyboardAppearance;
  final InputCounterWidgetBuilder? inputCounterWidgetBuilder;
  final double? cursorWidth;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? showCursor;
  final ValueChanged<String>? onFieldSubmitted;
  final TextDirection? textDirection;
  final InputDecorationTextField? inputDecorationTextField;

  const TextFieldWithLabel(
      {Key? key,
      required this.labelText,
      this.inputDecorationTextField,
      this.padding,
      this.labelTextStyle,
      this.gapBtwLblAndField,
      this.controller,
      this.initialValue,
      this.focusNode,
      this.autoCorrect,
      this.maxLines,
      this.textAlign,
      this.textFieldTextStyle,
      this.readOnly,
      this.onChanged,
      this.onTap,
      this.onSaved,
      this.obscureText,
      this.obscureCharacter,
      this.autoFocus,
      this.autoValidateMode,
      this.validator,
      this.enabled,
      this.cursorHeight,
      this.cursorColor,
      this.onEditingComplete,
      this.cursorRadius,
      this.minLines,
      this.autoFillHints,
      this.keyboardAppearance,
      this.cursorWidth,
      this.inputCounterWidgetBuilder,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization,
      this.showCursor,
      this.onFieldSubmitted,
      this.textDirection})
      : super(key: key);

  @override
  State<TextFieldWithLabel> createState() => _TextFieldWithLabelState();
}

class _TextFieldWithLabelState extends State<TextFieldWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding ?? 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.labelText,
            style: widget.labelTextStyle ??
                const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          SizedBox(
            height: widget.gapBtwLblAndField ?? 6.0,
          ),
          LabelTextFormField(
              key: widget.key,
              showCursor: widget.showCursor ?? true,
              textDirection: widget.textDirection,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              textInputAction: widget.textInputAction,
              onFieldSubmitted: widget.onFieldSubmitted,
              keyboardAppearance: widget.keyboardAppearance,
              autofillHints: widget.autoFillHints,
              buildCounter: widget.inputCounterWidgetBuilder,
              cursorRadius: widget.cursorRadius,
              cursorWidth: widget.cursorWidth ?? 2.0,
              keyboardType: widget.keyboardType,
              onTap: widget.onTap,
              minLines: widget.minLines,
              cursorColor: widget.cursorColor,
              cursorHeight: widget.cursorHeight,
              enabled: widget.enabled,
              focusNode: widget.focusNode,
              onEditingComplete: widget.onEditingComplete,
              onSaved: widget.onSaved,
              validator: widget.validator,
              autofocus: widget.autoFocus ?? false,
              autovalidateMode: widget.autoValidateMode,
              readOnly: widget.readOnly ?? false,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: widget.obscureCharacter ?? "*",
              initialValue: widget.initialValue,
              textAlign: widget.textAlign ?? TextAlign.start,
              style: widget.textFieldTextStyle,
              maxLines: widget.maxLines,
              autocorrect: widget.autoCorrect ?? false,
              controller: widget.controller,
              decoration: widget.inputDecorationTextField)
        ],
      ),
    );
  }
}
