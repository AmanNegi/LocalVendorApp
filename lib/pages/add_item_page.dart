import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/firebase_storage.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/widgets/action_button.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  AddItemPageState createState() => AddItemPageState();
}

class AddItemPageState extends State<AddItemPage> {
  late double height, width;

  String name = "", description = "";
  double price = 0.0;
  String imageUrl = "";
  bool pickedImage = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () async {
          String itemId = const Uuid().v1();

          String url =
              await storageManager.uploadItemImage(itemId, File(imageUrl));

          await cloudDatabase.addItem(
            ShopItem(
              price: price,
              description: description,
              itemId: const Uuid().v1(),
              itemName: name,
              image: url,
              listedAt: DateTime.now(),
            ),
          );
          Navigator.pop(context);
        },
        label: Row(
          children: const [
            Text("Continue"),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ],
        ),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        height: height,
        child: Column(
          children: [
            SizedBox(height: 0.02 * height),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              reverseDuration: const Duration(seconds: 1),
              child: _getImageSelector(),
              layoutBuilder: (currentChild, previousChildren) =>
                  currentChild ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  _getImageSelector() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
            height: 0.3 * height,
            width: double.infinity,
            child: pickedImage
                ? GestureDetector(
                    onTap: () {
                      pickAnImage();
                    },
                    child: Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  )
                : ActionButton(
                    onPressed: () async {
                      await pickAnImage();
                    },
                    text: ("Pick an Image"),
                  ),
          ),
        ),
        Container(
          height: 0.025 * height,
        ),
        _getTextField(
          "Name",
          ((e) => name = e),
          TextInputType.text,
        ),
        _getTextField(
          "Description",
          ((e) => description = e),
          TextInputType.text,
        ),
        _getTextField(
          "Price",
          ((e) => price = double.parse(e)),
          TextInputType.number,
        ),
      ],
    );
  }

  _getTextField(
    String hintText,
    Function onChange,
    TextInputType keyboardType,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            spreadRadius: 1.0,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: TextField(
        maxLines: null,
        keyboardType: keyboardType,
        onChanged: (value) {
          onChange(value);
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<bool> pickAnImage() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (file != null) {
      imageUrl = file.path;
      pickedImage = true;
      setState(() {});
      return true;
    }
    return false;
  }
}
