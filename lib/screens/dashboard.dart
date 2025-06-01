import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/home_group.dart';
import 'package:frontend/services/api_client.dart';
import 'package:frontend/services/home_group_service.dart';
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

  @override
  void initState() {
    super.initState();
    groupService = HomeGroupService(ApiClient('http://10.0.2.2:8080/api'));
    groupService.getGroupsByHomeId(homeId).then((data) {
      setState(() {
        groups = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<double> factors = [
      1.0,
      1.25,
      1.5,
    ];

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
                final double factor = factors[Random().nextInt(factors.length)];
                final double tileHeight = columnWidth * factor;

                final Widget tile = GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed('/groupoverview'),
                  child: AspectRatio(
                    aspectRatio: 1 / factor,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://cms.interiorcompany.com/wp-content/uploads/2024/01/hang-decorative-plants-from-the-ceiling.jpg',
                              fit: BoxFit.cover,
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
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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

              return SingleChildScrollView(
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
              );
            },
          ),
        ),
      ],
    );
  }
}
