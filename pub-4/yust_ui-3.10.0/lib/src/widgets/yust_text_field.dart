import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../yust_ui.dart';

class YustTextField extends StatefulWidget {
  final String? label;
  final String? value;
  final TextStyle? textStyle;
  final StringCallback? onChanged;

  /// if a validator is implemented, onEditingComplete gets only triggered, if validator is true (true = returns null)
  final StringCallback? onEditingComplete;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TapCallback? onTap;
  final DeleteCallback? onDelete;
  final int? maxLines;
  final int? minLines;
  final bool autocorrect;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final bool autofocus;
  final bool hideKeyboardOnAutofocus;
  final bool slimDesign;
  final bool notTrim;
  final FocusNode? focusNode;
  final YustInputStyle? style;
  final bool divider;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final AutovalidateMode? autovalidateMode;
  final SmartQuotesType? smartQuotesType;
  final TextInputType? keyboardType;
  final List<FilteringTextInputFormatter> inputFormatters;
  final TextInputAction? textInputAction;
  final EdgeInsets contentPadding;

  const YustTextField({
    Key? key,
    this.label,
    this.value,
    this.textStyle,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    this.validator,
    this.onTap,
    this.onDelete,
    this.maxLines,
    this.minLines,
    this.enabled = true,
    this.autocorrect = true,
    this.readOnly = false,
    this.slimDesign = false,
    this.obscureText = false,
    this.autofocus = false,
    this.notTrim = false,
    this.hideKeyboardOnAutofocus = false,
    this.focusNode,
    this.style = YustInputStyle.normal,
    this.divider = true,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.sentences,
    this.autovalidateMode,
    this.inputFormatters = const [],
    this.smartQuotesType,
    this.keyboardType,
    this.textInputAction,
    this.contentPadding = const EdgeInsets.all(20.0),
  }) : super(key: key);

  @override
  State<YustTextField> createState() => _YustTextFieldState();
}

class _YustTextFieldState extends State<YustTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode = FocusNode();
  late String _initValue;
  late bool _valueDidChange;

  void onUnfocus() {
    if (_valueDidChange == false) return;
    if (widget.onEditingComplete == null) return;

    final textFieldText =
        widget.notTrim ? _controller.value.text : _controller.value.text.trim();
    final textFieldValue = textFieldText == '' ? null : textFieldText;

    if (widget.validator == null || widget.validator!(textFieldValue) == null) {
      widget.onEditingComplete!(textFieldValue);
      _valueDidChange = false;
    } else {
      _controller.text = widget.value ?? '';
    }
  }

  /// This Method resets/initializes the state of the widget
  void resetState() {
    if (widget.controller != null && widget.value != null) {
      widget.controller!.text = widget.value!;
    }
    _valueDidChange = false;
    _controller =
        widget.controller ?? TextEditingController(text: widget.value);
    _focusNode = widget.focusNode ?? FocusNode();
    _initValue = widget.value ?? '';
    _focusNode.addListener(() {
      // if (!_focusNode.hasFocus) onUnfocus();
      if (!_focusNode.hasFocus && widget.onEditingComplete != null) {
        final textFieldText = widget.notTrim
            ? _controller.value.text
            : _controller.value.text.trim();
        final textFieldValue = textFieldText == '' ? null : textFieldText;
        if (widget.validator == null ||
            widget.validator!(textFieldValue) == null) {
          widget.onEditingComplete!(textFieldValue);
        } else {
          _controller.text = widget.value ?? '';
        }
      }
    });
    if (widget.autofocus && widget.hideKeyboardOnAutofocus) {
      Future.delayed(
        const Duration(),
        () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
      );
    }
    _controller.addListener(() {
      _valueDidChange = true;
    });
  }

  @override
  void initState() {
    super.initState();
    resetState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => onUnfocus());

    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the Text-Fields Label changed, we can assume it's a new/different TextField
    // (Flutter "reuses" existing Widgets in the tree)

    // Also because "*" are often used to mark required fields, we remove them beforehand
    final oldLabel = oldWidget.label?.replaceAll(' *', '');
    final newLabel = widget.label?.replaceAll(' *', '');
    if (oldLabel != newLabel) {
      onUnfocus();
      resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textValue = widget.value ?? '';
    if ((textValue != _initValue || textValue != _controller.text) &&
        widget.onChanged == null) {
      _controller.text = textValue;
      _initValue = textValue;
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }

    if (widget.slimDesign) return _buildTextField();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(),
            ),
            widget.suffixIcon ?? const SizedBox(),
            if (widget.onDelete != null && widget.value != '')
              IconButton(
                  onPressed: widget.onDelete!,
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  )),
          ],
        ),
        if (widget.style == YustInputStyle.normal && widget.divider)
          const Divider(height: 1.0, thickness: 1.0, color: Colors.grey),
      ],
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: widget.readOnly
            ? TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color ??
                    Colors.black)
            : null,
        contentPadding: widget.contentPadding,
        border: widget.style == YustInputStyle.outlineBorder
            ? const OutlineInputBorder()
            : InputBorder.none,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.readOnly
            ? Theme.of(context).textTheme.bodySmall?.color ?? Colors.black
            : null,
      ),
      style: widget.textStyle,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction ??
          (widget.minLines != null
              ? TextInputAction.newline
              : TextInputAction.next),
      onChanged: widget.onChanged == null
          ? null
          : (value) => widget.onChanged!(
              value == '' ? null : (widget.notTrim ? value : value.trim())),
      onTap: widget.onTap,
      autocorrect: widget.autocorrect,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      smartQuotesType: widget.smartQuotesType,
      autovalidateMode: widget.autovalidateMode ??
          (widget.validator != null
              ? AutovalidateMode.onUserInteraction
              : null),
      validator: widget.validator == null
          ? null
          : (value) => widget.validator!(value!.trim()),
      autofocus: widget.autofocus,
    );
  }
}
