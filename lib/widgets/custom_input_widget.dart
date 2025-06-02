import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_label_widget.dart';

class CustomInputWidget extends StatefulWidget {
  final String? label;
  final String? hint;
  final bool isValid;
  final bool isRequired;
  final TextEditingController controller;
  final bool isTextArea;

  const CustomInputWidget({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.isValid = true,
    this.isRequired = false,
    this.isTextArea = false,
  });

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final theme = Theme.of(context);
    final requiredIndicator = widget.isRequired ? '*' : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? CustomLabelWidget(
                label: widget.label! + requiredIndicator,
              )
            : Container(),
        !widget.isTextArea
            ? Container(
                height: 40,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 24, top: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  border: !widget.isValid
                      ? Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: 2,
                          color: Colors.red.shade200,
                        )
                      : Border.all(width: 0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: widget.controller,
                    style: theme.textTheme.labelSmall,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: theme.textTheme.labelSmall,
                    ),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 24, top: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: widget.controller,
                    maxLength: 255,
                    minLines: 1,
                    maxLines: null,
                    style: theme.textTheme.labelSmall,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
