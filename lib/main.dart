import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ringworm_detection_doctor/screens/chat/chatValidasiDoctor.dart';
import 'package:ringworm_detection_doctor/validasi.dart';
import 'routes/pageRoute.dart';
import 'screens/Introduction/intro.dart';
import 'screens/chat/chatScreenDoctor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login/loginDoctor.dart';
import 'screens/registrasi/registrasiDoctor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent[400],
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ValidasiScreens();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreensDoctor();
          }),
      routes: {
        PageRoutes.homeDoctor: (context) => ChatValidasiDoctor(),
        //PageRoutes.dodont: (context) => const Dos(),
        PageRoutes.introDoctor: (context) => const IntroDoctor(),
        PageRoutes.Validasi: (context) => const ValidasiScreens(),
        // PageRoutes.aboutdis: (context) => const AboutDisease(),
        //PageRoutes.aboutus: (context) => const AboutUs(),
        PageRoutes.loginDoctor: (context) => const LoginScreensDoctor(),
        PageRoutes.registrasiDoctor: (context) =>
            const RegistrasiScreensDoctor(),
      },
    );
  }
}


/*
Important link : https://www.thirdrocktechkno.com/blog/how-to-implement-navigation-drawer-in-flutter/

*/