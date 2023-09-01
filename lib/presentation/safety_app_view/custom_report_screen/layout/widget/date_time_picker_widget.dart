// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../configurations/color_constants.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimePickerWidget extends StatefulWidget {
  String hintText;
  DateTimePickerType dateTimePickerType;
  TextEditingController controller;
  DateTime start;
  DateTime end;
  String mask;
  Function(String?)? validator;

  DateTimePickerWidget({
    Key? key,
    required this.hintText,
    required this.dateTimePickerType,
    required this.controller,
    required this.start,
    required this.end,
    required this.mask,
    this.validator,
  }) : super(key: key);

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  //DateTime(DateTime.now().year, DateTime.now().month , DateTime.now().day)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      controller: widget.controller,
      onChanged: (value) {
        debugPrint(value);
        setState(() {
          widget.controller.text = value;
        });
      },
      use24HourFormat: true,
      locale: const Locale('en', 'US'),
      dateMask: widget.mask,
      type: widget.dateTimePickerType,
      firstDate: widget.start,
      lastDate: widget.end,
      validator:
          widget.validator == null ? null : (value) => widget.validator!(value),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: ColorConstants.kgreyColor),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorConstants.kPrimaryColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorConstants.kPrimaryColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorConstants.kPrimaryColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorConstants.kPrimaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorConstants.kPrimaryColor),
        ),
        suffixIcon: const Icon(
          Icons.event,
          color: ColorConstants.kPrimaryColor,
        ),
      ),
    );
  }
}
