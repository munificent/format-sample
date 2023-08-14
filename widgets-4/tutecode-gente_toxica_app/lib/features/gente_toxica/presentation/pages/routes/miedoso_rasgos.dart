import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gente_toxica_app/features/gente_toxica/presentation/utils/constants.dart';
import 'package:gente_toxica_app/features/gente_toxica/presentation/utils/text_styles.dart';

class MiedosoRasgos extends StatelessWidget {
  const MiedosoRasgos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        elevation: 0,
        title: Text(
          'Rasgos',
          style: titleAppBar,
          textScaleFactor: 1.0,
        ),
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
                  text: ' ● Se sienten observados mientras comparten '
                      'alguna actividad en grupo.',
                  style: monoRegular,
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n\n ● No quieren hablar en público, '
                          'hacen todo lo posible por pasar desapercibidos.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text: '\n\n ● No les gusta comer en público.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text: '\n\n ● Les da mucha vergüenza ser tema de '
                          'conversación de otros o que hagan chistes sobre ellos.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text:
                          '\n\n ● Evitan saludar a personas famosas o de autoridad.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text:
                          '\n\n ● Se ruborizan cuando están frente a situaciones que los incomodan.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text: '\n\n ● Evitan la mirada de los otros por temor a '
                          'ser juzgados, o no validados.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text: '\n\n ● Sienten palpitaciones, temblores, '
                          'sudoración frente a situaciones que sienten no controlar, '
                          'frente a la posible crítica de otros.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text: '\n\n ● Poseen sentimientos de inferioridad, '
                          'no se sienten capaces de asumir desafíos.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text:
                          '\n\n ● Tienen miedo a ponerle límites a los demás y '
                          'que por eso dejen de amarlos o los rechacen.',
                      style: monoRegular,
                    ),
                    TextSpan(
                      text: '\n\n ● Generalmente tienen baja autoestima.',
                      style: monoRegular,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
