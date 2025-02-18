import 'package:education_app_tutorial/core/theme/colors.dart';
import 'package:education_app_tutorial/core/res/fonts.dart';
import 'package:education_app_tutorial/core/services/di_container.dart';
import 'package:education_app_tutorial/core/services/router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: AppFonts.poppins,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.primaryColor,
        ),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
