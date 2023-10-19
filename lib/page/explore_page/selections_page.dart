import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yq/api/yq_api.dart';

class SelectionsPage extends StatefulWidget {
  @override
  SelectionsPageState createState() => SelectionsPageState();
}

class SelectionsPageState extends State<SelectionsPage>
    with AutomaticKeepAliveClientMixin {
  List _dataSource = [];
  int page = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    page = 1;
    var data = await YqApi().explore.selections(limit: 20, page: page);
    _dataSource = (data is List) ? data : [];
    if (_dataSource.length > 0) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    page++;
    var data = await YqApi().explore.selections(limit: 20, page: page);
    print(data);
    List result = (data is List) ? data : [];
    if (result.length > 0) {
      setState(() {
        _dataSource.addAll(result);
      });
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.separated(
        itemBuilder: (context, index) {
          Map<String, dynamic> info = _dataSource[index];
          return buildItem(info);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1);
        },
        itemCount: _dataSource.length,
      ),
    );
  }

  Widget buildItem(Map<String, dynamic> info) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
