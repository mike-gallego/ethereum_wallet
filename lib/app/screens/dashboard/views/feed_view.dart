import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 75,
              child: Neumorphic(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deposit funds into wallet',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                              fontSize: 16.0,
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        MaterialIcons.arrow_drop_down,
                        color: BlocProvider.of<ThemeBloc>(context).state.isLight
                            ? NeumorphicColors.decorationMaxWhiteColor
                            : NeumorphicColors.embossMaxWhiteColor,
                      )
                    ],
                  ),
                ),
                style: NeumorphicStyle(
                    shadowLightColor:
                        BlocProvider.of<ThemeBloc>(context).state.isLight
                            ? Colors.grey[400]
                            : Colors.blueGrey[400]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 75,
              child: Neumorphic(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        MaterialCommunityIcons.bank,
                        color: BlocProvider.of<ThemeBloc>(context).state.isLight
                            ? NeumorphicColors.decorationMaxWhiteColor
                            : NeumorphicColors.embossMaxWhiteColor,
                      ),
                      Text(
                        'Link bank account',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                              fontSize: 16.0,
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                style: NeumorphicStyle(
                    shadowLightColor:
                        BlocProvider.of<ThemeBloc>(context).state.isLight
                            ? Colors.grey[400]
                            : Colors.blueGrey[400]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 75,
              child: Neumorphic(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '0.0007321 ETH (0.031581 available) (realtime)',
                    style: GoogleFonts.ibmPlexMono(
                      textStyle: TextStyle(
                          fontSize: 16.0,
                          color:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                style: NeumorphicStyle(
                    shadowLightColor:
                        BlocProvider.of<ThemeBloc>(context).state.isLight
                            ? Colors.grey[400]
                            : Colors.blueGrey[400]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 75,
                child: Neumorphic(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Submit',
                      style: GoogleFonts.ibmPlexMono(
                        textStyle: TextStyle(
                            fontSize: 16.0,
                            color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .isLight
                                ? NeumorphicColors.decorationMaxWhiteColor
                                : NeumorphicColors.embossMaxWhiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  style: NeumorphicStyle(
                      color: Colors.green[600],
                      shadowLightColor:
                          BlocProvider.of<ThemeBloc>(context).state.isLight
                              ? Colors.grey[400]
                              : Colors.blueGrey[400]),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Neumorphic(
                style: NeumorphicStyle(
                    shadowLightColor:
                        BlocProvider.of<ThemeBloc>(context).state.isLight
                            ? Colors.grey[400]
                            : Colors.blueGrey[400]),
                child: VirtualKeyboard(
                    // [0-9] + .
                    type: VirtualKeyboardType.Numeric,
                    textColor: BlocProvider.of<ThemeBloc>(context).state.isLight
                        ? NeumorphicColors.decorationMaxWhiteColor
                        : NeumorphicColors.embossMaxWhiteColor,
                    // Callback for key press event
                    onKeyPress: (key) => print(key.text)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
