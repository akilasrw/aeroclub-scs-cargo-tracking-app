import 'package:flutter/material.dart';

class AppTheme {
  // COLOURS

  static const primaryColour = Color(0xff1a64ea);
  static const secondaryColour = Color(0xffe1dcdc);
  static const secondaryColourContrast = Color(0xff5B2F2C);
  static const primaryWelcomePageBackground = Color(0xFFFF77A8);
  static const subtitleTextColour = Color(0xff767676);
  static const disabledButtonColour = Color(0xffCECECE);
  static const discountPriceTextColour = Color(0xffE03749);
  static const textFieldHintTextColour = Color(0xffbababa);
  static const hyperlinkTextColour = Color(0xff2E71C4);
  static const errorTextColour = Color(0xffDB3236);
  static const dividerColour = Color(0xffe6e6e6);
  static const pageBackgroundColour = Color(0xfff6f6f6);
  static const widgetShadowColour = Color(0xffFDE8EF);
  static const borderBackgroundColur = Color(0xFFF6F1F3);
  static const focusTextColour = Color(0xFF7D6B55);
  static const hintTextColour = Color(0xFFD97C9D);
  static const uncheckBtnBackgroundColour = Color(0xFFFFFFFF);
  static const uncheckBtnBackgroundColour2 = Color(0xFFFEF1F5);
  static const checkBtnBackgroundColour = Color(0xFF56C596);
  static const primaryLighterColur = Color(0xFFFFE7EF);
  static const tintGreenColour = Color(0xFF2CA974);
  static const fadePrimaryColour = Color(0xFFFFF2F7);

  static const notitificationUnselectTintColur = Color(0xFFFFF7FA);
  static const lowTintColur = Color(0xFFC0B8B8);

  static const waterTileColur = Color(0xFFBEE3F0);
  static const exerciseTileColur = Color(0xFFD0EDDB);
  static const bowelMovementTileColur = Color(0xFFE8C6F5);

  static const homeBackgroundColur = Color(0xFFFFE4EE);

  static const waterColour = Color(0xFF4398DA);
  static const waterEmptyAreaColour = Color(0xFFE3EBFF);
  static const primaryTintColour = Color(0xFFE12316);
  static const secondaryTintColour = Color(0xFF2A5DDD);

  static const waterTextColour = Color(0xFF0f5e9c);
  static const waterdarkerColour = Color(0xFF7D6B55);

  static const level1IntensityColur = Color(0xFF56C596);

  // Single use colours
  static const onboardingSelectionTilesBackground = Color(0xff303030);
  static const eliteMemberHighlightColour = Color(0xff3EBAC8);
  static const unreadMessageBackgroundColour = Color(0xff41CEAE);
  static const addressSelectedBackgroundColour = Color(0xFFA2A2A2);
  static const reviewStarFilledColour = Color(0xffF4A406);
  static const sliderDeleteBackgroundColour = Color(0xffFFD5D5);
  static const discountTotalTextColour = Color(0xffD65959);
  static const interestIconDisabledColour = Color(0xff959595);
  static const selectedColourCarousel = Color(0xffd1cccc);
  static const fieldSubtitleColour = Color(0xff404040);
  static const deselectedFilterColour = Color(0xffaaaaaa);
  static const tileBorderColour = Color(0xff3E3E3E);
  static const tickIconAddedToBagColour = Color(0xFF000000);

  // FONTS -

  static const String primaryFontFamily = 'Montserrat';
  static const String primaryFontFamilyBold = 'Montserrat-Bold.ttf';
  static const String primaryFontFamilyReg = 'Montserrat-Regular.ttf';
  static const String primaryFontFamilyMed = 'Montserrat-Medium.ttf';

  // BORDER OPTIONS
  static const double borderWidth = 1.0;
  static const double borderRadius = 25.0;
  static const double buttonBorderRadius = 100.0;
  static const double outlinedButtonBorderRadius = 0.0;

  ThemeData buildTheme() => ThemeData(
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(
            size: 25.0,
          ),
          backgroundColor: primaryWelcomePageBackground,
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: secondaryColour,
            size: 30.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
          ),
          titleSpacing: 0.0,
        ),

        backgroundColor: secondaryColour,

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: secondaryColour,
          selectedIconTheme: IconThemeData(
            color: primaryColour,
            size: 30.0,
          ),
          unselectedIconTheme: IconThemeData(
            color: primaryColour,
            size: 30.0,
          ),
          selectedItemColor: primaryColour,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            color: primaryColour,
            fontSize: 15.0,
          ),
          unselectedLabelStyle: TextStyle(
            color: primaryColour,
            fontSize: 15.0,
          ),
        ),

        bottomSheetTheme: const BottomSheetThemeData(
          modalBackgroundColor: secondaryColour,
          modalElevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
        ),

        brightness: Brightness.light,

        buttonBarTheme: const ButtonBarThemeData(
          alignment: MainAxisAlignment.start,
          buttonHeight: 100.0,
          buttonMinWidth: 100.0,
          buttonPadding: EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          layoutBehavior: ButtonBarLayoutBehavior.padded,
          mainAxisSize: MainAxisSize.max,
          overflowDirection: VerticalDirection.down,
        ),

        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(secondaryColour),
          fillColor: MaterialStateProperty.all(primaryColour),
          overlayColor: MaterialStateProperty.all(textFieldHintTextColour),
          side: const BorderSide(
              color: textFieldHintTextColour, style: BorderStyle.solid),
        ),

        colorScheme: const ColorScheme(
          background: secondaryColour,
          brightness: Brightness.light,
          error: errorTextColour,
          onBackground: Colors.black,
          onError: Colors.white,
          onPrimary: primaryColour,
          onSecondary: primaryColour,
          primary: secondaryColour,
          secondary: primaryColour,
          surface: Colors.white,
          onSurface: secondaryColour,
        ),

        dialogBackgroundColor: Colors.white,

        dialogTheme: DialogTheme(
          titleTextStyle: const TextStyle(
            color: primaryColour,
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: secondaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),

        disabledColor: disabledButtonColour,

        dividerColor: dividerColour,

        dividerTheme: const DividerThemeData(
          color: Colors.black12,
          thickness: 1.0,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            alignment: Alignment.center,
            // textStyle: MaterialStateProperty.all(headlineSmallTextStyle),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledButtonColour;
              }

              return primaryColour;
            }),
            elevation: MaterialStateProperty.all(0.0),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return dividerColour;
              }
              return secondaryColour;
            }),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            )),
          ),
        ),

        errorColor: errorTextColour,

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColour,
          disabledElevation: 0.0,
          elevation: 10.0,
          foregroundColor: secondaryColour,
        ),

        focusColor: secondaryColour,

        highlightColor: Colors.white,

        hintColor: primaryColour,

        iconTheme: const IconThemeData(
          color: primaryColour,
          size: 30.0,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.only(top: 0.5, left: 15.0, right: 15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColour),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorTextColour),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColour),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorTextColour),
          ),
          errorMaxLines: 2,
          errorStyle: TextStyle(color: errorTextColour),
          filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          helperMaxLines: 2,
          helperStyle: TextStyle(color: primaryColour),
          hintStyle: TextStyle(
            color: textFieldHintTextColour,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: TextStyle(color: primaryColour),
          iconColor: primaryColour
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledButtonColour;
              }

              return Colors.transparent;
            }),
            elevation: MaterialStateProperty.all(0.0),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return textFieldHintTextColour;
              }

              return primaryColour;
            }),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                outlinedButtonBorderRadius,
              ),
            )),
            side: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const BorderSide(
                  color: disabledButtonColour,
                  width: borderWidth,
                );
              }

              return const BorderSide(
                color: primaryColour,
                width: borderWidth,
              );
            }),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                color: primaryColour,
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),

        primaryColor: secondaryColour,

        // Icon theme which contrasts with the primary colour.
        primaryIconTheme: const IconThemeData(
          color: secondaryColourContrast,
        ),

        // Text theme which constrasts with the primary colour.
        primaryTextTheme: const TextTheme(
            // TBC
            ),

        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(primaryColour),
          visualDensity: const VisualDensity(
            horizontal: 0.0,
            vertical: 4.0,
          ),
        ),

        scaffoldBackgroundColor: secondaryColour,

        snackBarTheme: const SnackBarThemeData(
          actionTextColor: secondaryColour,
          backgroundColor: primaryColour,
          behavior: SnackBarBehavior.fixed,
          contentTextStyle: TextStyle(
            fontSize: 16.0,
            color: secondaryColour,
          ),
          disabledActionTextColor: textFieldHintTextColour,
          elevation: 0.0,
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.black,
        ),

        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            alignment: Alignment.center,
            elevation: MaterialStateProperty.all(0.0),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledButtonColour;
              }

              return secondaryColour;
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return textFieldHintTextColour;
              }

              return primaryColour;
            }),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            )),
          ),
        ),

        // Comments at the side indicate where these TextStyles are used by default.
        // Note: Most TextStyles can be customised on a per Widget basis
        // Example: DialogTheme(titleTextStyle: TextStyle(...)) - this is used in favour of headline6 which is the default.
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            fontFamily: primaryFontFamilyMed,
          ), // Use to emphasize text that would otherwise be bodyText2
          bodyText2: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            fontFamily: primaryFontFamilyMed,
          ), // The default text style for Material
          button: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            height: 1.0,
            fontFamily: primaryFontFamilyBold,
          ), // Used for ElevatedButton, TextButton & OutlinedButton
          caption: TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.underline,
            fontSize: 12.0,
            fontFamily: primaryFontFamilyBold,
          ), // Used for auxillary text associated with images
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w500,
            fontFamily: primaryFontFamilyBold,
          ), // Largest headline
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            fontFamily: primaryFontFamilyBold,
          ), //..
          headline3: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: primaryFontFamilyReg,
          ), //..
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
            fontFamily: primaryFontFamilyBold,
          ), //..
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: primaryFontFamilyBold,
          ), // Used for large text in Dialogs (e.g, the month and uear in the DatePicker dialog)
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: primaryFontFamilyBold,
          ), // Used for primary text in AppBars and Dialogs (e.g, AppBar.title, AlertDialog.title)
          overline: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ), // The smallest text - currently using for AppBar.actions that have labels
          subtitle1: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: primaryFontFamily,
            letterSpacing: 0.2,
            wordSpacing: 2.0,
          ), // Used for the primary text in Lists (e.g, ListTile.title)
          subtitle2: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            fontFamily: primaryFontFamilyReg,
          ), // For medium emphasis text that's smaller than subtitle1
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryColour,
          selectionHandleColor: primaryColour,
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  // SINGLE USE STYLES

  static const widgetCommonBackgroundDecoration = BoxDecoration(
      color: pageBackgroundColour,
      border: Border(
        bottom: BorderSide(width: 1.0, color: Color(0xFFBCBCBC)),
      ));
}
