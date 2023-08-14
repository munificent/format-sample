import 'package:flutter/material.dart';
import 'package:num_cluster/colors.dart';

class MatrixInput extends StatelessWidget {
  final int rowCounter;
  final int columnCounter;
  final bool isVisible;
  final ValueChanged<String> onChanged;
  final GestureTapCallback cancelPressed;
  final GestureTapCallback donePressed;
  final GestureTapCallback rowAddPressed;
  final GestureTapCallback rowSubtractPressed;
  final GestureTapCallback columnAddPressed;
  final GestureTapCallback columnSubtractPressed;

  const MatrixInput({
    Key key,
    this.isVisible = false,
    this.donePressed,
    this.onChanged,
    this.rowAddPressed,
    this.rowSubtractPressed,
    this.columnAddPressed,
    this.columnSubtractPressed,
    this.rowCounter,
    this.columnCounter,
    this.cancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: !isVisible,
        child: Container(
          height: size.height,
          width: size.width,
          color: CustomColors.blackColor.withAlpha(140),
          child: Center(
            child: Container(
              height: 460,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Material(
                    color: CustomColors.transparent,
                    child: InkWell(
                      onTap: cancelPressed,
                      borderRadius: BorderRadius.circular(35),
                      child: Container(
                        height: 70,
                        width: size.width * 0.7,
                        decoration: BoxDecoration(
                          color: CustomColors.primaryColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 70,
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: CustomColors.primaryColor),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Matrix'),
                          onChanged: onChanged,
                          style: TextStyle(fontSize: 22),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Note: Separate each value of matrix by comma',
                      textAlign: TextAlign.center),
                  const Spacer(),
                  Row(children: [
                    const SizedBox(width: 20),
                    Counter(
                      title: 'Rows',
                      counter: rowCounter,
                      addPressed: rowAddPressed,
                      subtractPressed: rowSubtractPressed,
                    ),
                    const Spacer(),
                    Counter(
                      title: 'Columns',
                      counter: columnCounter,
                      addPressed: columnAddPressed,
                      subtractPressed: columnSubtractPressed,
                    ),
                    const SizedBox(width: 20),
                  ]),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 70,
                        width: size.width * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: CustomColors.primaryColor),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Material(
                          color: CustomColors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(35),
                            onTap: donePressed,
                            child: Center(
                              child: Text('Done',
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: CustomColors.blackColor)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String title;
  final int counter;
  final GestureTapCallback addPressed;
  final GestureTapCallback subtractPressed;

  const Counter(
      {Key key,
      @required this.title,
      this.counter,
      this.addPressed,
      this.subtractPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.3,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 24,
                color: CustomColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Divider(
            height: 10,
            color: CustomColors.primaryColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: CustomColors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: subtractPressed,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 3, color: CustomColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.exposure_minus_1,
                      size: 28,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    counter.toString(),
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Material(
                color: CustomColors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: addPressed,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 3, color: CustomColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.exposure_plus_1,
                      size: 28,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
