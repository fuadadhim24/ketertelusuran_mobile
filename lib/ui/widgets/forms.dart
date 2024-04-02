import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final bool obscureText;
  final int typeFormField;
  final TextEditingController? controller;

  const CustomFormField({
    Key? key,
    required this.title,
    required this.typeFormField,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool obscureText;
  late int typeFormField;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    typeFormField = widget.typeFormField;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        typeFormField == 1
            ? TextFormField(
                obscureText: obscureText,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  labelText: widget.title,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              )
            : TextFormField(
                obscureText: obscureText,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  labelText: widget.title,
                ),
              ),
      ],
    );
  }
}
