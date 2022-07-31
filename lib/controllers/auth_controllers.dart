// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //FUNCTION TO PICK IMAGE FROM GALLERY OR CAMERA
  pickImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source); //source指的是相機或是相簿
    if(_file != null){
      return _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> signUpUsers(String fullName, String email, String password) async{
    String res = 'some error occured';
    try {
      if(fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

          await _firestore.collection('users').doc(cred.user?.uid).set({
            'fullName': fullName,
            'email': email,
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
}
