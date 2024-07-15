import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xff075E54);

String? uId;
var dateTime = DateTime.now();
var formatted = DateFormat().add_Hm().format(dateTime);
