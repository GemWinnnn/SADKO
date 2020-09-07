import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/widgets/app_brand_horizontal.dart';
import 'package:wvsu_tour_app/config/app.dart';

class ThankyouFrontlinersScreen extends StatefulWidget {
  ThankyouFrontlinersScreen({Key key}) : super(key: key);

  @override
  _ThankyouFrontlinersScreenState createState() =>
      _ThankyouFrontlinersScreenState();
}

class _ThankyouFrontlinersScreenState extends State<ThankyouFrontlinersScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: appSecondaryColor,
        image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            image: AssetImage('assets/images/frontliners-bg.png')),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBrandHorizontal(),
                ],
              ),
              SizedBox(
                height: appScreenSize.height * 0.1,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: appScreenSize.width * 0.1),
                child: Text(
                  "A special screen for our dedicated frontliners! Thank you for all your sacrifices!",
                  style: GoogleFonts.lato(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Feather.heart,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("1,000",
                      style:
                          GoogleFonts.lato(fontSize: 60, color: Colors.white))
                ],
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              AvatarGlow(
                endRadius: 60.0,
                child: Material(
                  elevation: 0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {}),
                    radius: 30.0,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Double tap the heart to send a thank you to our modern heroes!",
                    style: GoogleFonts.lato(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
