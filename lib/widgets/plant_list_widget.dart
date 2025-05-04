import 'dart:io';

import 'package:flutter/material.dart';

class PlantListWidget extends StatefulWidget {
  final VoidCallback onDelete;
  final String title;
  final String? image;
  const PlantListWidget({
    super.key,
    required this.title,
    this.image,
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
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -500) {
            slideLeftAndBack();
          }
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
                color: Color(0xFFFCFCFC),
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
                    child: (widget.image != null &&
                            widget.image!.isNotEmpty &&
                            File(widget.image!).existsSync())
                        ? Image.file(
                            File(widget.image!),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          )
                        : Container(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 18,
                            ),
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
    );
  }
}
