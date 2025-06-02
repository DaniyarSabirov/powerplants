import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/plant.dart';

class PlantListWidget extends StatefulWidget {
  final VoidCallback onDelete;
  final Plant plant;

  const PlantListWidget({
    super.key,
    required this.plant,
    required this.onDelete,
  });

  @override
  State<PlantListWidget> createState() => _PlantListWidgetState();
}

class _PlantListWidgetState extends State<PlantListWidget> {
  double offsetX = 0;

  void slideLeftAndBack() async {
    setState(() {
      offsetX = -100;
    });

    await Future.delayed(Duration(milliseconds: 1500));

    setState(() {
      offsetX = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -500) {
            slideLeftAndBack();
          }
        },
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/plantoverview', arguments: widget.plant);
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: GestureDetector(
                  onTap: widget.onDelete,
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade700,
                      size: 30,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.translationValues(offsetX, 0, 0),
                curve: Curves.easeOutBack,
                width: 375,
                height: 150,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: (widget.plant.imageUrl != null &&
                              widget.plant.imageUrl!.isNotEmpty &&
                              File(widget.plant.imageUrl!).existsSync())
                          ? Image.file(
                              File(widget.plant.imageUrl!),
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              color: colorScheme.surfaceDim,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 48,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                            ),
                            child: Text(
                              widget.plant.name,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              widget.plant.scientificName,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 32,
                              left: 16,
                            ),
                            child: Text(
                              widget.plant.description ?? '',
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
