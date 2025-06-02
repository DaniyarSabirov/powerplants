import 'package:flutter/material.dart';
import 'package:frontend/models/plant.dart';
import 'package:frontend/services/api_client.dart';
import 'package:frontend/services/plant_service.dart';
import 'package:frontend/widgets/custom_scaffold_widget.dart';
import 'package:frontend/widgets/plant_list_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupOverview extends StatefulWidget {
  final String groupId;
  const GroupOverview({super.key, required this.groupId});

  @override
  State<GroupOverview> createState() => _GroupOverviewState();
}

class _GroupOverviewState extends State<GroupOverview> {
  List<Plant> plants = [];
  late final PlantService plantService;

  @override
  void initState() {
    super.initState();
    plantService = PlantService(ApiClient('http://10.0.2.2:8080/api'));
    plantService.getPlantsByGroupId(widget.groupId).then((data) {
      setState(() {
        plants = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              Navigator.of(context).pushNamed('/addplant',
                                  arguments: widget.groupId);
                            }),
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: Theme.of(context).colorScheme.onSurface,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .group_overview_no_plants,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            for (final plant in plants)
                              PlantListWidget(
                                plant: plant,
                                onDelete: () => {
                                  setState(() {
                                    plantService
                                        .deletePlant(widget.groupId, plant.id!)
                                        .then((value) {
                                      setState(() {
                                        plants.remove(plant);
                                      });
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
        ),
      ],
    );
  }
}
