import 'package:flutter/material.dart';
import '../../Constants/Constants.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
          color: Constants.COLOR_PRIMARY,
        )
    );

  }
}
