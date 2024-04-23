import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CreateContinent extends StatefulWidget {
  const CreateContinent({super.key});

  @override
  State<CreateContinent> createState() => _CreateContinentState();
}

class _CreateContinentState extends State<CreateContinent> {
  List<Map<String, String>> facts = [];
  List<Map<String, Image>> countries = [];
  List lines = [];

  late TextEditingController continent;
  late TextEditingController base_img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    continent = TextEditingController();
    base_img = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    continent.dispose();
    base_img.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().welcomebar(context, "Create A New Continent Tab"),
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
              CustomTextField.input(context,
                  fieldname: "Continent Image",
                  hint: "africa.png",
                  controller: base_img),
              SizedBox(
                height: 2.h,
              ),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Continent Facts:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Continent TagLines:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
              ),
              SizedBox(
                height: 2.h,
              ),
              // Column(
              //   children: [
              //     const Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Continent Countries:',
              //           style: TextStyle(
              //               fontSize: 16, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //     SizedBox(height: 1.h),
              //     ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: countries.length,
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 5),
              //           child: CustomTextField.input(
              //             context,
              //             fieldname: "Value",
              //             onChanged: (value) {
              //               countries[index]['value'] = value;
              //             },
              //           ),
              //         );
              //       },
              //     ),
              //     SizedBox(height: 1.h),
              //     Btns().continentBtn(context, "Add TagLine", () {
              //       setState(() {
              //         countries.add({'value': Image.asset("s")});
              //       });
              //     })
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
