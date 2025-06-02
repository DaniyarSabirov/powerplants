import 'package:flutter/material.dart';

class CustomLabelWidget extends StatefulWidget {
  final String? label;

  const CustomLabelWidget({
    super.key,
    this.label,
  });

  @override
  State<CustomLabelWidget> createState() => _CustomLabelWidgetState();
}

class _CustomLabelWidgetState extends State<CustomLabelWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      widget.label!,
      style: theme.textTheme.labelLarge,
    );
  }
}
