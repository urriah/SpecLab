import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'spec_lab_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAEghQgRVSbgjjMxJGydT1kcdJ8RZ5qjqs",
        authDomain: "speclab-c883e.firebaseapp.com",
        projectId: "speclab-c883e",
        storageBucket: "speclab-c883e.firebasestorage.app",
        messagingSenderId: "215408451039",
        appId: "1:215408451039:web:60b4c1f347cd2b5a8ef86a",
        measurementId: "G-72BSP4CRJC"),
  );

  runApp(const SpecLabApp());
}
