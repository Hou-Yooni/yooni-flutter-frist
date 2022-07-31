import 'package:flutter/material.dart';

snackBar(String title, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 206, 206, 206),
      content: Text(
        title, 
        style: const TextStyle(color: Color.fromARGB(255, 105, 105, 105), fontSize: 13, ),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
    )
  );
}