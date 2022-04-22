import 'package:flutter/material.dart';
import 'core/core.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jobsity Chalenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF3c948b),
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.red,
          background: Colors.white,
          onBackground: Colors.white,
          surface: Colors.grey,
          onSurface: Colors.grey,
        ),
      ),
      initialRoute: signInPage,
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}
