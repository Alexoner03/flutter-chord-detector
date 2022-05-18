import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guitar/pages/SelectLevelAudition.dart';
import 'package:guitar/pages/login.dart';
import 'package:guitar/pages/register.dart';
import 'package:guitar/pages/video.dart';
import 'package:guitar/providers/AuthProvider.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/LearnAcordes.dart';
import 'pages/LearnCuerdas.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xffBB86FC),
  secondary: Color(0xff03DAC6),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BackendProvider()),
      ],
      child : const MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: defaultColorScheme,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const LoginPage(),
        '/register' : (context) => const RegisterPage(),
        '/home' : (context) => const HomePage(),
        '/video' : (context) => const VideoPage(),
        '/cuerdas' : (context) => const LearnCuerdas(),
        '/acordes' : (context) => const LearnAcordes(),
        '/examen' : (context) => const SelectLevelAudition(),
      },
    );
  }
}