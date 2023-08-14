library zwap_modal;

import 'package:flutter/material.dart';
import 'package:taastrap/utils/utils.dart';
import 'package:zwap_design_system/atoms/atoms.dart';
import 'package:zwap_design_system/atoms/colors/zwapColors.dart';

//TODO: standardizza per modale a più passaggi

part './components/modal_top_left_widget.dart';
part './components/modal_top_rigth_widget.dart';
part './components/modal_bottom_widget.dart';
part './components/modal_multi_step_widget.dart';

Future<T?> showNewZwapModal<T>(BuildContext context, Widget child) async {
  return showGeneralDialog<T>(
    barrierDismissible: true,
    barrierLabel: "NewZwapModal",
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(alignment: Alignment.topCenter, child: child);
    },
  );
}

/// Modal Component to show a popup
///
/// There are some standardized component to fastly implement
/// complete modals:
/// * NewModalBottomWidget (loading, single button, dobule button)
/// * NewModalTopRigthWidget (close)
/// * NewModalTopLeftWidget (back button)
/// * NewModalMultuStepWidget (for handle multi step inside the modal)
class NewModal extends StatefulWidget {
  final Widget? title;

  /// This widget must have width/height <= 50 (future change in code if necessary)
  final Widget? topLeftWidget;

  /// This widget must have width/height <= 50 (future change in code if necessary)
  final Widget? topRightWidget;

  final Widget? topWidget;
  final Widget? bodyWidget;
  final Widget? bottomWidget;

  ///Use keys to pass values that change over time to garantee the child update with values
  final List<dynamic> topWidgetKeys;
  final List<dynamic> bodyWidgetKeys;
  final List<dynamic> bottomWidgetKeys;

  final double width;

  final bool addPaddingToTopWidget;
  final bool addPaddingToBodyWidget;
  final bool addPaddingToBottomWidget;

  /// If [false] body will not scroll in the widget.
  ///
  /// Default to true, set false to provide a custom scroll widget to body
  final bool scrollable;

  final bool showDivider;

  NewModal({
    required this.width,
    this.topLeftWidget,
    this.title,
    this.topRightWidget,
    this.bodyWidget,
    this.bottomWidget,
    this.topWidget,
    this.scrollable = true,
    this.showDivider = true,
    this.topWidgetKeys = const [],
    this.bodyWidgetKeys = const [],
    this.bottomWidgetKeys = const [],
    this.addPaddingToTopWidget = true,
    this.addPaddingToBodyWidget = true,
    this.addPaddingToBottomWidget = true,
    Key? key,
  }) : super(key: key);

  @override
  State<NewModal> createState() => _NewModalState();
}

class _NewModalState extends State<NewModal> {
  bool get _showTopLateralWidgets =>
      widget.topLeftWidget != null || widget.topRightWidget != null;

  ValueKey get _topKey => widget.topWidgetKeys.isEmpty
      ? ValueKey([])
      : ValueKey(
          widget.topWidgetKeys.reduce((v, e) => '${v.hashCode ^ e.hashCode}'),
        );
  ValueKey get _bodyKey => widget.bodyWidgetKeys.isEmpty
      ? ValueKey([])
      : ValueKey(
          widget.bodyWidgetKeys.reduce((v, e) => '${v.hashCode ^ e.hashCode}'),
        );
  ValueKey get _bottomKey => widget.bottomWidgetKeys.isEmpty
      ? ValueKey([])
      : ValueKey(widget.bottomWidgetKeys.reduce(
          (v, e) => '${v.hashCode ^ e.hashCode}',
        ));

  double get _horizontalPadding => getMultipleConditions(30, 30, 30, 30, 10);

  Widget _getTitleSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 50),
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_showTopLateralWidgets)
                Container(
                  width: 50,
                  height: 50,
                  child: Center(child: widget.topLeftWidget),
                ),
              if (widget.title != null)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    key: _topKey,
                    padding: widget.addPaddingToTopWidget
                        ? EdgeInsets.symmetric(
                            horizontal: _horizontalPadding,
                            vertical: 8,
                          )
                        : EdgeInsets.zero,
                    child: widget.title!,
                  ),
                ),
              if (_showTopLateralWidgets)
                Container(
                  width: 50,
                  height: 50,
                  child: Center(child: widget.topRightWidget),
                ),
            ],
          ),
        ),
        if (widget.topWidget != null)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Container(
              key: _topKey,
              padding: widget.addPaddingToTopWidget
                  ? EdgeInsets.symmetric(
                      horizontal: _horizontalPadding,
                      vertical: 8,
                    )
                  : EdgeInsets.zero,
              child: widget.topWidget!,
            ),
          ),
      ],
    );
  }

  /// Render the single body widget
  Widget _getSingleBodySection() {
    if (widget.scrollable)
      return Flexible(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: 10,
            left: widget.addPaddingToBodyWidget ? _horizontalPadding : 0,
            right: widget.addPaddingToBodyWidget ? _horizontalPadding : 0,
          ),
          child:
              Container(key: _bodyKey, child: widget.bodyWidget ?? Container()),
        ),
      );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Container(
        key: _bodyKey,
        padding: widget.addPaddingToBodyWidget
            ? EdgeInsets.symmetric(horizontal: _horizontalPadding, vertical: 8)
            : EdgeInsets.zero,
        child: widget.bodyWidget ?? Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: ZwapColors.shades0,
        child: Container(
          width: widget.width,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.2,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getTitleSection(),
              if (widget.showDivider)
                Divider(height: 2, thickness: 1, color: ZwapColors.neutral300),
              _getSingleBodySection(),
              if (widget.bottomWidget != null)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    key: _bottomKey,
                    padding: widget.addPaddingToBottomWidget
                        ? EdgeInsets.symmetric(
                            horizontal: _horizontalPadding,
                            vertical: 8,
                          )
                        : EdgeInsets.zero,
                    child: widget.bottomWidget!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
