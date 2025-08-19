import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    required this.controller,
    required this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final _isEditableNotifier = ValueNotifier(false);
  final _widthNotifier = ValueNotifier(100.0);
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateWidth);
    _updateWidth();
  }

  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_updateWidth);
      widget.controller.addListener(_updateWidth);
      _updateWidth();
    }
  }

  void _updateWidth() {
    late final String text;
    if (widget.controller.text.isEmpty) {
      text = widget.hintText;
    } else {
      text = widget.controller.text;
    }
    final tp = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16)),
      textDirection: TextDirection.ltr,
    )..layout();
    _widthNotifier.value = tp.width + 20;
  }

  @override
  void dispose() {
    _isEditableNotifier.dispose();
    _widthNotifier.dispose();
    _focusNode.dispose();
    widget.controller.removeListener(_updateWidth);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isEditableNotifier,
      builder: (_, isEditable, _) {
        return Row(
          children: [
            ValueListenableBuilder(
              valueListenable: _widthNotifier,
              builder: (_, width, _) {
                return SizedBox(
                  width: width,
                  child: TextFormField(
                    focusNode: _focusNode,
                    enabled: isEditable,
                    controller: widget.controller,
                    style: TextStyle(color: Colors.white, fontSize: 16, height: 20 / 16),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      hintText: widget.hintText,
                      // todo: вынести цвета в тему
                      hintStyle: TextStyle(color: Colors.white24),
                    ),
                    onFieldSubmitted: (value) => _isEditableNotifier.value = false,
                  ),
                );
              },
            ),
            if (!isEditable)
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  _isEditableNotifier.value = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _focusNode.requestFocus();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
          ],
        );
      },
    );
    // return ValueListenableBuilder(
    //   valueListenable: isEditableNotifier,
    //   builder: (_, value, _) {
    //     if (value) {
    //       return TextFormField(
    //         controller: widget.controller,
    //         style: TextStyle(color: Colors.white, fontSize: 16, height: 20 / 16),
    //         decoration: InputDecoration(
    //           contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: -4),
    //           isCollapsed: true,
    //           hintText: widget.hintText,
    //         ),
    //         onFieldSubmitted: (value) => isEditableNotifier.value = false,
    //       );
    //     }
    //     return Row(
    //       spacing: 8,
    //       children: [
    //         Text(
    //           widget.controller.text,
    //           style: TextStyle(color: Colors.white, fontSize: 16, height: 20 / 16),
    //         ),
    //         InkWell(
    //           borderRadius: BorderRadius.circular(100),
    //           onTap: () => isEditableNotifier.value = true,
    //           child: const Padding(
    //             padding: EdgeInsets.all(8),
    //             child: Icon(Icons.edit, color: Colors.white, size: 16),
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
