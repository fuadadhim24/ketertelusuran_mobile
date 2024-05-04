import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:intl/intl.dart';

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

class CustomStringFormField extends StatefulWidget {
  final String title;
  final String stringInitialValue;
  final TextEditingController? controller;

  const CustomStringFormField({
    Key? key,
    required this.title,
    required this.stringInitialValue,
    this.controller,
  }) : super(key: key);

  @override
  _CustomStringFormFieldState createState() => _CustomStringFormFieldState();
}

class _CustomStringFormFieldState extends State<CustomStringFormField> {
  late String stringInitialValue;

  @override
  void initState() {
    super.initState();
    stringInitialValue = widget.stringInitialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: stringInitialValue,
          enabled: false,
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

class CustomDatePicker extends StatefulWidget {
  final String title;
  const CustomDatePicker({required this.title, super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        labelText: widget.title,
        prefixIcon: Icon(Icons.calendar_today),
        contentPadding: const EdgeInsets.all(12),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now());
        if (pickedDate != null) {
          print(
              pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(
              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
          print(
              formattedDate); //formatted date output using intl package =>  2022-07-04
          //You can format date as per your need

          setState(() {
            dateController.text =
                formattedDate; //set foratted date to TextField value.
          });
        } else {
          _showWarningSnackBar(context, widget.title + ' belum dipilih');
        }
      },
    );
  }

  void _showWarningSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Durasi notifikasi
      backgroundColor: Colors.red, // Warna latar belakang notifikasi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Jari-jari border radius
      ),
      behavior: SnackBarBehavior.floating, // Snackbar akan mengambang
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: 60), // Menerapkan margin
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // Menampilkan notifikasi
  }
}
