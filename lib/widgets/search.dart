import 'package:flutter/material.dart';
import 'package:flutter_news/localization/my_locations.dart';
import 'package:flutter_news/page/search/search_page.dart';

class Search extends StatelessWidget {
  BuildContext _context;
  TextEditingController _controller = new TextEditingController();
  MyLocation mLanguage;

  submit(query) {
    Navigator.of(_context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return SearchPage.create(query);
    }));
  }

  @override
  Widget build(BuildContext context) {
    mLanguage = MyLocation.of(context);
    _context = context;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent),
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              cursorColor: Colors.lightGreen,
              //光标颜色
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: mLanguage.trans('hint_busca'),
                  hintStyle: TextStyle(color: Colors.redAccent),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.redAccent,
                  )),
              onSubmitted: submit,
              maxLines: 1,
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }
}
