import 'package:firebase_core/firebase_core.dart';

import 'consts/consts.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDzH3jhQ1MhwBF0GGyY0fd-GOBPmdw0oq8",
          authDomain: "ecom-5b1ed.firebaseapp.com",
          projectId: "ecom-5b1ed",
          storageBucket: "ecom-5b1ed.appspot.com",
          messagingSenderId: "1017509824481",
          appId: "1:1017509824481:web:3396eee81c81ea1f4d34a0"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
