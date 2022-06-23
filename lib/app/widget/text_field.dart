import 'package:flutter/material.dart';
import 'package:kalkulator_plts/app/widget/recource.dart';

class DefaultTextField extends StatefulWidget {
  final String hindText;
  final TextEditingController textController;

  const DefaultTextField(
      {required this.hindText, required this.textController, Key? key})
      : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Text(widget.hindText,
            style: TextStyle(fontSize: 13,
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.grayC4C4C4)
          ),
          child: TextFormField(
            controller: widget.textController,
            keyboardType: TextInputType.number,
            onChanged: (e) {
              setState(() {
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              labelStyle:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6)),
              hintStyle:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6)),
              prefixStyle:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6)),
              hintText: widget.hindText,
              // labelText: hindText,
            ),
          ),
        ),
      ],
    );
  }
}
