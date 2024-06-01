import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Continents extends StatefulWidget {
  const Continents({super.key});

  @override
  State<Continents> createState() => _ContinentsState();
}

class _ContinentsState extends State<Continents> {
  List continentsData = [];
  String api = "http://10.0.2.2:8000";
  // String api = "http://realityshift.com";
  void loadData() async {
    final response = await LocationController().fetchAllContinents();
    // print(response);

    if (response["continents"] != null) {
      setState(() {
        continentsData = response["continents"];
        // print(continentsData);
      });
    }
    // print(continentsData[1]["base_img"]);
  }

  // void loadData() async {
  //   final response = await LocationController().fetchAllContinents();
  //   print(response);
  //   if (response["continents"] != null) {
  //     List continents = response["continents"];
  //     // Parse the JSON strings for each continent
  //     for (var continent in continents) {
  //       continent['slideshows'] = jsonDecode(continent['slideshows']);
  //       continent['tags'] = jsonDecode(continent['tags']);
  //       continent['countries'] = jsonDecode(continent['countries']);
  //     }
  //     setState(() {
  //       continentsData = continents;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  // Function to load details for a specific continent
  void loadContinentDetails(int index) async {
    final continent = continentsData[index];
    print(continent);
    final continentDetails =
        await LocationController().continentDetails(continent["id"]);
    print(continentDetails);
    // Navigate to the details screen and pass the continent details
    Navigator.pushNamed(context, "locations",
        arguments: {"details": continentDetails});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar().welcomebar(context, "Select a Continent to Explore:"),
      body: continentsData.isEmpty
          ? CustomErrorScreen.buildErrorWidget()
          : _buildContentWidget(),
    );
  }

  Widget _buildContentWidget() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 0,
          ),
          itemCount: continentsData.length,
          itemBuilder: (context, index) {
            final title = continentsData[index]["title"];
            final base = continentsData[index]["base_img"];
            // print(continentsData[index]["title"]);
            // print(continentsData[index]["slideshows"]);
            // print(continentsData[index]["tags"]);
            // print(continentsData[index]["countries"]);
            return GestureDetector(
              onTap: () {
                loadContinentDetails(index);
              },
              child: Card(
                surfaceTintColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(34)),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          "$api/Continents/$title/Image/$base",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      continentsData[index]["title"],
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
