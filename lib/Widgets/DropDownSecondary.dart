import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import '../Utils/Spacers.dart';

class DropDownSecondary extends StatelessWidget {
  final dynamic value;
  final List typeList;
  final Function(dynamic) onChanged;
  final String? title;
  final List<Widget>? suffixIconList;
  final bool? mandatory;
  final double? height;
  final bool disable;
  final Color? borderColor;

  const DropDownSecondary(
      {super.key,
      required this.value,
      required this.typeList,
        this.suffixIconList,
      required this.onChanged,
        this.mandatory,
        this.height,
      this.borderColor,
      this.title,this.disable = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? (mandatory??false)?
             Row(
               children: [
                 Text(
                    title!,
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                 Text(
                   '*',
                   style: theme.textTheme.titleMedium!.copyWith(
                       fontSize: 14,
                       color: Colors.red,
                       fontWeight: FontWeight.w400),
                 )
               ],
             )
        :Text(
          title!,
          style: theme.textTheme.titleMedium!.copyWith(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ):
        const SizedBox.shrink(),
        title != null ? CustomSpacers.height6 : Container(),
        Container(
          height: height??48,
          decoration: BoxDecoration(
              color: disable? Constants.HINT_PRIMARY_LIGHT: Colors.white,
              border: Border.all(color: borderColor ?? Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Colors.white,
                  focusColor: Colors.transparent,
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  value: value,
                  onChanged: disable? null: onChanged,
                  items: typeList.map(
                    (location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Row(
                          children: [
                            Text(
                              location,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            suffixIconList?[typeList.indexOf(location)] ??
                                SizedBox.shrink(),
                            CustomSpacers.width10,
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
