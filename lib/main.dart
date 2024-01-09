import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instacloneapp/providers/user_provider.dart';
import 'package:instacloneapp/responsive/mobile_screen_layout.dart';
import 'package:instacloneapp/responsive/responsive_layout_screen.dart';
import 'package:instacloneapp/responsive/web_screen_layout.dart';
import 'package:instacloneapp/screens/login_screen.dart';
import 'package:instacloneapp/screens/signup_screen.dart';
import 'package:instacloneapp/utils/colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
   try {

    if(kIsWeb){
      print("girdi");
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCNvBVKKTxTxydUI7HDY-FVHUhKiETzyZU',
          authDomain: "instaclone-e08b7.firebaseapp.com",
            appId:'1:1005202065412:web:53a681498e4e910bc78d51',
            messagingSenderId: "1005202065412",
          projectId:'instaclone-e08b7',
          storageBucket: "instaclone-e08b7.appspot.com",

        ),
      );
    }
      print("girdi");
      await Firebase.initializeApp().then((value) => print("Firebase initialized"));


  } catch (e) {
    print('Firebase başlatılırken hata oluştu: $e');
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout()
                );
              }else if (snapshot.hasError){
                return Center(child: Text("${snapshot.hasError}"),);
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            return LoginScreen();
          }
        )

      ),
    );
  }
}


