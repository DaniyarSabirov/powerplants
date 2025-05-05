import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/models/plant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantOverview extends StatefulWidget {
  const PlantOverview({super.key});

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {
  late final Plant plant;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    plant = ModalRoute.of(context)!.settings.arguments as Plant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 550,
                color: Color(0xFFE0E0E0),
                child: plant.imageUrl == null
                    ? Icon(Icons.add_a_photo, size: 48, color: Colors.grey)
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
                      color: Color(0x9FF2F2F2),
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
                            color: Color(0xFF1B2727),
                          ),
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
                            color: Color(0xFFFCFCFC),
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
                color: Color(0xFFF2F2F2),
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
                    color: Color(0xFFFCFCFC),
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
                                    color: Color(0xFF616E54),
                                    fontFamily: 'Manrope',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  plant.scientificName,
                                  style: TextStyle(
                                    color: Color(0xFF92A56E),
                                    fontFamily: 'Manrope',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit_rounded,
                                color: Color(0xFF616E54),
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
                            color: Color(0xFF616E54),
                            fontFamily: 'Manrope',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!
                        .add_plant_care_schedule_schedule,
                    style: TextStyle(
                      color: Color(0xFF616E54),
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
