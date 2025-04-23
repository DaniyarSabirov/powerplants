import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({super.key});

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  File? _imageFile;
  final _picker = ImagePicker();
  int? _selectedIndex = 0;
  final List<String> groups = [
    'Living Room',
    'Kitchen',
    'Window plants',
    'Hanging plants',
    'Bedroom',
    'Hallway',
    'Sensitive plants',
  ];
  int _currentStep = 0;

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 800,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentStep == 0,
      onPopInvokedWithResult: (didPop, result) => {
        if (!didPop && _currentStep > 0)
          {
            setState(() => _currentStep--),
          },
      },
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  color: Color(0xFFE0E0E0),
                  child: _imageFile == null
                      ? Icon(Icons.add_a_photo, size: 48, color: Colors.grey)
                      : Image.file(_imageFile!, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 400, top: 250),
                  child: GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFCFCFC),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.edit_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
              top: 300,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.transparent,
                        ),
                        child: Stepper(
                          type: StepperType.horizontal,
                          currentStep: _currentStep,
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            return SizedBox.shrink();
                          },
                          steps: [
                            Step(
                              title: Text(
                                AppLocalizations.of(context)!.add_plant_plant,
                                style: TextStyle(
                                  color: _currentStep >= 0
                                      ? Color(0xFF92A56E)
                                      : Color(0xFFF2F2F2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: 0 < _currentStep
                                  ? StepState.complete
                                  : 0 == _currentStep
                                      ? StepState.indexed
                                      : StepState.disabled,
                              stepStyle: StepStyle(
                                indexStyle: TextStyle(
                                  color: Color(0xFFFCFCFC),
                                  fontWeight: FontWeight.bold,
                                ),
                                color: _currentStep > -1
                                    ? Color(0xFF92A56E)
                                    : Color(0xFFF2F2F2),
                                border: Border.all(
                                  color: _currentStep > -1
                                      ? Color(0xFF92A56E)
                                      : Color(0xFFF2F2F2),
                                  width: 1,
                                ),
                                connectorColor: _currentStep > 0
                                    ? Color(0xFF92A56E)
                                    : Color(0xFFF2F2F2),
                                connectorThickness: 1,
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                            .add_plant_name +
                                        '*',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 24, top: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: TextField(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .add_plant_name_hint,
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                            .add_plant_scientific_name +
                                        '*',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 24, top: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: TextField(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                          hintText: AppLocalizations.of(
                                                  context)!
                                              .add_plant_scientific_name_hint,
                                          hintStyle: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                            .add_plant_group +
                                        '*',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 24, top: 4),
                                    height: 50,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        spacing: 8,
                                        children: List.generate(groups.length,
                                            (index) {
                                          final isSelected =
                                              _selectedIndex == index;
                                          return ChoiceChip(
                                            label: Text(
                                              groups[index],
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Color(0xFFFCFCFC)
                                                    : Color(0xFF92A56E),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            selected: isSelected,
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                color: !isSelected
                                                    ? Color(0xFFF2F2F2)
                                                    : Color(0xFF92A56E),
                                              ),
                                            ),
                                            backgroundColor: Color(0xFFFCFCFC),
                                            selectedColor: Color(0xFF92A56E),
                                            checkmarkColor: Color(0xFFFCFCFC),
                                            onSelected: (selected) {
                                              setState(() {
                                                _selectedIndex =
                                                    selected ? index : null;
                                              });
                                            },
                                            showCheckmark: false,
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .add_plant_description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 24, top: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: TextField(
                                        maxLength: 300,
                                        minLines: 1,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .add_plant_description_hint,
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Step(
                              title: Text(
                                AppLocalizations.of(context)!.add_plant_care,
                                style: TextStyle(
                                  color: _currentStep >= 1
                                      ? Color(0xFF92A56E)
                                      : Color(0xFFF2F2F2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isActive: _currentStep >= 1,
                              state: 1 < _currentStep
                                  ? StepState.complete
                                  : 1 == _currentStep
                                      ? StepState.indexed
                                      : StepState.disabled,
                              stepStyle: StepStyle(
                                indexStyle: TextStyle(
                                  color: Color(0xFFFCFCFC),
                                  fontWeight: FontWeight.bold,
                                ),
                                color: _currentStep > 0
                                    ? Color(0xFF92A56E)
                                    : Color(0xFFF2F2F2),
                                border: Border.all(
                                  color: _currentStep > 0
                                      ? Color(0xFF92A56E)
                                      : Color(0xFFF2F2F2),
                                  width: 1,
                                ),
                                connectorColor: _currentStep > 1
                                    ? Color(0xFF92A56E)
                                    : Color(0xFFF2F2F2),
                                connectorThickness: 1,
                              ),
                              content: Container(),
                            ),
                            Step(
                              title: Text(
                                AppLocalizations.of(context)!.add_plant_confirm,
                                style: TextStyle(
                                  color: _currentStep >= 2
                                      ? Color(0xFF92A56E)
                                      : Color(0xFFF2F2F2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isActive: _currentStep >= 2,
                              state: 2 < _currentStep
                                  ? StepState.complete
                                  : 2 == _currentStep
                                      ? StepState.indexed
                                      : StepState.disabled,
                              stepStyle: StepStyle(
                                indexStyle: TextStyle(
                                  color: Color(0xFFFCFCFC),
                                  fontWeight: FontWeight.bold,
                                ),
                                color: _currentStep > 1
                                    ? Color(0xFF92A56E)
                                    : Color(0xFFF2F2F2),
                                border: Border.all(
                                  color: _currentStep > 1
                                      ? Color(0xFF92A56E)
                                      : Color(0xFFF2F2F2),
                                  width: 1,
                                ),
                                connectorColor: _currentStep > 2
                                    ? Color(0xFF92A56E)
                                    : Color(0xFFF2F2F2),
                                connectorThickness: 1,
                              ),
                              content: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _currentStep++;
                          }),
                          child: Container(
                            margin: EdgeInsets.only(top: 8, bottom: 36),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF616E54),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .add_plant_care_schedule,
                                style: TextStyle(
                                  color: Color(0xFFFCFCFC),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
