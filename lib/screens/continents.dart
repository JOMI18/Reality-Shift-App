import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Continents extends StatefulWidget {
  const Continents({super.key});

  @override
  State<Continents> createState() => _ContinentsState();
}

class _ContinentsState extends State<Continents> {
  List continentsData = [];

  void loadData() async {
    try {
      final response = await LocationController().allContinents();

      if (response["continents"] != null) {
        setState(() {
          continentsData = response["continents"];
        });
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

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

    // Navigate to the details screen and pass the continent details
    Navigator.pushNamed(context, "locations",
        arguments: {"details": continentDetails});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar().generalbar(context, "Select a Continent to Explore:"),
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
                      child: const CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(
                            "lib/assets/images/continents/africa.jpeg"
                            // "lib/assets/images/continents/${continentsData[index]["base-img"]}",
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
