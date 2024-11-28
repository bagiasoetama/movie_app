import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchIconLabel extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const SearchIconLabel({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16.0,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
