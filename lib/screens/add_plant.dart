import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
  final careRules = [];
  final ruleTypes = [
    (type: 'Water', icon: Icons.water_drop_outlined, label: 'Amount'),
    (type: 'Prune', icon: Icons.cut_rounded, label: 'Amount'),
    (type: 'Light', icon: Icons.wb_sunny_outlined, label: 'Duration'),
    (type: 'Custom', icon: Icons.auto_awesome_rounded, label: 'Description'),
  ];
  int? _selectedRuleTypeIndex = 0;
  final pruneAmount = [
    'A little',
    'More',
    'A Lot',
  ];
  String? _selectedPruneAmount = 'A little';
  final weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  Set<int> selectedDays = {};
  int weekInterval = 1;

  final TextEditingController plantNameController = TextEditingController();
  final TextEditingController plantScientificNameController =
      TextEditingController();
  final TextEditingController plantDescriptionController =
      TextEditingController();
  final TextEditingController careRuleNameController = TextEditingController();
  final TextEditingController careRuleInstructionController =
      TextEditingController();
  final TextEditingController careRuleWaterAmountController =
      TextEditingController();
  final TextEditingController careRuleDescriptionController =
      TextEditingController();
  final TextEditingController careRuleDurationController =
      TextEditingController();

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
                    child: _currentStep == 0
                        ? Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFFCFCFC),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              Icons.edit_rounded,
                              color: Color(0xFF616E54),
                            ),
                          )
                        : Container(),
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
                                    '${AppLocalizations.of(context)!.add_plant_name}*',
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
                                        controller: plantNameController,
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
                                    '${AppLocalizations.of(context)!.add_plant_scientific_name}*',
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
                                        controller:
                                            plantScientificNameController,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!
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
                                    '${AppLocalizations.of(context)!.add_plant_group}*',
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
                                        controller: plantDescriptionController,
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
                              content: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: careRules.isEmpty
                                        ? [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFCFCFC),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'No Care Rules set yet...',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                        : List.generate(
                                            careRules.length,
                                            (index) => displayCareRules(index),
                                          ),
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      setState(() {
                                        showAddRuleDialog();
                                      }),
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFCFCFC),
                                        border: Border.all(
                                          color: Color(0xFFF2F2F2),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 64,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

  Widget displayCareRules(final index) {
    final indices = careRules[index].scheduleWeekDays.toList()..sort();
    final scheduledDays = indices.map((d) => weekDays[d]).join(', ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF2F2F2), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            ruleTypes[getRuleTypeIndexByType(
                                    careRules[index].type)]
                                .icon,
                            color: Color(0xFF616E54),
                          ),
                          Text(
                            careRules[index].name,
                            style: TextStyle(
                              color: Color(0xFF616E54),
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${careRules[index].instruction}: ${careRules[index].ruleData}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$scheduledDays every ${careRules[index].scheduleIntervalWeeks} week${careRules[index].scheduleIntervalWeeks > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat.MMMEd()
                            .add_Hm()
                            .format(careRules[index].timestamp),
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 64,
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: double.infinity,
                          color: Color(0xFFF2F2F2),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF616E54),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            careRules.removeAt(index);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          color: Colors.red.shade300,
                          child: Icon(
                            Icons.delete_forever_outlined,
                            color: Color(0xFFFCFCFC),
                            size: 24,
                          ),
                        ),
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

  void showAddRuleDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFCFCFC),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24, top: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF92A56E),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: List.generate(4, (index) {
                              final isSelected =
                                  _selectedRuleTypeIndex == index;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    _selectedRuleTypeIndex = index;
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Color(0xFF92A56E)
                                          : Colors.transparent,
                                      border: Border(
                                        left: index > 0
                                            ? BorderSide(
                                                color: Color(0xFF92A56E),
                                                width: 2,
                                              )
                                            : BorderSide.none,
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            ruleTypes[index].icon,
                                            color: isSelected
                                                ? Color(0xFFFCFCFC)
                                                : Color(0xFF92A56E),
                                          ),
                                          Text(
                                            ruleTypes[index].type,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: isSelected
                                                  ? Color(0xFFFCFCFC)
                                                  : Color(0xFF92A56E),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Name',
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
                        color: Color(
                          0xFFF2F2F2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: TextField(
                          controller: careRuleNameController,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)!
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
                      'Instruction',
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
                          controller: careRuleInstructionController,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)!
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
                    StatefulBuilder(
                      builder: (context, setState) {
                        switch (ruleTypes[_selectedRuleTypeIndex!].type) {
                          case 'Prune':
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ruleTypes[_selectedRuleTypeIndex!].label,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    bottom: 24,
                                    top: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        dropdownColor: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 0,
                                        isExpanded: true,
                                        value: _selectedPruneAmount,
                                        hint: Text(
                                          AppLocalizations.of(context)!
                                              .add_plant_scientific_name_hint,
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: Colors.grey),
                                        items: pruneAmount.map((instr) {
                                          return DropdownMenuItem<String>(
                                            value: instr,
                                            child: Text(
                                              instr,
                                              style: TextStyle(
                                                fontFamily: 'Manrope',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _selectedPruneAmount = newVal;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          case 'Light':
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ruleTypes[_selectedRuleTypeIndex!].label,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 150,
                                      margin: EdgeInsets.only(
                                        bottom: 24,
                                        top: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: TextField(
                                          controller:
                                              careRuleDurationController,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                          keyboardType: TextInputType.number,
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
                                    Container(
                                      height: 40,
                                      width: 128,
                                      margin: EdgeInsets.only(
                                        bottom: 24,
                                        top: 4,
                                        right: 64,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFCFCFC),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: Color(0xFFF2F2F2),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'minutes',
                                            style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          case 'Custom':
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ruleTypes[_selectedRuleTypeIndex!].label,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
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
                                      controller: careRuleDescriptionController,
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
                                        hintText: AppLocalizations.of(context)!
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
                            );
                          case 'Water':
                          default:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ruleTypes[_selectedRuleTypeIndex!].label,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 150,
                                      margin: EdgeInsets.only(
                                        bottom: 24,
                                        top: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: TextField(
                                          controller:
                                              careRuleWaterAmountController,
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
                                    Container(
                                      height: 40,
                                      width: 64,
                                      margin: EdgeInsets.only(
                                        bottom: 24,
                                        top: 4,
                                        right: 64,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFCFCFC),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: Color(0xFFF2F2F2),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ml',
                                            style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                        }
                      },
                    ),
                    Text(
                      'Schedule',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(weekDays.length, (index) {
                          final selected = selectedDays.contains(index);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected) {
                                  selectedDays.remove(index);
                                } else {
                                  selectedDays.add(index);
                                }
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 75,
                              decoration: BoxDecoration(
                                color: selected
                                    ? Color(0xFF92A56E)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: selected
                                      ? Color(0xFF92A56E)
                                      : Color(0xFF616E54),
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  weekDays[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: selected
                                        ? Color(0xFFFCFCFC)
                                        : Color(0xFF616E54),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Text(
                      'Repeat every',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 40,
                      width: 200,
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (weekInterval > 1) {
                                  weekInterval--;
                                }
                              });
                            },
                            child: Icon(Icons.remove, size: 20),
                          ),
                          Text(
                            '$weekInterval week${weekInterval > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (weekInterval < 52) {
                                  weekInterval++;
                                }
                              });
                            },
                            child: Icon(Icons.add, size: 20),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => this.setState(() {
                            String? data;

                            switch (ruleTypes[_selectedRuleTypeIndex!].type) {
                              case 'Prune':
                                data = _selectedPruneAmount;
                                break;

                              case 'Light':
                                data = careRuleDurationController.text;
                                break;

                              case 'Custom':
                                data = careRuleDescriptionController.text;
                                break;

                              case 'Water':
                              default:
                                data = careRuleWaterAmountController.text;
                                break;
                            }
                            careRules.add(
                              (
                                name: careRuleNameController.text,
                                instruction: careRuleInstructionController.text,
                                type: ruleTypes[_selectedRuleTypeIndex!].type,
                                ruleData: data,
                                timestamp: DateTime.timestamp(),
                                scheduleWeekDays: selectedDays,
                                scheduleIntervalWeeks: weekInterval,
                              ),
                            );
                            Navigator.of(context).pop();
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
                                AppLocalizations.of(context)!.save,
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
            );
          },
        );
      },
    );
  }

  int getRuleTypeIndexByType(String type) {
    for (int i = 0; i < ruleTypes.length; i++) {
      if (ruleTypes[i].type == type) {
        return i;
      }
    }

    return 0;
  }
}
