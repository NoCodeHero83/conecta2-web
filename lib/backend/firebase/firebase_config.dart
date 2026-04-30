import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAjFs00aXMEn_v_5wa5P5DmjSN7MigejOA",
            authDomain: "conecta2-d3033.firebaseapp.com",
            projectId: "conecta2-d3033",
            storageBucket: "conecta2-d3033.appspot.com",
            messagingSenderId: "1091232026535",
            appId: "1:1091232026535:web:3946f8103dbdf23e0ab082",
            measurementId: "G-WYVW8ZH393"));
  } else {
    await Firebase.initializeApp();
  }
}
