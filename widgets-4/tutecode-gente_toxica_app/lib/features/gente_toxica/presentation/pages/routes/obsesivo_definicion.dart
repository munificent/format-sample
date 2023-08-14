import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gente_toxica_app/features/gente_toxica/presentation/utils/constants.dart';
import 'package:gente_toxica_app/features/gente_toxica/presentation/utils/text_styles.dart';

class ObsesivoDefinicion extends StatelessWidget {
  const ObsesivoDefinicion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        elevation: 0,
        title: Text('Definición', style: titleAppBar, textScaleFactor: 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: kMargin,
              child: RichText(
                textScaleFactor: kTextScale,
                text: TextSpan(
                  text: '¿Qué son las obsesiones? Las obsesiones, '
                      'un problema actual bastante común, '
                      'son pensamientos, impulsos o imágenes recurrentes '
                      'que se viven como intrusivos y causan ansiedad y angustia.',
                  style: monoRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
