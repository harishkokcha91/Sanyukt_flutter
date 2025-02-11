import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Constants.dart';
import '../Utils/Spacers.dart';

class TextFieldPrimary extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Function? onEnterPress;
  final Function? onChanged;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  // final Widget? suffix;
  final bool? enabled;
  final bool? isMandatory;
  final bool? isDatePicker;
  final bool? isLabelNeeded;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? arrTextInputFormatter;
  final int? maxLines;
  final int? maxLetterLength;
  final int? minLines;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final Color? disabledBgColor;
  final bool isMob;
 final  FocusNode? focusNode;

  const TextFieldPrimary(
      {required this.controller,
      this.label,
      required this.hint,
      this.maxLetterLength,
      this.onChanged,
      Key? key,
      this.arrTextInputFormatter,
      this.isMandatory,
      this.onEnterPress,
      this.suffixIcon,
      this.enabled,
      this.isLabelNeeded = true,
      this.onTap,
      this.validator,
      this.labelStyle,
      this.textStyle,
      this.maxLines,
      this.isDatePicker,
      this.keyboardType,
      this.autofillHints,
      this.minLines,
      this.textAlign,
      this.contentPadding,
      this.textInputAction,
      this.disabledBgColor,
      this.isMob = false,
        this.focusNode})
      : super(key: key);

  @override
  State<TextFieldPrimary> createState() => _TextFieldPrimaryState();
}

class _TextFieldPrimaryState extends State<TextFieldPrimary> {
  bool isDatePicker = false;

  @override
  void initState() {
    super.initState();
    isDatePicker = widget.isDatePicker ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLabelNeeded ?? true) ...[
            Row(
              children: [
                Text(
                  widget.label ?? widget.hint,
                  style: widget.labelStyle ??
                      theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                ),
                (widget.isMandatory ?? false)
                    ? Text(
                        '*',
                        style: theme.textTheme.titleMedium!.copyWith(
                                fontSize: 13,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            CustomSpacers.height6,
          ],
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              child: widget.maxLines != null
                  ? TextFormField(
                      enabled: widget.enabled ?? true,
                      controller: widget.controller,
                      validator: widget.validator,
                      autofillHints: widget.autofillHints ?? [],
                      textAlign: widget.textAlign ?? TextAlign.start,
                      onChanged: (value) {
                        if (widget.onChanged != null) {
                          widget.onChanged!(value);
                        }
                      },
                      onTap: widget.onTap,
                      keyboardType: widget.keyboardType,
                      maxLength: widget.maxLetterLength,
                      style: widget.textStyle ??
                          theme.textTheme.titleMedium!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                      onFieldSubmitted: (value) {
                        if (widget.onEnterPress != null) {
                          widget.onEnterPress!(value);
                        }
                      },
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      inputFormatters: widget.arrTextInputFormatter,
                      decoration: InputDecoration(
                          contentPadding:
                              widget.contentPadding ?? EdgeInsets.all(10),
                          counterText: "",
                          // labelText: widget.hint,
                          hintText: widget.hint,
                          hintStyle: theme.textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600),
                          labelStyle: theme.textTheme.titleMedium!
                              .copyWith(color: Colors.grey),
                          // suffix: widget.suffix ?? SizedBox.shrink(),
                          filled: true,
                          fillColor: (!isDatePicker)
                              ? (widget.enabled != null &&
                                      widget.enabled! == false)
                                  ? widget.disabledBgColor ??
                                      Colors.grey.withOpacity(0.1)
                                  : Colors.white
                              : Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Constants.COLOR_PRIMARY, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: (widget.isDatePicker ?? false)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              width: 1.0,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: (widget.isDatePicker ?? false)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: widget.suffixIcon),
                    )
                  : SizedBox(
                      height: 48,
                      child: TextFormField(
                        enabled: widget.enabled ?? true,
                        controller: widget.controller,
                        validator: widget.validator,
                        autofillHints: widget.autofillHints ?? [],
                        onChanged: (value) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(value);
                          }
                        },
                        keyboardType: widget.keyboardType,
                        style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        onFieldSubmitted: (value) {
                          if (widget.onEnterPress != null) {
                            widget.onEnterPress!(value);
                          }
                        },
                        textAlign: widget.textAlign ?? TextAlign.start,
                        maxLines: 1,
                        maxLength: widget.maxLetterLength,
                        inputFormatters: widget.arrTextInputFormatter,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 5, left: 10, right: 10),
                            counterText: "",
                            // labelText: widget.hint,
                            hintText: widget.hint,
                            hintStyle: theme.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600),
                            labelStyle: theme.textTheme.titleMedium!
                                .copyWith(color: Colors.grey),
                            // suffix: widget.suffix ?? SizedBox.shrink(),
                            filled: true,
                            fillColor: (!isDatePicker)
                                ? (widget.enabled != null &&
                                        widget.enabled! == false)
                                    ? widget.disabledBgColor ??
                                        Colors.grey.withOpacity(0.1)
                                    : Colors.white
                                : Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Constants.COLOR_PRIMARY, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            suffixIcon: widget.suffixIcon),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
