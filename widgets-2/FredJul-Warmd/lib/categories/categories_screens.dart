import 'dart:ui';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:markup_text/markup_text.dart';
import 'package:provider/provider.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/criteria.dart';
import 'package:warmd/common/delayable_state.dart';
import 'package:warmd/common/extensions.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/common/states.dart';
import 'package:warmd/common/widgets.dart';
import 'package:warmd/translations/gen/l10n.dart';

class UtilitiesCategoryScreen extends StatelessWidget {
  const UtilitiesCategoryScreen({Key? key, required this.onContinueTapped})
      : super(key: key);

  final Function(BuildContext) onContinueTapped;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    return _CriteriasScreen(
        criteriaCategory: state.categories[1],
        progressValue: 0.3,
        onContinueTapped: onContinueTapped);
  }
}

class TravelCategoryScreen extends StatelessWidget {
  const TravelCategoryScreen({Key? key, required this.onContinueTapped})
      : super(key: key);

  final Function(BuildContext) onContinueTapped;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    return _CriteriasScreen(
        criteriaCategory: state.categories[2],
        progressValue: 0.5,
        onContinueTapped: onContinueTapped);
  }
}

class FoodCategoryScreen extends StatelessWidget {
  const FoodCategoryScreen({Key? key, required this.onContinueTapped})
      : super(key: key);

  final Function(BuildContext) onContinueTapped;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    return _CriteriasScreen(
        criteriaCategory: state.categories[3],
        progressValue: 0.7,
        onContinueTapped: onContinueTapped);
  }
}

class GoodsCategoryScreen extends StatelessWidget {
  const GoodsCategoryScreen({Key? key, required this.onContinueTapped})
      : super(key: key);

  final Function(BuildContext) onContinueTapped;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    return _CriteriasScreen(
        criteriaCategory: state.categories[4],
        progressValue: 0.9,
        onContinueTapped: onContinueTapped);
  }
}

class _CriteriasScreen extends StatefulWidget {
  const _CriteriasScreen(
      {Key? key,
      required this.criteriaCategory,
      required this.progressValue,
      required this.onContinueTapped})
      : super(key: key);

  final CriteriaCategory criteriaCategory;
  final double progressValue;
  final Function(BuildContext) onContinueTapped;

  @override
  _CriteriasScreenState createState() => _CriteriasScreenState();
}

class _CriteriasScreenState extends DelayableState<_CriteriasScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CriteriaState>();

    return ScreenTemplate(
      progressValue: widget.progressValue,
      scrollController: _scrollController,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/${widget.criteriaCategory.key}.svg',
              height: 96,
            ),
            const Gap(16),
            Text(
              widget.criteriaCategory.title(),
              style: context.textTheme.headline5
                  ?.copyWith(color: warmdGreen, fontWeight: FontWeight.bold),
            ),
            const Gap(32),
            // We display all criterias, except the one that are necessarily at a specific value (like clean energy percent for some countries)
            for (Criteria crit in widget.criteriaCategory.getCriteriaList())
              // We hide the CarConsumptionCriteria is we don't use car
              if (crit is! CarConsumptionCriteria ||
                  state.travelCategory.carCriteria.currentValue > 0)
                _buildCriteria(context, state, crit),
            const Gap(32),
            Text(
              Translation.current.continueActionExplanation,
              textAlign: TextAlign.center,
              style:
                  context.textTheme.subtitle2?.copyWith(color: warmdDarkBlue),
            ),
            const Gap(24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // We want to scroll back to the top, so that we can clearly see in what category we arrive
                  delay(500.milliseconds, () => _scrollController.jumpTo(0));

                  widget.onContinueTapped(context);
                },
                child: Text(Translation.current.continueAction),
              ),
            ),
            const Gap(48),
          ],
        ),
      ),
    );
  }

  Widget _buildCriteria(BuildContext context, CriteriaState state, Criteria c) {
    final explanation = c.explanation();

    return BlueCard(
      padding: const EdgeInsets.only(top: 28, bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    c.title(),
                    style: context.textTheme.subtitle1?.copyWith(
                        color: warmdDarkBlue, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(12),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 42, maxWidth: 42),
                  child: SvgPicture.asset(
                    'assets/${c.key}.svg',
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          if (explanation != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: MarkupText(
                explanation,
                style: context.textTheme.bodyText2?.copyWith(
                    color: Colors.grey[600], fontWeight: FontWeight.w300),
              ),
            ),
          const Gap(8),
          if (c.labels() != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _buildDropdown(context, c, state),
            )
          else
            _buildSlider(c, context, state),
          if (c.shortcuts() != null)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 32, right: 32),
              child: _buildShortcutChips(context, state, c),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, Criteria c, CriteriaState state) {
    final labels = c.labels()!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<int>(
            isExpanded: true,
            selectedItemBuilder: (BuildContext context) {
              return labels.map((String item) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyText2,
                    ),
                  ],
                );
              }).toList();
            },
            value: c.currentValue.toInt(),
            underline: Container(),
            onChanged: (int? value) {
              c.currentValue = value!.toDouble();
              state.persist(c);
            },
            items: labels
                .mapIndexed(
                  (index, label) => DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      label,
                      style: context.textTheme.bodyText2
                          ?.copyWith(color: _getDropdownTextColor(c, index)),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Color _getDropdownTextColor(Criteria c, int value) {
    if (c is CountryCriteria) return Colors.black;

    if (value == c.minValue) {
      return Colors.green;
    } else if (value == c.maxValue) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  Widget _buildSlider(Criteria c, BuildContext context, CriteriaState state) {
    final unit = c.unit != null ? ' ${c.unit}' : '';
    final valueWithUnit =
        NumberFormat.decimalPattern().format(c.currentValue.abs()) + unit;

    const valueTextStyle = TextStyle(color: warmdDarkBlue);

    String valueToShortString(double value) {
      final intValue = value.abs().round();
      if (intValue < 1000) {
        return intValue.toString();
      } else {
        return '${intValue ~/ 1000}K';
      }
    }

    final quarter = (c.maxValue - c.minValue) / 4;
    final valueText1 = valueToShortString(c.minValue);
    final valueText2 = valueToShortString(c.minValue + quarter);
    final valueText3 = valueToShortString(c.minValue + 2 * quarter);
    final valueText4 = valueToShortString(c.minValue + 3 * quarter);
    final valueText5 = valueToShortString(c.maxValue);

    final shouldDisplayOnlyThreeValues = valueText2 == valueText1 ||
        valueText2 == valueText3 ||
        valueText4 == valueText3 ||
        valueText4 == valueText5;

    final labels = c.labels();

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor:
              0.92, // We need this to be aligned with the number's row below. Not perfect, could this be improved by using LayoutBuilder?
          child: Slider(
            min: c.minValue,
            max: c.maxValue,
            divisions: (c.maxValue - c.minValue) ~/ c.step,
            label: labels != null
                ? labels[c.currentValue.toInt()]
                : c.currentValue != c.maxValue ||
                        c.unit ==
                            '%' // We can't go above 100% so we don't display "or more"
                    ? valueWithUnit
                    : c.minValue <
                            0 // Some values are negatives because more is better (like mpg)
                        ? Translation.current.valueWithLess(valueWithUnit)
                        : Translation.current.valueWithMore(valueWithUnit),
            value: c.currentValue,
            onChanged: (double value) {
              c.currentValue = value;
              state.persist(c);
            },
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Center(child: Text(valueText1, style: valueTextStyle))),
            if (!shouldDisplayOnlyThreeValues)
              Expanded(
                  child:
                      Center(child: Text(valueText2, style: valueTextStyle))),
            Expanded(
                child: Center(child: Text(valueText3, style: valueTextStyle))),
            if (!shouldDisplayOnlyThreeValues)
              Expanded(
                  child:
                      Center(child: Text(valueText4, style: valueTextStyle))),
            Expanded(
              child: Center(
                  child: Text(
                      valueText5 + (c.minValue < 0 || c.unit == '%' ? '' : '+'),
                      style: valueTextStyle)),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildShortcutChips(
      BuildContext context, CriteriaState state, Criteria c) {
    final shortcuts = c.shortcuts()!;

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        children: [
          ...shortcuts.entries.map(
            (entry) => ActionChip(
              label: Text(
                entry.key,
                style: const TextStyle(color: warmdDarkBlue),
              ),
              shape:
                  const StadiumBorder(side: BorderSide(color: warmdDarkBlue)),
              backgroundColor: warmdLightBlue,
              onPressed: () {
                c.currentValue = entry.value;
                state.persist(c);
              },
            ),
          )
        ],
      ),
    );
  }
}
