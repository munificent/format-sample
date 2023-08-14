import 'package:flutter/material.dart';

import '../textfield/master_text_field.dart';

typedef BuildCustomOption = Widget Function(
  BuildContext context,
  AutocompleteItem autocompleteItem,
);
typedef BuildCustomInput = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  Function() onFieldSubmitted,
);

typedef CustomSearchFilter = bool Function(
  String value,
  AutocompleteItem item,
);


class MasterAutoComplete extends StatelessWidget {
  final List<AutocompleteItem> items;
  final Function(AutocompleteItem)? onSelected;
  final BuildCustomOption? buildCustomOption;
  final BuildCustomInput? buildCustomInput;
  final CustomSearchFilter? customSearchFilter;
  final double height;
  const MasterAutoComplete({
    super.key,
    required this.items,
    this.onSelected,
    this.buildCustomOption,
    this.buildCustomInput,
    this.customSearchFilter,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<AutocompleteItem>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) return const Iterable<AutocompleteItem>.empty();
        return items.where((item) {
          return customSearchFilter != null
              ? customSearchFilter!(value.text, item)
              : item.title.toLowerCase().contains(value.text.toLowerCase());
        });
      },
      displayStringForOption: (option) => option.title,
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Card(
            child: SizedBox(
              height: height,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  AutocompleteItem option = options.elementAt(index);
                  return buildCustomOption != null
                      ? buildCustomOption!(context, option)
                      : ListTile(
                          onTap: () => onSelected(option),
                          title: Text(option.title),
                          subtitle: option.subtitle != null
                              ? Text(option.subtitle!)
                              : null,
                          leading: option.leading,
                          trailing: option.trailing,
                        );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) {
        return buildCustomInput != null
            ? buildCustomInput!(
                context,
                textEditingController,
                focusNode,
                onFieldSubmitted,
              )
            : MasterTextField(
                hintText: 'Search',
                focusNode: focusNode,
                controller: textEditingController,
              );
      },
      onSelected: onSelected,
      optionsMaxHeight: height,
    );
  }
}

class AutocompleteItem {
  final String title;
  final String value;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;

  const AutocompleteItem({
    required this.title,
    required this.value,
    this.subtitle,
    this.leading,
    this.trailing,
  });
}
