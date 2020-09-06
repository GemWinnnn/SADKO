import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:wvsu_tour_app/config/app.dart';

class LegalScreen extends StatefulWidget {
  LegalScreen({Key key}) : super(key: key);

  @override
  _LegalScreenState createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  String _markdownPrivacy = "";
  String _markdownTerms = "";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getDocData();
  }

  Future<void> getDocData() async {
    this.setState(() {
      _loading = true;
    });
    var privacyResponse = await http.get(
        "https://raw.githubusercontent.com/wvsu-cict-code/wvsu-tour-app/master/privacy.md");
    if (privacyResponse.statusCode == 200) {
      this.setState(() {
        _markdownPrivacy = privacyResponse.body;
      });
    } else {
      print('Request failed with status: ${privacyResponse.statusCode}.');
    }

    var termsResponse = await http.get(
        "https://raw.githubusercontent.com/wvsu-cict-code/wvsu-tour-app/master/terms_and_conditions.md");
    if (termsResponse.statusCode == 200) {
      this.setState(() {
        _markdownTerms = termsResponse.body;
        _loading = false;
      });
    } else {
      print('Request failed with status: ${termsResponse.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Legal",
              style: GoogleFonts.lato(color: Colors.black),
            ),
            leading: IconButton(
                icon: Icon(
                  Feather.arrow_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: appDefaultPadding),
                child: Markdown(data: "$_markdownPrivacy \n$_markdownTerms"),
              ),
              _loading == true
                  ? Center(child: CircularProgressIndicator())
                  : Container()
            ],
          )),
    );
  }
}
