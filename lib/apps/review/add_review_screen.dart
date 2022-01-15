import 'package:brandie_assessment/apps/review/add_review_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({required this.productId, Key? key}) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    void showImagePickerBottomSheet(context) {
      final addReviewProvider =
          Provider.of<AddReviewProvider>(context, listen: false);
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
                              addReviewProvider.pickImage(ImageSource.camera);
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
                              addReviewProvider.pickImage(ImageSource.gallery);
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

    return Consumer<AddReviewProvider>(
        builder: (context, addReviewProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Review'),
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
                key: addReviewProvider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: addReviewProvider.descriptionController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: 'Write your text here...',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v!.isNotEmpty) {
                          return null;
                        } else {
                          return 'This field is required';
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    addReviewProvider.file != null
                        ? SizedBox(
                            child: Image.file(
                              addReviewProvider.file!,
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
                      onPressed: addReviewProvider.isLoading
                          ? null
                          : () {
                              addReviewProvider.postReview(context, productId);
                            },
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: addReviewProvider.isLoading
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
    });
  }
}
