import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/utils/app_str.dart';
import 'package:to_do_app/views/home/component/slider_drawer.dart';
import 'package:to_do_app/views/home/home_view.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final tfController = TextEditingController();
  final tfController2 = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  String username = "Kullanıcı Adı";
  String title = "Ünvan";
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "Kullanıcı Adı";
      title = prefs.getString('title') ?? "Ünvan";
      imagePath = prefs.getString('imagePath');
      if (imagePath != null) {
        _image = XFile(imagePath!);
      }
      tfController.text = username;
      tfController2.text = title;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('title', title);
    if (_image != null) {
      prefs.setString('imagePath', _image!.path);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      if (image != null) {
        imagePath = image.path;
      }
    });
    await _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _image == null
                    ? NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/007/698/902/original/geek-gamer-avatar-profile-icon-free-vector.jpg")
                    : FileImage(File(_image!.path)) as ImageProvider,
              ),
              Text(
                username,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25,fontFamily: "Libre"),
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Row(
                  children: [
                    Text(
                      "PROFILE",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0, bottom: 10),
                child: Divider(thickness: 2, indent: 10),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          AppStr.userName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              controller: tfController,
                              decoration: InputDecoration(hintText: "UserName"),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10),
                    child: Row(
                      children: [
                        Text(
                          AppStr.title,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 60),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              controller: tfController2,
                              decoration: InputDecoration(hintText: "Title"),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10),
                    child: Row(
                      children: [
                        Text(
                          AppStr.photo,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 60),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              _image == null
                                  ? Text('Hiçbir fotoğraf seçilmedi.')
                                  : Image.file(
                                File(_image!.path),
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _pickImage,
                                child: Text('Galeriden Fotoğraf Seç'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _saveData();
                        setState(() {
                          username = tfController.text.isEmpty
                              ? "Kullanıcı Adı"
                              : tfController.text;
                          title = tfController2.text.isEmpty
                              ? "Ünvan"
                              : tfController2.text;
                        });
                        await _saveData();
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
