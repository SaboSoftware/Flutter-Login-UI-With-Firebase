import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/home_page.dart';
import 'package:flutter/material.dart';

class AuthService {
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context, {required name, required password, required email, required datetime, required bio}) async {
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await _registerUser(uid: userCredential.user!.uid, name: name, email: email, password: password, datetime: datetime, bio: bio);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        _showSnackBar(context, "Veriler boş.");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e);
      _showSnackBar(context, errorMessage);
    }
  }

  Future<void> signIn(BuildContext context, {required email, required password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        _showSnackBar(context, "Lütfen boş alan bırakmayınız.");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e);
      _showSnackBar(context, errorMessage);
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Kullanıcı bulunamadı.';
      case 'invalid-credential':
        return 'Giriş bilgilerin hatalı, bilgilerinizi doğru giriniz.';
      case 'wrong-password':
        return 'Şifre hatalı';
      case 'user-not-found':
        return 'Bu bilgilere sahip kullanıcı bulunamadı.';
      case 'email-already-in-use':
        return 'Bu e-posta adresi zaten kullanımda.';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi.';
      case 'weak-password':
        return 'Zayıf parola! Lütfen daha güçlü parola giriniz.';
      case 'channel-error':
        return 'Lütfen alanları doldurun.';
      default:
        return 'Bir hata oluştu. Lütfen tekrar deneyin. (${e.code})';
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _registerUser({required uid, required name, required email, required password, required datetime, required bio}) async {
    await usersCollection.doc(uid).set({
      "name": name,
      "email": email,
      "password": password,
      "datetime": datetime,
      "bio": bio,
    });
  }

  // _updateUserHobbies fonksiyonunu ekleyin
  Future<void> _updateUserHobbies({required List<String> newHobbies, required uid}) async {
    await usersCollection.doc(uid).update({
      "hobbies": newHobbies,
    });
  }
}
