import 'package:flutter/material.dart';

import '../Constants/Constants.dart';

class PrimaryButton extends StatefulWidget {
  final Function()? onTap;
  final String buttonText;
  final Widget? prefixIcon;
  final Color? bgColor;
  final Color? fontColor;
  final double? height;
  final double? width;
  final EdgeInsets? paddingValue;
  final FontWeight? textFontWeight;
  final double? textFontSize;

  const PrimaryButton(
      {required this.onTap,
      required this.buttonText,
        this.fontColor,
      this.bgColor,
      this.width,
      this.height,
      this.paddingValue,
      this.textFontWeight,
      this.prefixIcon,
        this.textFontSize,
      Key? key})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      // height: widget.height ?? 40,
      height: widget.height ?? 51,
      constraints: BoxConstraints(
        minWidth: widget.width??88,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            overlayColor: widget.onTap==null?
                 const MaterialStatePropertyAll(Constants.HINT_PRIMARY)
                : MaterialStatePropertyAll(widget.bgColor ?? Constants.COLOR_PRIMARY_DARK),
            backgroundColor: widget.onTap==null?
                 const MaterialStatePropertyAll(Constants.HINT_PRIMARY)
                : MaterialStatePropertyAll(widget.bgColor ?? Constants.COLOR_PRIMARY),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.prefixIcon ?? const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8),
              child: Text(
                widget.buttonText,
                style: theme.textTheme.titleMedium!.copyWith(
                    color: widget.fontColor ?? (widget.onTap==null? Constants.COLOR_TEXT_LIGHT: Colors.white),
                    fontSize: (widget.textFontSize != null)?widget.textFontSize: widget.buttonText.length>10?14:16,
                    fontWeight: widget.textFontWeight ?? FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
