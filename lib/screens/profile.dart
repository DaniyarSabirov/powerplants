import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final settings = [
    (
      icon: Icons.notifications_active_rounded,
      text: 'Configure your notification'
    ),
    (icon: Icons.invert_colors_on_rounded, text: 'Change your theme'),
    (icon: Icons.language_rounded, text: 'Set your language'),
  ];
  var colorScheme;
  final lastActivities = [
    'Monstera',
    'Yucca',
    'Philodendron',
    'Fern',
  ];
  var theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    colorScheme = ColorScheme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1497250681960-ef046c08a56e?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text(
                      'Michael',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'michael@winsauer.de',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 350,
                      height: 100,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                          color: colorScheme.surfaceDim,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/plant.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '19',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                'Plants',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 2,
                            color: colorScheme.surfaceDim,
                            margin: EdgeInsets.symmetric(vertical: 12),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done_all_rounded,
                                size: 24,
                                color: colorScheme.onSurface,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '35',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                'Tasks done',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 2,
                            color: colorScheme.surfaceDim,
                            margin: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.house_siding_rounded,
                                size: 24,
                                color: colorScheme.onSurface,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text(
                                'Houses',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 24,
                        ),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Column(
                        children: List.generate(
                          settings.length,
                          (index) => buildSettings(index),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 16,
                        ),
                        child: Text(
                          'Your last activities',
                          style: TextStyle(
                            fontSize: 20,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: List.generate(
                              lastActivities.length,
                              (index) => buildLastActivities(index),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 112.5),
              height: 175,
              width: 175,
              decoration: BoxDecoration(
                color: colorScheme.surfaceDim,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: colorScheme.surface, width: 5),
              ),
              child: Icon(
                Icons.person_outline_rounded,
                color: colorScheme.onPrimary,
                size: 126,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSettings(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        height: 50,
        decoration: BoxDecoration(
          color: colorScheme.surfaceDim,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(
                settings[index].icon,
                color: colorScheme.onSurface,
              ),
            ),
            Text(settings[index].text),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLastActivities(int index) {
    return Container(
      height: 75,
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            Icons.image,
            color: colorScheme.onSurface,
            size: 64,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    lastActivities[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      color: colorScheme.secondary,
                    ),
                    Text(
                      DateTime.timestamp().toString(),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
