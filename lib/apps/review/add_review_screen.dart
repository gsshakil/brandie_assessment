import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:brandie_assessment/general/utils/firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  double? rating;
  bool _isLoading = false;
  File? _file;

  void postReview() async {
    final user = FirebaseAuth.instance.currentUser!;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        String res = await FireStoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          user.uid,
          user.displayName!,
          user.photoURL!,
        );
        if (res == 'success') {
          Fluttertoast.showToast(msg: 'Review posted successfly');
          clearImage();
          _descriptionController.clear();
        } else {
          Fluttertoast.showToast(msg: 'Failed to post review ');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Failed to post review ');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
          source: source, maxWidth: 2000, maxHeight: 2000);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _file = imageTemporary;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Faild to pick Image: $e ');
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void showImagePickerBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: (context),
      builder: (builder) {
        return Container(
          color: Colors.transparent,
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a photo or video',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            pickImage(ImageSource.camera);
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Camera',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            pickImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.image_sharp,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Galley',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Center(
              child: Text(
                'Add your story',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(
                    initialRating: 1,
                    minRating: 1,
                    itemSize: 24,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    glowColor: Theme.of(context).primaryColor,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star),
                      half: const Icon(Icons.star_border),
                      empty: const Icon(Icons.star_outline),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    onRatingUpdate: (rate) {
                      setState(() {
                        rating = rate;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Write your text here...',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v!.length > 0) {
                        return null;
                      } else {
                        return 'This field is required';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  _file != null
                      ? SizedBox(
                          child: Image.file(
                            _file!,
                            width: 135,
                            height: 105,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      showImagePickerBottomSheet(context);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        SizedBox(width: 20),
                        Text('Add Photo'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _isLoading
                        ? null
                        : () {
                            postReview();
                          },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Submit'))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
