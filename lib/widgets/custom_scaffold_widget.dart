import 'package:flutter/material.dart';

class CustomScaffoldWidget extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  const CustomScaffoldWidget({
    super.key,
    this.padding = const EdgeInsets.only(top: 64, left: 24, right: 24),
    required this.children,
  });

  @override
  State<CustomScaffoldWidget> createState() => _CustomScaffoldWidgetState();
}

class _CustomScaffoldWidgetState extends State<CustomScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: widget.padding,
            child: Column(
              children: widget.children,
            ),
          ),
          Hero(
            tag: 'toolbar',
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 375,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).popUntil(
                              (route) => route.isFirst,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/profile');
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: colorScheme.secondary,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: colorScheme.onSecondary,
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
          ),
        ],
      ),
    );
  }
}
