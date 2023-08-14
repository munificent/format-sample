import 'package:flutter/material.dart';
import 'package:hepitrack/models/symptom.dart';
import 'package:hepitrack/providers/track_symptom_provider.dart';
import 'package:hepitrack/screens/symptom_page.dart';
import 'package:hepitrack/utils/db.dart';
import 'package:provider/provider.dart';

class TrackSymptom extends StatefulWidget {
  TrackSymptom({Key key}) : super(key: key);

  @override
  _TrackSymptomState createState() => _TrackSymptomState();
}

class _TrackSymptomState extends State<TrackSymptom> {
  _addNewSymptom({int index}) async {
    var list =
        Provider.of<TrackSymptomProvider>(context, listen: false).symptomList;

    SymptomPage addSymptom;
    if (index != null) {
      var currentItem = list[index];
      addSymptom = SymptomPage(symptomTrackItem: currentItem.copy());
    } else {
      addSymptom = SymptomPage();
    }

    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => addSymptom),
    );
    if (result != null) {
      if (index == null) {
        list.add(result);
      } else {
        list[index] = result;
      }
      Provider.of<TrackSymptomProvider>(context, listen: false).symptomList =
          list;
    }
  }

  _removeSymptom(int index) async {
    var currentList =
        Provider.of<TrackSymptomProvider>(context, listen: false).symptomList;

    currentList.removeAt(index);
    Provider.of<TrackSymptomProvider>(context, listen: false).symptomList =
        currentList;
  }

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<TrackSymptomProvider>(context)
        .symptomList
        .asMap()
        .entries
        .map(
          (entry) => FutureBuilder<Symptom>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  onTap: () => _addNewSymptom(index: entry.key),
                  leading: SizedBox(
                    width: 32,
                    height: 32,
                    child: Image.asset(snapshot.data.image) ??
                        Image.asset(
                          'assets/tracking/symptom.png',
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  title: Text(
                    snapshot.data.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: IconButton(
                    onPressed: () => _removeSymptom(entry.key),
                    icon: Icon(Icons.delete),
                  ),
                );
              } else {
                return Container();
              }
            },
            future: DB.symptom(entry.value.symptom),
          ),
        )
        .toList();

    list.add(
      FutureBuilder<Symptom>(
        builder: (context, snapshot) {
          return ListTile(
            onTap: () => _addNewSymptom(),
            leading: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
              size: 48,
            ),
            title: Text(
              'Add new',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        },
      ),
    );

    return ListView(
      children: list,
    );
  }
}
