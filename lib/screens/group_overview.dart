import 'package:flutter/material.dart';
import 'package:frontend/models/plant.dart';
import 'package:frontend/services/api_client.dart';
import 'package:frontend/services/plant_service.dart';
import 'package:frontend/widgets/plant_list_widget.dart';

class GroupOverview extends StatefulWidget {
  const GroupOverview({super.key});

  @override
  State<GroupOverview> createState() => _GroupOverviewState();
}

class _GroupOverviewState extends State<GroupOverview> {
  List<Plant> plants = [];
  late final PlantService plantService;
  final groupId = '4c8f6d82-e4c6-4478-92eb-d9342500f006';

  @override
  void initState() {
    super.initState();
    plantService = PlantService(ApiClient('http://10.0.2.2:8080/api'));
    plantService.getPlantsByGroupId(groupId).then((data) {
      setState(() {
        plants = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: 375,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFF1B2727),
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFF92A56E),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          // plants.add(
                          //   (
                          //     title: 'New Plant',
                          //     image:
                          //         'https://media.istockphoto.com/id/1147544807/de/vektor/miniaturbild-vektorgrafik.jpg?s=612x612&w=0&k=20&c=IIK_u_RTeRFyL6kB1EMzBufT4H7MYT3g04sz903fXAk='
                          //   ),
                          // );
                          Navigator.of(context).pushNamed('/addplant');
                        }),
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFFCFCFC),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: Color(0xFF1B2727),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        if (plants.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              'No plants found.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        for (final plant in plants)
                          PlantListWidget(
                            plant: plant,
                            onDelete: () => {
                              setState(() {
                                plantService
                                    .deletePlant(groupId, plant.id!)
                                    .then((value) {
                                  plants.remove(plant);
                                });
                              }),
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget insertPlantWidget() {
    double offsetX = 0;

    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -10) {
            setState(() {
              offsetX = -100;
            });
            print('Swipe left');
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform: Matrix4.translationValues(offsetX, 0, 0),
          width: 375,
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFCFCFC),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
