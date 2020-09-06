import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';

class AppSecondaryButton extends StatefulWidget {
  AppSecondaryButton({Key key, this.text, this.onPressed, this.icon})
      : super(key: key);
  final String text;
  final GestureTapCallback onPressed;
  final IconData icon;
  @override
  _AppSecondaryButtonState createState() => _AppSecondaryButtonState();
}

class _AppSecondaryButtonState extends State<AppSecondaryButton> {
  TextStyle buttonStyle =
      GoogleFonts.lato(color: appPrimaryColor, fontSize: 15);
  EdgeInsetsGeometry buttonPadding = EdgeInsets.fromLTRB(0, 15, 0, 15);
  ShapeBorder buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(23),
      side: BorderSide(color: appPrimaryColor));
  Color buttonTextColor = appPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
          width: double.infinity,
          child: widget.icon != null
              ? FlatButton.icon(
                  color: Colors.white,
                  padding: buttonPadding,
                  onPressed: widget.onPressed,
                  icon: Icon(widget.icon),
                  label: Text(widget.text, style: buttonStyle),
                  textColor: buttonTextColor,
                  shape: buttonShape)
              : FlatButton(
                  color: Colors.white,
                  padding: buttonPadding,
                  onPressed: widget.onPressed,
                  child: Text(widget.text, style: buttonStyle),
                  textColor: buttonTextColor,
                  shape: buttonShape)),
    );
  }
}
