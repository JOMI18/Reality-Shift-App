import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';
import 'package:path/path.dart' as path;

enum UploadType {
  // For the enum, an enum (short for enumeration) is a way to define a set of named constant values. In Dart, enums are a special kind of class used to represent a fixed number of constant values.
  BaseImage,
  SlideshowImage,
  FlagImage,
}

class CreateContinent extends StatefulWidget {
  const CreateContinent({super.key});

  @override
  State<CreateContinent> createState() => _CreateContinentState();
}

class _CreateContinentState extends State<CreateContinent> {
  late TextEditingController continent;
  AlertInfo alert = AlertInfo();
  final ImagePicker _picker = ImagePicker();

  File? _baseImage;
  bool _showBaseImage = false;

  final List<File> _slideImages = [];
  final List<bool> _showSlideImages = [];

  final List<Map<String, dynamic>> countries = [
    {'country': '', 'flagImages': [], 'showFlags': []}
  ];

  List<Map<String, String>> facts = [];
  List lines = [];

  Future<void> _uploadImage(UploadType type, [int index = -1]) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        switch (type) {
          case UploadType.BaseImage:
            _baseImage = imageFile;
            _showBaseImage = false;
            break;
          case UploadType.SlideshowImage:
            if (_slideImages.length < 4) {
              _slideImages.add(imageFile);
              _showSlideImages.add(false);
            } else {
              showAlert("Cannot select more than 4 images.");
            }
            break;
          case UploadType.FlagImage:
            if (countries[index]['flagImages'].isEmpty) {
              countries[index]['flagImages'].add(imageFile);
              countries[index]['showFlags'].add(false);
            } else {
              showAlert("Cannot select more than 1 image.");
            }
            break;
        }
      });
    }
  }

  void showAlert(String msg) {
    alert.title = "Limit Exceeded";
    alert.message = msg;
    alert.showAlertDialog(context);
  }

  void _toggleImageVisibility(UploadType type,
      [int index = -1, int imageIndex = -1]) {
    // Regarding the [], it's used in Dart to make a function parameter optional.
    setState(() {
      switch (type) {
        case UploadType.BaseImage:
          _showBaseImage = !_showBaseImage;
          break;
        case UploadType.SlideshowImage:
          setState(() {
            if (index >= 0 && index < _showSlideImages.length) {
              _showSlideImages[index] = !_showSlideImages[index];
            }
          });
          break;
        case UploadType.FlagImage:
          setState(() {
            countries[index]['showFlags'][imageIndex] =
                !countries[index]['showFlags'][imageIndex];
          });
          break;
      }
    });
  }

  void _removeImage(UploadType type, [int index = -1, int imageIndex = -1]) {
    setState(() {
      switch (type) {
        case UploadType.BaseImage:
          _baseImage = null;
          _showBaseImage = false;
          break;
        case UploadType.SlideshowImage:
          if (index >= 0 && index < _slideImages.length) {
            _slideImages.removeAt(index);
            _showSlideImages.removeAt(index);
          }
          break;
        case UploadType.FlagImage:
          countries[index]['flagImages'].removeAt(imageIndex);
          countries[index]['showFlags'].removeAt(imageIndex);

          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    continent = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    continent.dispose();
  }

  void sendDataToBackend() async {
    FormData formData = FormData();

    // You can use a Map<String, dynamic> to build your form data, but when dealing with file uploads and multipart form data, FormData from the dio package is more appropriate. This is because FormData is specifically designed to handle file uploads and mixed data types in a way that traditional Map<String, dynamic> cannot.

    // Extract continent name
    formData.fields.add(MapEntry('title', continent.text));

    // Extract base image file
    if (_baseImage != null) {
      formData.files.add(MapEntry(
        'base_img',
        await MultipartFile.fromFile(
          _baseImage!.path,
          filename: path.basename(_baseImage!.path),
        ),
      ));
    }

    // Extract slideshow images
    for (int i = 0; i < _slideImages.length; i++) {
      formData.files.add(MapEntry(
        'slideshows[]',
        await MultipartFile.fromFile(
          _slideImages[i].path,
          filename: path.basename(_slideImages[i].path),
        ),
      ));
    }

    // Extract tags data
    List<Map<String, dynamic>> tags = [
      {"fact": []},
      {"tagline": []}
    ];
    // print(tags);

    for (var fact in facts) {
      tags[0]["fact"].add(fact);
    }
    for (var line in lines) {
      tags[1]["tagline"].add(line);
    }
    // print(tags);

    formData.fields.add(MapEntry('tags', jsonEncode(tags)));

    // Extract countries data
    for (var country in countries) {
      formData.fields.add(MapEntry(
          'countries[${countries.indexOf(country)}][country]',
          country['country']));

      if (country['flagImages'].isNotEmpty) {
        formData.files.add(MapEntry(
          'countries[${countries.indexOf(country)}][flag]',
          await MultipartFile.fromFile(
            country['flagImages'][0].path,
            filename: path.basename(country['flagImages'][0].path),
          ),
        ));
      }
    }

    // print('FormData: ${formData.fields}');
    // formData.files.forEach((file) {
    //   print('${file.key}: ${file.value}');
    // });

    AlertLoading().showAlertDialog(context);
    final response = await LocationController().createContinent(formData);
    AlertLoading().closeDialog(context);

    print(response);

    if (response['status'] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    } else {
      print(response['message']);
      alert.message = response['message'];
      alert.showAlertDialog(context);
    }
  }

  // void sendDataToBackend() async {
  //   Map<String, dynamic> formData = {};
  //   // Extract continent name
  //   formData["title"] = continent.text;
  //   // Extract base image path
  //   if (_baseImage != null) {
  //     formData["base_img"] = path.basename(_baseImage!.path);
  //     // sending as a file
  //     // formData["base_img"] = await MultipartFile.fromFile(
  //     //   _baseImage!.path,
  //     //   filename: path.basename(_baseImage!.path),
  //     // );
  //     // another scenarios
  //     // formData["base_img"] = _baseImage!.path.split('/').last; // Assuming you want just the file name
  //   }
  //   // Extract slideshow images paths
  //   List<String> slideshowImages = [];
  //   for (File image in _slideImages) {
  //     slideshowImages.add(image.path.split('\\').last);
  //   }
  //   formData["slideshows"] = jsonEncode({
  //     'img1': slideshowImages.length > 0 ? slideshowImages[0] : '',
  //     'img2': slideshowImages.length > 1 ? slideshowImages[1] : '',
  //     'img3': slideshowImages.length > 2 ? slideshowImages[2] : '',
  //     'img4': slideshowImages.length > 3 ? slideshowImages[3] : ''
  //   });
  //   // Extract tags data
  //   List<Map<String, dynamic>> tags = [
  //     {'facts': facts},
  //     {'lines': lines}
  //   ];
  //   formData["tags"] = jsonEncode(tags);
  //   // Extract countries data
  //   List<Map<String, dynamic>> countryData = [];
  //   for (var country in countries) {
  //     Map<String, dynamic> countryInfo = {
  //       'country': country['country'],
  //       'flag': country['flagImages'].isNotEmpty
  //           ? country['flagImages'][0].path.split('\\').last
  //           : ''
  //     };
  //     countryData.add(countryInfo);
  //   }
  //   formData["countries"] = jsonEncode(countryData);
  //   print(formData);
  //   AlertLoading().showAlertDialog(context);
  //   final response = await LocationController().createContinent(formData);
  //   AlertLoading().closeDialog(context);
  //   print(response);
  //   if (response['status'] == "error") {
  //     alert.message = response['message'];
  //     alert.showAlertDialog(context);
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: sendDataToBackend,
        child: const Text('Create'),
      ),
      appBar: CustomAppBar().generalbar(context, "Create A New Continent Tab"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomTextField.input(context,
                  fieldname: "Continent",
                  hint: "Africa",
                  controller: continent),
              SizedBox(
                height: 2.h,
              ),
              _buildImage(UploadType.BaseImage),
              SizedBox(
                height: 2.h,
              ),
              _buildCarousel(UploadType.SlideshowImage),
              SizedBox(
                height: 2.h,
              ),
              _buildFactsSector(),
              SizedBox(
                height: 2.h,
              ),
              _buildTagsSection(),
              SizedBox(
                height: 2.h,
              ),
              _buildCountries(UploadType.FlagImage),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(UploadType type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Continent Base Image:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        // spreading array to display the widgets
        if (_baseImage != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selected File: ${path.basename(_baseImage!.path)}'),
              GestureDetector(
                  onTap: () {
                    _toggleImageVisibility(UploadType.BaseImage);
                  },
                  child: Text(
                    "${_showBaseImage ? "Close" : "View"} Image",
                    style: TextStyle(
                        color: _showBaseImage ? Colors.red : Colors.green),
                  )),
              GestureDetector(
                  onTap: () {
                    _removeImage(UploadType.BaseImage);
                  },
                  child: const Text("Remove File")),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          if (_showBaseImage)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35.h,
                  child: Image.file(_baseImage!),
                ),
              ],
            ),
          SizedBox(
            height: 2.h,
          ),
        ] else ...[
          const Text(
              "No Image currently selected... You can't select multiple images."),
        ],
        // if (_baseImage != null) Image.file(_baseImage!),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Btns().continentImgBtn(context, () {
              _uploadImage(type);
            }),
          ],
        )
      ],
    );
  }

  Widget _buildCarousel(UploadType type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Continent Slideshow Images:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        if (_slideImages.isNotEmpty) ...[
          ..._slideImages.asMap().entries.map((entry) {
            int index = entry.key;
            File image = entry.value;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Selected File: ${path.basename(image.path)}'),
                    GestureDetector(
                        onTap: () {
                          _toggleImageVisibility(
                              UploadType.SlideshowImage, index);
                        },
                        child: Text(
                          "${_showSlideImages[index] ? "Close" : "View"} Image",
                          style: TextStyle(
                              color: _showSlideImages[index]
                                  ? Colors.red
                                  : Colors.green),
                        )),
                    GestureDetector(
                        onTap: () {
                          _removeImage(UploadType.SlideshowImage, index);
                        },
                        child: const Text("Remove File")),
                  ],
                ),
                if (_showSlideImages[index])
                  SizedBox(
                    height: 35.h,
                    child: Image.file(image),
                  ),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
        ] else ...[
          const Text(
              "No Images currently selected... You can select up to 4 images."),
        ],
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Btns().continentImgBtn(context, () {
              _uploadImage(type);
            }),
          ],
        )
      ],
    );
  }

  Widget _buildFactsSector() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Continent Facts:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ListView.builder(
          shrinkWrap: true,
          itemCount: facts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField.input(
                      context,
                      fieldname: "Key",
                      onChanged: (value) {
                        facts[index]['key'] = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField.input(
                      context,
                      fieldname: "Value",
                      onChanged: (value) {
                        facts[index]['value'] = value;
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 1.h),
        Btns().continentBtn(context, "Add Fact", () {
          setState(() {
            facts.add({'key': '', 'value': ''});
          });
        })
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Continent TagLines:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ListView.builder(
          shrinkWrap: true,
          itemCount: lines.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CustomTextField.input(
                context,
                fieldname: "Value",
                onChanged: (value) {
                  lines[index]['value'] = value;
                },
              ),
            );
          },
        ),
        SizedBox(height: 1.h),
        Btns().continentBtn(context, "Add TagLine", () {
          setState(() {
            lines.add({'value': ''});
          });
        })
      ],
    );
  }

  Widget _buildCountries(UploadType type) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Continent Countries:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ListView.builder(
          shrinkWrap: true,
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField.input(
                          context,
                          fieldname: "Country",
                          hint: "nigeria",
                          onChanged: (value) {
                            countries[index]['country'] = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text("Flags"),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Btns().continentBtn(context, "Upload Flag Image", () {
                            _uploadImage(type, index);
                          }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  if (countries[index]['flagImages'].isNotEmpty) ...[
                    ...countries[index]['flagImages']
                        .asMap()
                        .entries
                        .map((entry) {
                      int imageIndex = entry.key;
                      File image = entry.value;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Selected File: ${path.basename(image.path)}'),
                              GestureDetector(
                                onTap: () {
                                  _toggleImageVisibility(
                                      UploadType.FlagImage, index, imageIndex);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "${countries[index]['showFlags'][imageIndex] ? "Close" : "View"} Image",
                                      style: TextStyle(
                                          color: countries[index]['showFlags']
                                                  [imageIndex]
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                    const SizedBox(width: 15),
                                    if (countries[index]['showFlags']
                                        [imageIndex])
                                      SizedBox(
                                        height: 15.h,
                                        child: Image.file(image),
                                      ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _removeImage(
                                      UploadType.FlagImage, index, imageIndex);
                                },
                                child: const Text("Remove File"),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ] else ...[
                    const Text("No image uploaded."),
                  ],
                ],
              ),
            );
          },
        ),
        SizedBox(height: 1.h),
        Btns().continentBtn(context, "Add Country", () {
          setState(() {
            countries.add({'country': '', 'flagImages': [], 'showFlags': []});
            // print(countries);
          });
        }),
        SizedBox(height: 15.h),
      ],
    );
  }
}
