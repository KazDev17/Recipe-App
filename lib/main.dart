//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:recipeapp/Auth.dart';
import 'package:recipeapp/views/home.dart';
//import 'package:firebase_core/firebase_core.dart';
// import 'package:recipeapp/views/home.dart';
// import 'package:recipeapp/views/recipe_view.dart';

//import 'SignIn.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     Provider<AuthenticationService>(
    //       create: (_) => AuthenticationService(FirebaseAuth.instance),
    //     ),
    //     StreamProvider(
    //       create: (context) =>
    //           context.read<AuthenticationService>().authStateChanges,
    //       initialData: null,
    //     ),
    //   ],
    return MaterialApp(
      title: 'Kelvin\'s Recipes',
      debugShowCheckedModeBanner: false, //this removes slow loading times
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   get firebaseUser => null;
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     final firebaseuser = context.watch<User>();

//     if (firebaseUser != null) {
//       return Home();
//     }
//     return SignInPage();
//   }
// }
