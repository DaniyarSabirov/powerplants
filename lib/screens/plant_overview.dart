import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/plant.dart';

class PlantOverview extends StatefulWidget {
  const PlantOverview({super.key});

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {
  late Plant plant;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    plant = ModalRoute.of(context)!.settings.arguments as Plant;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 550,
                color: colorScheme.surfaceDim,
                child: plant.imageUrl == null || plant.imageUrl == ''
                    ? Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                        color: colorScheme.onSurfaceVariant,
                      )
                    : Image.file(File(plant.imageUrl!), fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 500,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            top: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: 128,
                    maxHeight: 256,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plant.name,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 32,
                                    fontFamily: 'BigCaslon',
                                  ),
                                ),
                                Text(
                                  plant.scientificName,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit_rounded,
                                color: colorScheme.onSurface,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          plant.description ?? '',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 24, bottom: 8),
                //   child: Text(
                //     AppLocalizations.of(context)!
                //         .add_plant_care_schedule_schedule,
                //     style: TextStyle(
                //       color: colorScheme.primary,
                //
                //       fontSize: 20,
                //
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
