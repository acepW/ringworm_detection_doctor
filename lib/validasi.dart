import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ringworm_detection_doctor/model/DocterModel.dart';
import 'package:ringworm_detection_doctor/screens/Introduction/intro.dart';
import 'package:ringworm_detection_doctor/screens/login/loginDoctor.dart';

class ValidasiScreens extends StatefulWidget {
  static const String routeName = '/Validasi';

  const ValidasiScreens({super.key});

  @override
  State<ValidasiScreens> createState() => _ValidasiScreensState();
}

class _ValidasiScreensState extends State<ValidasiScreens> {
  Future<Widget> chatPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('akun')
          .doc(user.uid)
          .get();
      DoctorModel doctorModel = DoctorModel.fromSnap(userData);
      return doctorModel.role == "doctor"
          ? IntroDoctor()
          : LoginScreensDoctor();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chatPage(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        });
  }
}
