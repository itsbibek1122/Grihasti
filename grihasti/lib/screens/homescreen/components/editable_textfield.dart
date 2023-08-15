// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:grihasti/utils/style/colors.dart';

class EditableTextField extends StatefulWidget {
  final String initialValue;
  final String finalValue;
  const EditableTextField({
    Key? key,
    required this.initialValue,
    required this.finalValue,
  }) : super(key: key);

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool isEditing = false;

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (isEditing) {
        _textEditingController.text = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _textEditingController,
              enabled: isEditing,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: isEditing ? widget.finalValue : widget.initialValue,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.edit,
            color: AppColors.orangeColor,
          ),
          onPressed: toggleEditing,
        ),
      ],
    );
  }
}
