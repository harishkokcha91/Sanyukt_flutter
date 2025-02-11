import 'package:flutter/material.dart';

import '../Constants/Constants.dart';


class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.COLOR_BACKGROUND,
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}