import 'package:flutter/material.dart';
import '../component/end_child.dart';
import '../component/start_child.dart';
import '../component/timeline_indicator.dart';
import '../core/model/repo.dart';
import '../core/service/repo.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'about.dart';

class TimeLinePage extends StatefulWidget {
  final String username;
  const TimeLinePage({Key? key, required this.username}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  get username => widget.username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          username,
          // ignore: prefer_const_constructors
          style:
              TextStyle(fontFamily: 'SpaceMono', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutPage())),
          )
        ],
      ),
      body: FutureBuilder(
          future: getRepos(username),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('error: ${snapshot.error}'),
                  );
                } else {
                  final List<RepoModel> data = snapshot.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) => TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.3,
                            beforeLineStyle:
                                LineStyle(color: Colors.black.withOpacity(0.1)),
                            indicatorStyle: IndicatorStyle(
                              indicatorXY: 0.3,
                              drawGap: true,
                              width: 30,
                              height: 30,
                              indicator: TimelineIndicator(
                                isFork: data.elementAt(index).fork,
                              ),
                            ),
                            isFirst: index == 0,
                            isLast: index == data.length - 1,
                            startChild: StartChild(data: data, index: index),
                            endChild: EndChild(data: data, index: index),
                          ));
                }
            }
          }),
    );
  }
}
