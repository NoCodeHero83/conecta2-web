import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

List<CalendarDayStruct> getCalendarForMonth(DateTime inputDate) {
  List<CalendarDayStruct> calendar = [];

  // Start by finding the first day of the current month
  DateTime firstOfMonth = DateTime(inputDate.year, inputDate.month, 1);

  // Find the last day of the current month
  DateTime lastOfMonth = DateTime(inputDate.year, inputDate.month + 1, 0);

  // Find the first Monday on or before the first of the month
  DateTime startCalendar =
      firstOfMonth.subtract(Duration(days: firstOfMonth.weekday - 1));

  // Find the last Sunday after the end of the month
  DateTime endCalendar = lastOfMonth.weekday == 7
      ? lastOfMonth
      : lastOfMonth.add(Duration(days: 7 - lastOfMonth.weekday));

  // Populate the calendar
  for (DateTime date = startCalendar;
      date.isBefore(endCalendar.add(Duration(days: 1)));
      date = date.add(Duration(days: 1))) {
    bool isPreviousMonth = date.isBefore(firstOfMonth);
    bool isNextMonth = date.isAfter(lastOfMonth);

    CalendarDayStruct dayStruct = CalendarDayStruct(
        calendarDate: date,
        isPreviousMonth: isPreviousMonth,
        isNextMonth: isNextMonth);

    calendar.add(dayStruct);
  }

  return calendar;
}

String? countEncuesta(List<String>? users) {
  // Get Count document
  return users?.length.toString();
}

int? countEncuestaCopy(List<String>? users) {
  // Get Count document
  if (users == null || users.isEmpty) {
    return null;
  }
  int count = 0;
  for (String user in users) {
    if (user.isNotEmpty) {
      count++;
    }
  }
  return count;
}

String? countContenido(List<ContenidoRecord>? contenido) {
  // Get Count document
  return contenido?.length.toString();
}

DateTime getLastMonthDateTime(DateTime inputDate) {
  int year = inputDate.year;
  int month = inputDate.month;

  if (month == 1) {
    year--;
    month = 12;
  } else {
    month--;
  }
  return DateTime(year, month);
}

DateTime getNextMonthDateTime(DateTime inputDate) {
  int year = inputDate.year;
  int month = inputDate.month;

  if (month == 12) {
    year++;
    month = 1;
  } else {
    month++;
  }
  return DateTime(year, month);
}

DateTime formatdate(DateTime date) {
  // formatear para que solo se muestre la fecha sin la hora
  return DateTime(date.year, date.month, date.day);
}

String primernombre(String nombre) {
  // solo devolver la primera palabra
  List<String> palabras = nombre.split(' ');
  return palabras[0];
}

String? countUsers(List<UsersRecord>? users) {
  // Get Count document
  return users?.length.toString();
}

double? percent(
  String? total,
  String? some,
) {
  // get percent from to Define
  if (total == null || some == null) {
    return null;
  }
  final double totalValue = double.tryParse(total) ?? 0.0;
  final double someValue = double.tryParse(some) ?? 0.0;
  if (totalValue == 0.0) {
    return null;
  }
  return (someValue / totalValue) * 100.0;
}

int? emocion(List<String>? emocionList) {
  // get Number of rows that emotions are recorded in it if set
  if (emocionList == null) {
    return null;
  } else {
    int count = 0;
    for (String e in emocionList) {
      if (e.isNotEmpty) {
        count++;
      }
    }
    return count;
  }
}

int? newCustomFunction(List<int>? items) {
  // Get Numbers of row
  if (items == null) {
    return null;
  }
  return items.length;
}

List<String> obtenerCoordenadasString(LatLng input) {
  // Devuelve la latitud y longitud como lista de strings
  return [
    input.latitude.toString(),
    input.longitude.toString(),
  ];
}

String? convertirlatlngString(LatLng? latlng) {
  if (latlng == null) {
    return null;
  }

  try {
    // Convertir las coordenadas a string con formato "lat, lng"
    return '${latlng.latitude}, ${latlng.longitude}';
  } catch (e) {
    // En caso de error, retornar null
    return null;
  }
}
