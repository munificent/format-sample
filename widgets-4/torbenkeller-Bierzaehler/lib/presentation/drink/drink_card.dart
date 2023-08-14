import 'package:bierzaehler/domain/drink/drink.dart';
import 'package:bierzaehler/domain/drink/price.dart';
import 'package:bierzaehler/presentation/drink/price_change_dialog_route.dart';
import 'package:flutter/material.dart';

class DrinkCard extends StatefulWidget {
  const DrinkCard({Key key, this.drink}) : super(key: key);

  final Drink drink;

  @override
  _DrinkCardState createState() => _DrinkCardState();
}

class _DrinkCardState
    extends State<DrinkCard> //    with SingleTickerProviderStateMixin {
{
  Price _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedPrice =
        (widget.drink.prices.isNotEmpty) ? widget.drink.prices.first : null;
  }

  String priceToFancyString(Price p) =>
      '${p.price.toStringAsFixed(2).replaceAll('.', ',')}€';

  String sizeToFancyString() =>
      '${widget.drink.size.toStringAsFixed(2).replaceAll('.', ',')}l';

//  Future<void> _showPopupMenu(BuildContext context) async {
//    final RenderBox overlay =
//        Overlay.of(context).context.findRenderObject() as RenderBox;
//    final RenderBox renderBox = context.findRenderObject() as RenderBox;
//    final Offset position = renderBox.localToGlobal(Offset.zero);
//    final int selectedPrice = await showMenu<int>(
//      context: context,
//      initialValue: (_selectedPrice.priceID) ?? -1,
//      elevation: 8.0,
//      shape: const RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(Radius.circular(15.0))),
//      position: RelativeRect.fromRect(
//        //-140 cause menu constrains hav a maxWidth of 280
//        Rect.fromLTWH(position.dx + (renderBox.size.height / 2) - 140,
//            position.dy + renderBox.size.height, 0, 0),
//        overlay.semanticBounds,
//      ),
//      items: <PopupMenuEntry<int>>[
//
//      ],
//    );
//    if (selectedPrice == null) return;
//    setState(() {
//      _selectedPrice = widget.drink.prices.firstWhere(
//          (Price price) => price.priceID == selectedPrice,
//          orElse: () => null);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              onLongPress: () async {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final Offset position = renderBox.localToGlobal(Offset.zero);
                int newPrice = await Navigator.of(context).push(
                  PriceChangeDialogRoute(
                      position: Size(
                          position.dx + (renderBox.size.height / 2) - 140,
                          position.dy + renderBox.size.height),
                      selectedPrice: _selectedPrice,
                      drink: widget.drink,
                      theme: Theme.of(context)),
                );
              },
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(sizeToFancyString()),
                    if (_selectedPrice != null)
                      Text(priceToFancyString(_selectedPrice))
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
