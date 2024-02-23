import 'package:firebaselogin/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;
  TextEditingController hobbyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    print("current user $_user");
  }

  Future<void> _addHobby(String hobby) async {
    await _firestore.collection('users').doc(_user.uid).update({
      "hobbies": FieldValue.arrayUnion([hobby]),
    });
  }

  Future<void> _deleteHobby(String hobby) async {
    await _firestore.collection('users').doc(_user.uid).update({
      "hobbies": FieldValue.arrayRemove([hobby]),
    });
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21899C),
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(_user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text("Hata: ${snapshot.error}");
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text("Kullanıcı bulunamadı");
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Kullanıcı Bilgileri",
                        style: GoogleFonts.inter(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      ListTile(
                        title: Text(
                          "Ad Soyad",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${data['name']}",
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Email",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${data['email']}",
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Doğum Tarihi",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${data['datetime']}",
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Biyografi:",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${data['bio']}",
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Hobiler",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: data['hobbies'] != null
                            ? Wrap(
                          spacing: 8.0,
                          children: (data['hobbies'] as List<dynamic>)
                              .cast<String>()
                              .map((hobby) {
                            return Chip(
                              label: Text(
                                  hobby,
                                style: GoogleFonts.inter(
                                  fontSize: 13.0,
                                ),
                              ),
                              onDeleted: () {
                                _deleteHobby(hobby);
                              },
                            );
                          }).toList(),
                        )
                            : Text("Hobiler henüz eklenmemiş"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Hobi Ekle"),
                content: TextField(
                  controller: hobbyController,
                  decoration: InputDecoration(labelText: "Hobi"),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      _addHobby(hobbyController.text);
                      Navigator.pop(context);
                    },
                    child: Text("Ekle"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


