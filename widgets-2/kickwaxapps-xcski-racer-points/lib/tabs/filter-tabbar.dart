import 'package:xcp/db.dart';
import 'package:xcp/stores/global.dart';
import 'package:xcp/tabs/filter-form/filter.dart';
import 'package:xcp/tabs/filter-tabbar-model.dart';
import 'package:xcp/tabs/list-tab-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class FilterTabbar extends StatefulWidget {
  @override
  _FilterTabbarState createState() => _FilterTabbarState();
}

class _FilterTabbarState extends State<FilterTabbar>
    with TickerProviderStateMixin {
  static const defaultLayout = {'tabs': [], 'currentIndex': -1};

  FilterTabbarModel model;

  @override
  void initState() {
    final db = DB();
    final tabs = db.getPref('tabs');
    final layout = tabs.isEmpty ? defaultLayout : json.decode(tabs);

    model = FilterTabbarModel(this, layout, context);
    super.initState();
  }

  @override
  void dispose() {
    model.controller.dispose();
    super.dispose();
  }

  @override
  build(BuildContext ctx) {
    return Provider<FilterTabbarModel>.value(value: model, child: body());
  }

  Widget body() {
    final global = Provider.of<GlobalStore>(context);

    global.addFreeFormListBuilder = () => model.addTab(type: TAB_LIST_BUILDER);

    final db = DB();
    final x = Observer(builder: (ctx) {
      db.setPref('tabs', json.encode(model.toJson));
      final v = db.getPref('tabs');
      return Text('hello');
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.grey,
            child: Row(children: [
              Observer(
                builder: (ctx) => Flexible(
                    flex: 10,
                    child: Container(
                      color: Colors.grey,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: 200.0 * model.count,
                            minWidth: 110.0 * model.count),
                        child: TabBar(
                            isScrollable: true,
                            controller: model.controller,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.white,
                            indicator: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  left: BorderSide(),
                                  right: BorderSide(),
                                  top: BorderSide()),
                            ),
                            tabs: () {
                              final tabIcons = [
                                Icons.filter_list,
                                Icons.contacts,
                                Icons.recent_actors,
                                Icons.query_builder
                              ];
                              final x = List.generate(
                                  model.count,
                                  (i) => Observer(builder: (ctx) {
                                        final ict = tabIcons[
                                                model.tabs[i].model.type],
                                            filterBtn = model.currentIndex ==
                                                        i &&
                                                    ict == Icons.filter_list
                                                ? Icon(ict, color: Colors.blue)
                                                : Icon(ict);

                                        return Tab(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              border:
                                                  Border(right: BorderSide())),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                i == model.currentIndex
                                                    ? Filter(model.tabs[i].model
                                                        .skierFilterContextModel)
                                                    : filterBtn,
                                                Tooltip(
                                                    message: model
                                                        .tabs[i].model.title,
                                                    child: Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                minWidth: 50,
                                                                maxWidth: 100),
                                                        child: ClipRect(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              model.tabs[i]
                                                                  .model.title,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                            ),
                                                            Text(
                                                              model
                                                                  .tabs[i]
                                                                  .model
                                                                  .subTitle,
                                                              style: TextStyle(
                                                                  fontSize: 8),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                            ),
                                                          ],
                                                        )))),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: InkWell(
                                                        hoverColor: Colors.grey,
                                                        child: Icon(Icons.close,
                                                            size: 25),
                                                        onTap: () =>
                                                            model.deleteTab(i)))
                                              ]),
                                        ));
                                      }));

                              return x;
                            }()),
                      ),
                    )),
              ),
              FlatButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    model.addTab(type: TAB_POINTS_LIST);
                  }),
              Spacer()
            ]),
          ),
          Expanded(child: Observer(
            builder: (ctx) {
              return TabBarView(
                  controller: model.controller,
                  children: List.generate(model.count, (i) => model.tabs[i]));
            },
          )),
          Offstage(child: x)
        ]);
  }
}
