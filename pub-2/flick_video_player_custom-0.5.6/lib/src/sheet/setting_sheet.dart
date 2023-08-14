import 'package:flutter/material.dart';

import '../model/option_model.dart';

class SettingSheet extends StatefulWidget {
  final List<OptionModel> featureList;

  const SettingSheet({Key? key, this.featureList = const []}) : super(key: key);

  @override
  State<SettingSheet> createState() => _SettingSheetState();
}

class _SettingSheetState extends State<SettingSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 8),
          shrinkWrap: true,
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: widget.featureList.length,
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) => InkWell(
    borderRadius: index == 0
        ? BorderRadius.vertical(top: Radius.circular(20))
        : null,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(widget.featureList[index].icon, color: Colors.black, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.featureList[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    ),
    onTap: () => widget.featureList[index].onPressFeature.call(),
  );

  Widget _separatorBuilder(BuildContext context, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    height: 1,
    color: Colors.black12,
  );
}
