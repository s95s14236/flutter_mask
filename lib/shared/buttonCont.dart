import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String text;
  final Function tap;

  ButtonContainer({this.text,this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF6078ea).withOpacity(.3),
                  offset: Offset(0.0, 8.0),
                  blurRadius: 8.0)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: tap,
            child: Center(
              child: Text(text,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "NotoSanseTC",
                      fontSize: 18,
                      letterSpacing: 1.0)),
            ),
          ),
        ),
      ),
    );
  }
}
