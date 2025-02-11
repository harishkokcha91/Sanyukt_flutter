import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import '../Routing/Util/BasicFunctions.dart';

class BorderButton extends StatefulWidget {
  final Function()? onTap;
  final String buttonText;
  final double? height;
  final double? width;
  final FontWeight? textFontWeight;
  final bool? hasPrimaryOnRight;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? borderColorHover;
  final double? leftPadding;
  final double? rightPadding;
  final double? textFontSize;

  const BorderButton(
      {required this.onTap,
      required this.buttonText,
      this.height,
      this.width,
      this.borderColor,
      this.borderColorHover,
      this.textFontWeight,
        this.leftPadding,
        this.rightPadding,
        this.textFontSize,
      this.hasPrimaryOnRight = false,
      this.prefixIcon,
      Key? key})
      : super(key: key);

  @override
  State<BorderButton> createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: widget.height ?? 51,
      // height: widget.height ?? 40.spMin,
      constraints: BoxConstraints(
          minWidth: widget.width??88
      ),
      margin: EdgeInsets.only(right: (widget.hasPrimaryOnRight!) ? 16 : 0),
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            overlayColor: const MaterialStatePropertyAll(Colors.white),
            side: MaterialStateBorderSide.resolveWith(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return BorderSide(color: (widget.borderColorHover != null)?widget.borderColorHover!:Constants.COLOR_PRIMARY_DARK);
              }
              return BorderSide(
                  color: (widget.borderColor != null)?widget.borderColor!:Constants.COLOR_PRIMARY); // Defer to default value on the theme or widget.
            }),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        onPressed: widget.onTap,
        child: Padding(
          padding:  (widget.leftPadding != null)?
           EdgeInsets.only(left: widget.leftPadding!, right: widget.rightPadding!):
          EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.prefixIcon ?? const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                child: Text(
                  widget.buttonText,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontSize: (widget.textFontSize != null)?widget.textFontSize:widget.buttonText.length>10?14:16,
                      fontWeight: widget.textFontWeight ?? FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
