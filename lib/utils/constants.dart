import 'package:flutter/material.dart';

const app_id = 1089;

const image_base_url = 'https://stdevnaturalgyn.blob.core.windows.net/images/';
const thumbnail_base_url =
    'https://stdevnaturalgyn.blob.core.windows.net/thumbnails';
const video_base_url = 'https://stdevnaturalgyn.blob.core.windows.net/videos';

// Share Preferences TAGS
const String TOKEN_DETAILS_MODEL = "TokenDetails";
const String LOGIN_DETAILS_MODEL = "LoginDetails";
const String SHARED_PREFERENCES_AUTH_TOKEN = "USER_TOKEN";
const String SHARED_PREFERENCES_REFRESH_TOKEN = "REFRESH_TOKEN";
const String SHARED_PREFERENCES_INITIAL_DATA = "Initial_data";

enum PaymentPlans { monthly, threemonth, yearlyPlan }

enum ColorType { none, red, white, green }

enum ExerciseType { None, High, Medium, Low }

enum BowelMovementType { None, Pebbles, PebblyLog, SoftLog, Diarrhea }

enum VideoConditionType {
  None,
  PaidLibrary,
  BeforeCharting,
  Label,
  NoMucousThroughoutCycle,
  MoreThanFiveMucousThroughCycle,
  CycleLengthLessThan27,
  CycleLengthMoreThan27,
  VHSeenOnCharting,
  VLTheeTimesInRow,
  VLBAtTheBeginningOrEndOfTheCycle,
  VLBAtEndOfThePeriod,
  VLAfterDay10OfTheCycle,
  FreeLibrary,
}

var roundedTransparentBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
  side: const BorderSide(color: Colors.transparent), // Set border color to transparent
);

String getExcerciseTag(ExerciseType exerciseType) {
  switch (exerciseType) {
    case ExerciseType.None:
      return "None";
    case ExerciseType.High:
      return "High";
    case ExerciseType.Medium:
      return "Medium";
    case ExerciseType.Low:
      return "Low";
  }
}

// TODO use this to generate final results set
Color getColorById(int colorIndex) {
  Color color = Colors.white24;
  switch (ColorType.values[colorIndex]) {
    case ColorType.none:
      color = Colors.grey;
      break;
    case ColorType.red:
      color = Colors.red;
      break;
    case ColorType.white:
      color = Colors.white;
      break;
    case ColorType.green:
      color = Colors.green;
      break;
  }
  return color;
}

Color getOverlayColorByIdForText(int colorIndex) {
  Color color = Colors.white24;
  switch (ColorType.values[colorIndex]) {
    case ColorType.none:
      color = Colors.white;
      break;
    case ColorType.red:
      color = Colors.white;
      break;
    case ColorType.white:
      color = Colors.black;
      break;
    case ColorType.green:
      color = Colors.white;
      break;
  }
  return color;
}

var dropdownDecoration = InputDecoration(
  fillColor: Colors.white,
  alignLabelWithHint: true,
  filled: true,
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  hintStyle: TextStyle(
      color: const Color(0xFF001C31).withOpacity(0.6), fontSize: 14),
);
