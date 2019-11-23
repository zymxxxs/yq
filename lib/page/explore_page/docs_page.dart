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
    var data = await YqApi().explore.docs(limits: 20);
    _dataSource = (data is List) ? data : [];
    if (_dataSource.length > 0) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      child: ListView.builder(
        itemBuilder: (context, index) {
          Map<String, dynamic> info = _dataSource[index];
          return buildItem(info);
        },
        itemCount: _dataSource.length,
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
    );
  }

  Widget buildItem(Map<String, dynamic> info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                info['title'],
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                info['custom_description'] ?? info['description'] ?? "",
                style: Theme.of(context).textTheme.caption,
                maxLines: 3,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
