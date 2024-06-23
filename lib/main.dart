import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ietel_solar/app.dart';

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyDLJjwwFaY2J1K5shIN819A1gemgM3ezxQ",
    authDomain: "userlist-413f7.firebaseapp.com",
    projectId: "userlist-413f7",
    storageBucket: "userlist-413f7.appspot.com",
    messagingSenderId: "271234920509",
    appId: "1:271234920509:web:bca90e85068cb6cb86fa54");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseConfig
  );
  runApp(App());
}
