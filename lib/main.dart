import 'package:bookpdf/view/homeView.dart';
import 'package:bookpdf/view/pdfView/pdfView.dart';
import 'package:bookpdf/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

main() {
  Gemini.init(apiKey: 'AIzaSyAN10TLWtEr_wdS41qhHMIxacFlfe8fxko');
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Ai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}
