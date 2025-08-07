import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genesis/src/theming/palette.dart';

class HexagonIconButton extends StatelessWidget {
  const HexagonIconButton({
    required this.onPressed,
    required this.iconData,
    super.key,
  });

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/hexagon.svg',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          Icon(
            iconData,
            size: 32,
            color: Palette.color6DCF91,
          ),
        ],
      ),
    );
  }
}
