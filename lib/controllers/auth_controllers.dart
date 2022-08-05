// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // 將圖片檔案上傳至Firebase Storage
  _uploadImageToStorage(Uint8List? image) async {
    //先創建一個資料夾名稱都可取(profile)要儲存圖片
    //第一個child為父資料夾名稱，第二個child為子資料名稱
    Reference ref =
        _firebaseStorage.ref().child('profiles').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  //FUNCTION TO PICK IMAGE FROM GALLERY OR CAMERA
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file =
        await _imagePicker.pickImage(source: source); //source指的是相機或是相簿
    if (_file != null) {
      return _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> signUpUsers(
      String fullName, String email, String password, Uint8List? image) async {
    String res = 'some error occured';
    try {
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadImageToStorage(image);
        await _firestore.collection('users').doc(cred.user?.uid).set({
          'fullName': fullName,
          'email': email,
          'image': downloadUrl,
        });
        res = 'success';
        print('success');
      } else {
        res = 'Please fields must not be empty';
        print('Please fields must not be empty');
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUsers(String email, String password) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
        print('Login successfully');
      } else {
        res = 'Please fiels must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
