import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/home_group.dart';
import 'package:frontend/screens/group_overview.dart';
import 'package:frontend/services/api_client.dart';
import 'package:frontend/services/home_group_service.dart';
import 'package:frontend/widgets/custom_input_widget.dart';
import 'package:frontend/widgets/custom_label_widget.dart';
import 'package:frontend/widgets/custom_scaffold_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<HomeGroup> groups = [];
  late final HomeGroupService groupService;
  final homeId = '50e14f43-dd4e-412f-864d-78943ea28d91';

  final List<double> availableFactors = [1.0, 1.25, 1.5];
  List<double> tileFactors = [];

  @override
  void initState() {
    super.initState();
    groupService = HomeGroupService(ApiClient('http://10.0.2.2:8080/api'));
    groupService.getGroupsByHomeId(homeId).then((data) {
      setState(() {
        groups = data;

        tileFactors = List<double>.generate(
          groups.length,
          (i) => availableFactors[Random().nextInt(availableFactors.length)],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 8.0;

    return CustomScaffoldWidget(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 124),
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double totalWidth = constraints.maxWidth;
              final double columnWidth = (totalWidth - spacing) / 2;

              final List<Widget> leftColumnChildren = [];
              final List<Widget> rightColumnChildren = [];

              double leftHeight = 0;
              double rightHeight = 0;

              for (int i = 0; i < groups.length; i++) {
                final double factor = tileFactors[i];
                final double tileHeight = columnWidth * factor;

                final Widget tile = GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/groupoverview', arguments: groups[i].id),
                  child: AspectRatio(
                    aspectRatio: 1 / factor,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            (groups[i].pictureUrl != '')
                                ? Image.asset(
                                    groups[i].pictureUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors
                                        .primaries[i % Colors.primaries.length]
                                        .shade700,
                                  ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: columnWidth,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    groups[i].publicName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

                if (leftHeight <= rightHeight) {
                  leftColumnChildren.add(tile);
                  leftColumnChildren.add(const SizedBox(height: spacing));
                  leftHeight += tileHeight + spacing;
                } else {
                  rightColumnChildren.add(tile);
                  rightColumnChildren.add(const SizedBox(height: spacing));
                  rightHeight += tileHeight + spacing;
                }
              }

              if (leftColumnChildren.isNotEmpty &&
                  leftColumnChildren.last is SizedBox) {
                leftColumnChildren.removeLast();
              }

              if (rightColumnChildren.isNotEmpty &&
                  rightColumnChildren.last is SizedBox) {
                rightColumnChildren.removeLast();
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              showAddDialog();
                            }),
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceDim,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                Text('Add Group'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: leftColumnChildren,
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: Column(
                            children: rightColumnChildren,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void showAddDialog() {
    bool isGroupNameValid = true;
    final TextEditingController groupNameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputWidget(
                label: 'Group name',
                hint: 'Enter group name...',
                isRequired: true,
                isValid: isGroupNameValid,
                controller: groupNameController,
              ),
              CustomLabelWidget(
                label: 'Upload an Image',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {});
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
                                color: Theme.of(context).colorScheme.onPrimary,
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
  }
}
