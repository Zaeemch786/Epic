import 'dart:io';

import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
              options: const FirebaseOptions(
                  storageBucket: "ecommerceapp-22ab0.appspot.com",
                  apiKey: "AIzaSyAxDHidbcU8xv06Oy10TI6toaQedDvfOqc",
                  appId: "1:102147778902:android:e20b2b017dca3aee468ef7",
                  messagingSenderId: "102147778902",
                  projectId: "ecommerceapp-22ab0"))
          .then((value) => Get.put(AuthenticationRepository()))
      : await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  runApp(const MyApp());
}
