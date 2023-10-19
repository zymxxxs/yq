import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yq/api/yq_api.dart';

class DocsPage extends StatefulWidget {
  @override
  DocsPageState createState() => DocsPageState();
}

class DocsPageState extends State<DocsPage> with AutomaticKeepAliveClientMixin {
  List _dataSource = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    var data = await YqApi().explore.docs(limit: 20);
    _dataSource = (data is List) ? data : [];
    print(_dataSource.length);
    if (_dataSource.length > 0) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      child: ListView.separated(
        itemBuilder: (context, index) {
          Map<String, dynamic> info = _dataSource[index];
          return buildItem(info, index);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1);
        },
        itemCount: _dataSource.length,
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
    );
  }

  Widget buildItem(Map<String, dynamic> info, int index) {
    TextStyle topTextStyle = TextStyle(
      color: index < 3 ? Color(0xfffa541c) : Color(0xffbfbfbf),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            child: Text(
              (index + 1).toString(),
              maxLines: 1,
              style: topTextStyle,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  info['title'],
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  info['custom_description'] ?? info['description'] ?? "",
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
