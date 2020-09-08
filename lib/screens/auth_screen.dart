import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/firebase/auth.dart';
import 'package:wvsu_tour_app/screens/facebook_auth_screen.dart';
import 'package:wvsu_tour_app/widgets/app_legal_links.dart';
import 'package:wvsu_tour_app/widgets/app_primary_button.dart';
import 'package:wvsu_tour_app/widgets/app_secondary_button.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _pageState = 0;

  var _backgroundColor = appPrimaryColor;

  var _appIcon = Container();

  double _loginOpacity = 1;
  double _loginYOffset = 0;
  double _signUpYOffset = 0;
  double windowWidth = 0;
  double _loginWidth = 0;
  double _loginXOffset = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  void _showSnackbar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  _loginWithFacebook() async {
    UserCredential userCredential;
    String redirectUri = "https://www.facebook.com/connect/login_success.html";
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FacebookAuthWeb(
                  selectedUrl:
                      'https://www.facebook.com/dialog/oauth?client_id=$facebookAppID&redirect_uri=$redirectUri&response_type=token&scope=email,public_profile,',
                ),
            maintainState: true));
    if (result != null) {
      try {
        setState(() {
          _loading = true;
        });
        final facebookAuthCred = FacebookAuthProvider.credential(result);
        userCredential =
            await widget.auth.signInWithCredentials(facebookAuthCred);
        _showSnackbar("Logged in with Facebook");
        print(userCredential.user.uid);
      } catch (e) {
        setState(() {
          _loading = false;
        });
        print(e);
        _showSnackbar("Failed to sign in with Facebook: ${e}");
      }
    }
  }

  _loginWithGoogle() async {
    try {
      setState(() {
        _loading = true;
      });
      UserCredential userCredential;

      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential =
          await widget.auth.signInWithCredentials(googleAuthCredential);
      _showSnackbar("Logged in with Google");
      print(userCredential.user.uid);
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print(e);
      _showSnackbar("Failed to sign in with Google: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    double appIconSize = appScreenSize.width * 0.2;
    switch (_pageState) {
      case 0:
        _backgroundColor = appPrimaryColor;
        _appIcon = Container(
          child: Column(
            children: [
              Image.asset("assets/images/wvsu-big-logo.png",
                  height: appIconSize),
              SizedBox(height: 20),
              Text(
                "West Visayas State University",
                style: GoogleFonts.lato(color: appSecondaryColor),
              ),
              Text("Campus Tour",
                  style: GoogleFonts.pattaya(
                      color: appSecondaryColor, fontSize: 30))
            ],
          ),
        );
        _loginYOffset = appScreenSize.height;
        _signUpYOffset = appScreenSize.height;
        _loginWidth = appScreenSize.width;
        _loginXOffset = 0;
        break;
      case 1:
        _backgroundColor = appSecondaryColor;
        _loginOpacity = 1;
        _loginYOffset = appScreenSize.height * 0.34;
        _signUpYOffset = appScreenSize.height;
        _loginWidth = appScreenSize.width;
        _loginXOffset = 0;
        break;
      case 2:
        _loginOpacity = 0.9;
        _loginYOffset = appScreenSize.height * 0.35;
        _signUpYOffset = appScreenSize.height * 0.38;
        _backgroundColor = appSecondaryColor;
        _loginWidth = appScreenSize.width - 30;
        _loginXOffset = 10;
        break;
    }

    _switchToState(int _initial, int _final) {
      {
        setState(() {
          _pageState != _initial ? _pageState = _initial : _pageState = _final;
        });

        setState(() {
          _appIcon = Container(
              key: ValueKey(2),
              child: Column(
                children: [
                  WebsafeSvg.asset("assets/icon/icon-light.svg",
                      height: appIconSize),
                  SizedBox(height: 20),
                  Text(
                    "West Visayas State University",
                    style: GoogleFonts.lato(color: Colors.white),
                  ),
                  Text("Campus Tour",
                      style: GoogleFonts.pattaya(
                          color: Colors.white, fontSize: 30))
                ],
              ));
        });

        print(_pageState);
      }
    }

    return new Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              color: _backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: appScreenSize.height * 0.07),
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        AnimatedSwitcher(
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          duration: Duration(milliseconds: 1000),
                          switchInCurve: Curves.fastLinearToSlowEaseIn,
                          child: _appIcon,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: WebsafeSvg.asset(
                        "assets/images/welcome_illustration.svg",
                        height: appScreenSize.width * 0.8),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: SizedBox(
                        width: double.infinity,
                        child: AppPrimaryButton(
                          text: "Let's Go!",
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('WVSU Campus Tour in Beta'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'More features and contents will be added soon.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('I understand.'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _switchToState(0, 1);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ))
                ],
              ),
            ),
            AnimatedContainer(
                padding: EdgeInsets.all(32),
                width: _loginWidth == 0 ? appScreenSize.width : _loginWidth,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                transform:
                    Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_loginOpacity),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login",
                          style: GoogleFonts.lato(fontSize: 27),
                        ),
                        Text(
                          "Select an option to login on an existing account or create a new one.",
                          style: GoogleFonts.lato(),
                        ),
                        SizedBox(height: 20),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: AppPrimaryButton(
                              onPressed: () => _loginWithFacebook(),
                              text: "Login with Facebook",
                              icon: SimpleLineIcons.social_facebook,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SizedBox(
                              width: double.infinity,
                              child: AppPrimaryButton(
                                text: "Login with Google",
                                icon: SimpleLineIcons.social_google,
                                onPressed: () => _loginWithGoogle(),
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: SizedBox(
                                width: double.infinity,
                                child: AppSecondaryButton(
                                  text: "Create a New Account",
                                  onPressed: () {
                                    this.setState(() {
                                      _pageState != 2
                                          ? _pageState = 2
                                          : _pageState = 1;
                                    });
                                    print(_pageState);
                                  },
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        AppLegalLinks()
                      ],
                    ),
                    Positioned(
                        top: -10,
                        right: 0,
                        child: IconButton(
                          icon: Icon(SimpleLineIcons.close,
                              color: appSecondaryColor),
                          onPressed: () {
                            setState(() {
                              _pageState != 0 ? _pageState = 0 : _pageState = 1;
                            });

                            setState(() {
                              _appIcon = Container(
                                  key: ValueKey(2),
                                  child: Column(
                                    children: [
                                      WebsafeSvg.asset(
                                          "assets/icon/icon-light.svg",
                                          height: appIconSize),
                                      SizedBox(height: 20),
                                      Text(
                                        "West Visayas State University",
                                        style: GoogleFonts.lato(
                                            color: Colors.white),
                                      ),
                                      Text("Campus Tour",
                                          style: GoogleFonts.pattaya(
                                              color: Colors.white,
                                              fontSize: 30))
                                    ],
                                  ));
                            });

                            print(_pageState);
                          },
                        ))
                  ],
                )),
            AnimatedContainer(
              padding: EdgeInsets.all(32),
              width: double.infinity,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _signUpYOffset, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Create an Account",
                      style: GoogleFonts.lato(fontSize: 27),
                    ),
                    Text(
                      "Select an option to create a new account.",
                      style: GoogleFonts.lato(),
                    ),
                    SizedBox(height: 20),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: FlatButton.icon(
                              color: Color(0xFF075BB3),
                              padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                              onPressed: () {},
                              icon: Icon(SimpleLineIcons.social_facebook),
                              label: Text(
                                "Continue with Facebook",
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 15),
                              ),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(23)))),
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: AppPrimaryButton(
                          text: "Continue with Google",
                          onPressed: () => _loginWithGoogle(),
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SizedBox(
                            width: double.infinity,
                            child: AppSecondaryButton(
                              text: "Back to Login",
                              onPressed: () {
                                setState(() {
                                  _pageState == 2
                                      ? _pageState = 1
                                      : _pageState = 0;
                                });
                                print(_pageState);
                              },
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    AppLegalLinks()
                  ],
                ),
              ),
            ),
            _loading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ));
  }
}
