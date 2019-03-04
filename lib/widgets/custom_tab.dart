import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {
  final Function(int) tabSelected;
  final List<String> str;

  CustomTab({this.tabSelected, this.str});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomTabState();
  }
}

class CustomTabState extends State<CustomTab> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getList();
  }

  Widget _getList() {
    return Container(
      height: 50.0,
      child: ListView.builder(
          itemCount: widget.str.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return getItem(index);
          }),
      color: Colors.grey[200].withAlpha(200),
    );
  }

  Widget getItem(index) {
    return InkWell(
        onTap: () {
          setSelecter(index);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0),
              padding: EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 7.0, bottom: 7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  color:
                      _selected == index ? Colors.redAccent[100] : Colors.red,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2.0, 2.0),
                      color: Colors.grey[500],
                    ),
                  ]),
              child: Text(
                widget.str[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }

  void setSelecter(index) {
    widget.tabSelected(index);
    setState(() {
      _selected = index;
    });
  }
}
