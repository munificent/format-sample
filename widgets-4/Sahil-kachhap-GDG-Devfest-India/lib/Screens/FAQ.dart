import 'dart:convert';
import 'package:event_app/ThemeBloc/AppTheme.dart';
import 'package:event_app/ThemeBloc/Theme_Event.dart';
import 'package:event_app/ThemeBloc/export.dart';
import 'package:event_app/UI_Components/Expandable_Cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:share/share.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool _isThemeSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'FAQ',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              letterSpacing: 1.0,
              fontFamily: 'OpenSans',
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon:  Theme.of(context).brightness == Brightness.dark
                  ? Icon(FontAwesomeIcons.sun)
                  : Icon(FontAwesomeIcons.moon),
              onPressed: () {
                _isThemeSwitch = _isThemeSwitch ? false : true;
                setState(() {
                  if (_isThemeSwitch) {
                    BlocProvider.of<ThemeBloc>(context)
                        .dispatch(ThemeEvent(theme: Themes.DarkTheme));
                  } else {
                    BlocProvider.of<ThemeBloc>(context)
                        .dispatch(ThemeEvent(theme: Themes.LightTheme));
                  }
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
                icon: Icon(Icons.share),
                onPressed:
                    () {} /*=> Share.share(
                  "Download the new GDG DevFest India App and share with your tech friends.\nPlayStore -  ")*/
                )
          ],
        ),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('Assets/JSON/FAQ.json'),
            builder: (context, snapshot) {
              var FaqData = json.decode(snapshot.data.toString());
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return ExpandableCards(
                      answer: FaqData[index]['answer'],
                      question: FaqData[index]['question'],
                    );
                  },
                );
              }else{
                return CircularProgressIndicator();
              }
            }));
  }
}
