// ignore_for_file: prefer_const_constructors

import 'package:app_sonatrach/addons/authentication.dart';
import 'package:app_sonatrach/models/utilisateur.dart';
import 'package:app_sonatrach/widgets/carte.dart';
import 'package:app_sonatrach/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonnelAcceuilScreen extends StatefulWidget {
  const PersonnelAcceuilScreen({Key? key}) : super(key: key);
  static String routeName = "/pers";

  @override
  State<PersonnelAcceuilScreen> createState() => _PersonnelAcceuilScreenState();
}

class _PersonnelAcceuilScreenState extends State<PersonnelAcceuilScreen> {
  bool loggedIn = false;
  User? user = Auth().currentUser!;
  Utilisateur? userTest;

  @override
  void initState() {
    super.initState();
    user = Auth().currentUser;
    loggedIn = Auth().isUserLoggedIn();
    getUser();
  }

  Future getUser() async {
    await Auth().getUser().then((snap) => setState(() {
          userTest = snap;
        }));
  }

  Future<void> signOut() async {
    await Auth().signOut().then((value) {});
  }

  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: () {
          signOut();
        },
        child: const Text('Sign Out'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(title: 'Acceuil Personnel Simple'),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 55,
              vertical: 60,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Bonjour!,',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1.25,
                        ),
                      ),
                      Text(
                        "${userTest?.nom} ${userTest?.prenom}".toLowerCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MouseMemoirs-Regular",
                          fontSize: 20,
                          letterSpacing: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const Carte(
                  nom: "Mes Demandes De Bons de sortie",
                  description:
                      'Cette demande concerne les employés qui veulent une demande de bon de sortie',
                ),
                SizedBox(
                  height: 15,
                ),
                const Carte(
                  nom: "Mes Demandes De Bons de congé",
                  description:
                      'Cette demande concerne les employés qui veulent une demande de congé',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
