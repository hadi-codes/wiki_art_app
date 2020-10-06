import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';
import 'package:wiki_art/pages/pages.dart';

var splashPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Container(
    child: Text("splash"),
  );
});

var mostViewedPaintingPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomePage();
});

var artistPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  var json = jsonDecode(params["painting"][0]);
  return ArtistPage(
    painting: Painting.fromJson(json),
  );
});

var demoFunctionHandler = Handler(
    type: HandlerType.function,
    // ignore: missing_return
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String message = params["message"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Hey Hey!",
              style: TextStyle(
                color: const Color(0xFF00D6F7),
                fontFamily: "Lazer84",
                fontSize: 22.0,
              ),
            ),
            content: Text("$message"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("OK"),
                ),
              ),
            ],
          );
        },
      );
    });
