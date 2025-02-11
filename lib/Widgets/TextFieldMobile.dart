import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Constants.dart';
import '../Routing/Util/BasicFunctions.dart';
import '../Utils/Spacers.dart';

class TextFieldMobile extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Function? onEnterPress;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  // final Widget? suffix;
  final bool? enabled;
  final bool? isMandatory;
  final bool? isDatePicker;
  final bool? isLabelNeeded;
  final bool? isTextCapital;
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
  final Color? labelColor;
  final Color? borderColor;

  const TextFieldMobile(
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
      this.isTextCapital = true,
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
      this.labelColor,
      this.borderColor})
      : super(key: key);

  @override
  State<TextFieldMobile> createState() => _TextFieldMobileState();
}

class _TextFieldMobileState extends State<TextFieldMobile> {
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
                          color: widget.labelColor ?? Colors.black,
                          fontWeight: FontWeight.w400),
                ),
                (widget.isMandatory ?? false)
                    ? Text(
                        '*',
                        style: theme.textTheme.titleSmall!.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            responsiveHtSpacer(6),
          ],
          widget.maxLines != null
              ? TextFormField(
                  enabled: widget.enabled ?? true,
                  enableInteractiveSelection: false,
                  toolbarOptions: const ToolbarOptions(
                    copy: false,
                    cut: false,
                    paste: false,
                    selectAll: false,
                  ),
                  controller: widget.controller,
                  validator: widget.validator,
                  autofillHints: widget.autofillHints ?? [],
                  textAlign: widget.textAlign ?? TextAlign.start,
                  onChanged: (value) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  },
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  textCapitalization: (widget.isTextCapital ?? true) ? TextCapitalization.sentences : TextCapitalization.none,
                  maxLength: widget.maxLetterLength,
                  style: widget.textStyle ??
                      theme.textTheme.titleMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  onFieldSubmitted: (value) {
                    if (widget.onEnterPress != null) {
                      widget.onEnterPress!(value);
                    }
                  },
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  textInputAction: widget.textInputAction,
                  inputFormatters: widget.arrTextInputFormatter,
                  decoration: InputDecoration(
                      contentPadding:
                          widget.contentPadding ?? EdgeInsets.all(10),
                      counterText: "",
                      // labelText: widget.hint,
                      hintText: widget.hint,
                      hintStyle: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Constants.TEXT_FORM_FIELD_HINT),
                      labelStyle: theme.textTheme.titleMedium!
                          .copyWith(color: Colors.grey),
                      // suffix: widget.suffix ?? SizedBox.shrink(),
                      filled: true,
                      fillColor: (!isDatePicker)
                          ? (widget.enabled != null && widget.enabled! == false)
                              ? widget.disabledBgColor ??
                                  Colors.grey.withOpacity(0.1)
                              : Colors.white
                          : Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Constants.COLOR_PRIMARY, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: (widget.isDatePicker ?? false)
                              ? Colors.white
                              : Constants.COLOR_PRIMARY,
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
                      errorStyle: theme.textTheme.bodySmall!.copyWith(
                          color: Constants.COLOR_ERROR,
                          fontWeight: FontWeight.w400),
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
                    enableInteractiveSelection: false,
                    toolbarOptions: const ToolbarOptions(
                      copy: false,
                      cut: false,
                      paste: false,
                      selectAll: false,
                    ),
                    enabled: widget.enabled ?? true,
                    controller: widget.controller,
                    validator: widget.validator,
                    autofillHints: widget.autofillHints ?? [],
                    textInputAction: widget.textInputAction,
                    onChanged: widget.onChanged,
                    keyboardType: widget.keyboardType ?? TextInputType.text,
                    textCapitalization: (widget!.isTextCapital ?? true) ? TextCapitalization.sentences : TextCapitalization.none,
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    onFieldSubmitted: (value) {
                      if (widget.onEnterPress != null) {
                        widget.onEnterPress!(value);
                      }
                    },
                    maxLength: widget.maxLetterLength,
                    onTap: widget.onTap,
                    textAlign: widget.textAlign ?? TextAlign.start,
                    maxLines: 1,
                    inputFormatters: widget.arrTextInputFormatter,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 5, left: 10, right: 10),
                        counterText: "",
                        // labelText: widget.hint,
                        hintText: widget.hint,
                        hintStyle: theme.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Constants.TEXT_FORM_FIELD_HINT),
                        labelStyle: theme.textTheme.titleMedium!
                            .copyWith(color: Colors.grey),
                        errorStyle: theme.textTheme.bodySmall!.copyWith(
                            color: Constants.COLOR_ERROR,
                            fontWeight: FontWeight.w400),
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
                          borderSide: BorderSide(
                              color: Constants.COLOR_PRIMARY, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.borderColor ?? Colors.grey.shade400,
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
        ],
      ),
    );
  }
}
