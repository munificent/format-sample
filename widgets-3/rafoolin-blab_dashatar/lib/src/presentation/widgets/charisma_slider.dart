import 'package:flutter/material.dart';

import '../../logic/logic.dart';

class CharismaSlider extends StatelessWidget {
  const CharismaSlider();

  @override
  Widget build(BuildContext context) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text('Charisma: '),
          StreamBuilder<double>(
            stream: filterBloc.charismaStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.hasError) return Container();

              return Slider.adaptive(
                label: '${snapshot.data}',
                divisions: 5,
                min: 0,
                max: 5,
                value: snapshot.data,
                onChanged: (charisma) {
                  filterBloc.addCharisma(charisma);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
