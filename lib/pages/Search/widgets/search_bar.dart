import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key, this.onChanged}) : super(key: key);
  final ValueSetter<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: false,
      snap: false,
      floating: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(15.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor, width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).backgroundColor,
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () => print('Search')),
                border: InputBorder.none,
                hintText: "Search",
                contentPadding: EdgeInsets.all(10.0)),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
