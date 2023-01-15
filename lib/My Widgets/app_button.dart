import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isBlack;
  final String title;
  final FontWeight fontWeight;
  final double fontSize;

  const AppButton({
    required this.title,
    this.isBlack = false,
    this.onTap,
    Key? key,
    required this.fontWeight,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isBlack ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: !isBlack ? Border.all(width: 2, color: Colors.black) : null,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: isBlack ? Colors.white : Colors.black,
                    fontWeight: fontWeight,
                    fontSize: fontSize),
              ),
            ),
          ),
        ));
  }
}
