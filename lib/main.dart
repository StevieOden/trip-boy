import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/services/auth.dart';
import 'package:trip_boy/ui/user/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            locale: _locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('id', ''),
              Locale('en', ''),
            ],
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        }));
  }
}

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextButton(
//           child: Text("Set locale to Indonesia"),
//           onPressed: () => MyApp.of(context)!
//               .setLocale(Locale.fromSubtags(languageCode: 'id')),
//         ),
//         TextButton(
//           child: Text("Set locale to English"),
//           onPressed: () => MyApp.of(context)!
//               .setLocale(Locale.fromSubtags(languageCode: 'en')),
//         ),
//       ],
//     );
//   }
// }
