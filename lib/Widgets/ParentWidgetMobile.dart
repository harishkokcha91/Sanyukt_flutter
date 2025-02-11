import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/Constants.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/Spacers.dart';
import 'EmptyAppBar.dart';

class ParentWidgetMobile extends StatefulWidget {
  final Widget? layout;
  final String? title;
  final bool? showBackButton;
  final Function? onBackPressed;
  final Color? bgColor;
  final Widget? bottomButton;
  final Widget? floatingActionButton;
  final Widget? widget1;
  final bool? callPop;
  final bool resizeToAvoidBottomInset;


  const ParentWidgetMobile(
      {required this.layout,
      this.bgColor,
      this.title,
      required this.showBackButton,
      this.onBackPressed,
        this.bottomButton,
        this.floatingActionButton,
        this.widget1,
        this.callPop,
        this.resizeToAvoidBottomInset = false,
      super.key});

  @override
  State<ParentWidgetMobile> createState() => _ParentWidgetMobileState();
}

class _ParentWidgetMobileState extends State<ParentWidgetMobile> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked:(didPop){
        if(didPop){
          return;
        }
        if(widget.callPop==null){
          print("pop called 123");
          if (Get.previousRoute.isNotEmpty) {
            CustomNavigator.pop();
          } else {
            print("here without route");
            CustomNavigator.pushOff(Routes.HOME);
          }
        }
      },
      child:Scaffold(
        appBar: EmptyAppBar(),
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 48),
              color: widget.bgColor ?? Colors.white,
              child: widget.layout!,
            ),
            ClipPath(
              clipper: BottomLeftCurveClipper(),
              child: Container(
                //
                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                height: 88,
                width: Get.width,
                decoration:  const BoxDecoration(
                  color: Constants.COLOR_PRIMARY,
                  // gradient: LinearGradient(colors: [
                  //   Color(0xFF587925),
                  //   Constants.COLOR_PRIMARY,
                  // ], begin: Alignment.bottomCenter, end: Alignment.topCenter)

                ),
              ),
            ),
            //Back Button with title
            Container(
              // alignment: Alignment.bottomLeft,
              height: 88,
              padding: const EdgeInsets.only(bottom: 40, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (widget.showBackButton ?? false)
                      ? InkWell(
                    onTap: () {
                      if (widget.onBackPressed != null) {
                        widget.onBackPressed!();
                      } else {
                        if(Get.previousRoute == Get.currentRoute || Get.previousRoute.isEmpty){
                          CustomNavigator.popTo(Routes.HOME);
                        }
                        else{
                          CustomNavigator.pop();
                        }
                      }
                    },
                    child:const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 385),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              text: widget.title ?? "",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      widget.widget1 != null ? widget.widget1! : Container(),

                      CustomSpacers.width10,
                    ],
                  ))

                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: widget.bottomButton,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      )
    );
  }
}

class BottomLeftCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the bottom left
    path.moveTo(0, size.height);
    // Curve to x=10px and y=height-10px
    path.quadraticBezierTo(0, size.height - size.width * 0.07,
        size.width * 0.07, size.height - size.width * 0.07);
    // Line to the end of x-axis
    path.lineTo(size.width, size.height - size.width * 0.07);
    // Draw a line straight up to the top right corner to close the path properly
    path.lineTo(size.width, 0);
    // Draw a line to the top left corner
    path.lineTo(0, 0);
    // Close the path (not strictly necessary here since we're already back at the start)
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // In a more complex clipper, you might want to compare properties of the oldClipper
    // to determine if re-clipping is necessary. For simplicity, just return true here.
    return true;
  }
}
