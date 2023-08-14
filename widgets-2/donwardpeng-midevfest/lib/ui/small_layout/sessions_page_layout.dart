import 'package:flutter_web/material.dart';
import 'dart:html';

class SessionsPageSmallBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double _height = size.height;
    final double _width = size.width;

    return Container(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
      Padding(
          padding: EdgeInsets.only(top: _height / 4),
          child: Card(
              elevation: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: InkWell(
                          onTap: () {
                            window.open('https://firebasestorage.googleapis.com/v0/b/midevfest.appspot.com/o/images%2Fschedule%2Fschedule.jpg?alt=media&token=74f79d57-2eb2-4128-a40e-f001b132074a', 'Schedule');
                          },
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Tentative Schedule can be downloaded',
                              style: Theme.of(context).textTheme.title,
                            ),
                            TextSpan(
                                text: ' here. ',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .apply(color: Colors.blue)),
                            TextSpan(
                              text:
                                  'We will finalize the schedule one week before the event.',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ]))))
                ],
              ))),
    ])) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
