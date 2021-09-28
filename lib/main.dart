import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/frontend/providers/task_list_provider.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/routes.dart';

import 'frontend/providers/auth_provider.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider(),),
      ChangeNotifierProvider(create: (context) => TaskListProvider(),),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white
        ),
        textTheme: GoogleFonts.robotoTextTheme()
      ),
      onGenerateRoute: (settings) => RouteGenerator.onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) { 
        child = botToastBuilder(context,child);
        return child;
      },
    );
  }
}
