import 'dart:io';

import 'package:brandie_assessment/general/firebase_helpers/firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddReviewProvider extends ChangeNotifier {
  //Declare text file controller, form key, image uploading package, loading and image file variables
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  File? file;

  //Dispose textconrollers when not neccesay
  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }

  //use this to set loading true/false
  void setloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //post review function for firebase
  void postReview(context, productId) async {
    final user = FirebaseAuth.instance.currentUser!;

    if (formKey.currentState!.validate()) {
      setloading(true);
      try {
        String res = await FireStoreMethods().uploadPost(
          productId,
          descriptionController.text,
          file!,
          user.uid,
          user.displayName!,
          user.photoURL!,
        );
        if (res == 'success') {
          Fluttertoast.showToast(msg: 'Review posted successfly');
          clearImage(context);
          descriptionController.clear();
        } else {
          Fluttertoast.showToast(msg: 'Failed to post review ');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Failed to post review ');
      }
      setloading(false);
    }
  }

//pick single image for now with image picker plugin
  void pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
          source: source, maxWidth: 2000, maxHeight: 2000);
      if (image == null) return;
      final imageTemporary = File(image.path);
      file = imageTemporary;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Faild to pick Image: $e ');
    }
  }

//clear image when new reciew posts
  clearImage(context) {
    file = null;
    notifyListeners();
    Navigator.of(context).pop();
  }
}
