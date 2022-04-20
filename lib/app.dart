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
        primarySwatch: Colors.blue,
      ),
      initialRoute: homePage,
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}