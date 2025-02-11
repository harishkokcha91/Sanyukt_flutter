import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class InitializeAll {
  Future<void> initAll() async {
    if (!kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      await ScreenUtil.ensureScreenSize();
    }
    await GetStorage.init();
  }
}
