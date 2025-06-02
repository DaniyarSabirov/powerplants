import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/home.dart';
import 'package:frontend/models/home_group.dart';
import 'package:frontend/models/plant.dart';
import 'package:frontend/services/api_client.dart';
import 'package:frontend/services/home_group_service.dart';
import 'package:frontend/services/home_service.dart';
import 'package:frontend/services/plant_service.dart';
import 'package:frontend/widgets/custom_input_widget.dart';
import 'package:frontend/widgets/custom_scaffold_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeOverview extends StatefulWidget {
  const HomeOverview({super.key});

  @override
  State<HomeOverview> createState() => _HomeOverviewState();
}

class _HomeOverviewState extends State<HomeOverview> {
  List<Home> homes = [];
  List<List<HomeGroup>> groups = []; // start empty
  List<List<Plant>> plants = []; // start empty

  late final HomeService homeService;
  late final HomeGroupService groupsService;
  late final PlantService plantsService;

  bool isHomeNameValid = true;
  bool isHomeDescriptionValid = true;
  final TextEditingController homeNameController = TextEditingController();
  final TextEditingController homeDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    homeService = HomeService(ApiClient('http://10.0.2.2:8080/api'));
    groupsService = HomeGroupService(ApiClient('http://10.0.2.2:8080/api'));
    plantsService = PlantService(ApiClient('http://10.0.2.2:8080/api'));
    _refreshHomeData();
  }

  void _refreshHomeData() {
    homeService.getAllHomes().then((data) {
      setState(() {
        homes = data;
        groups = List.generate(homes.length, (_) => <HomeGroup>[]);
        plants = List.generate(homes.length, (_) => <Plant>[]);

        for (int i = 0; i < homes.length; i++) {
          _refreshGroupData(homes[i].id!, i);
        }
      });
    });
  }

  void _refreshGroupData(String homeId, int homeIndex) {
    groupsService.getGroupsByHomeId(homeId).then((data) {
      setState(() {
        groups[homeIndex] = data;

        for (int g = 0; g < data.length; g++) {
          final groupId = data[g].id!;
          plantsService.getPlantsByGroupId(groupId).then((plantList) {
            setState(() {
              plants[homeIndex].addAll(plantList);
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 124),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Homes', style: Theme.of(context).textTheme.labelLarge),
            GestureDetector(
              onTap: () {
                setState(() {
                  showAddDialog();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.add_home_outlined,
                        color: Theme.of(context).colorScheme.onSurface),
                    Text('Create a new home',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < homes.length; i++)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/dashboard', arguments: homes[i].id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 400,
                          height: 150,
                          color: Theme.of(context).colorScheme.surfaceDim,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        homes[i].publicName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                        homes[i].description ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Icon(Icons.grid_view_rounded,
                                              size: 24,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          Row(
                                            spacing: 4,
                                            children: [
                                              Text('Groups'),
                                              Text(groups[i].length.toString()),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/plant.svg',
                                            width: 24,
                                            height: 24,
                                            colorFilter: ColorFilter.mode(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          Row(
                                            spacing: 4,
                                            children: [
                                              Text('Plants'),
                                              Text(plants[i].length.toString()),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showAddDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputWidget(
                    label: 'Home name',
                    hint: 'Enter home name...',
                    isRequired: true,
                    isValid: isHomeNameValid,
                    controller: homeNameController,
                  ),
                  CustomInputWidget(
                    label: 'Home description',
                    hint: 'Enter description...',
                    isRequired: true,
                    isValid: isHomeDescriptionValid,
                    controller: homeDescriptionController,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (validateHomeInput()) {
                              final home = Home(
                                publicName: homeNameController.text,
                                description: homeDescriptionController.text,
                              );
                              homeService
                                  .createHome(
                                home,
                              )
                                  .then(
                                (value) {
                                  _refreshHomeData();
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 8, bottom: 36),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.save,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  bool validateHomeInput() {
    if (homeNameController.text != '') {
      isHomeNameValid = true;
    } else {
      isHomeNameValid = false;
    }

    if (homeDescriptionController.text != '') {
      isHomeDescriptionValid = true;
    } else {
      isHomeDescriptionValid = false;
    }

    return isHomeNameValid && isHomeDescriptionValid;
  }
}
