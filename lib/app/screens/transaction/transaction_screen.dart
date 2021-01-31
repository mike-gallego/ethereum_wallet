import 'package:ehtereum_wallet/app/screens/dashboard/blocs/text/text_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/dashboard_screen.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/timeline/bloc/timeline_bloc.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'process_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

class TransactionScreen extends StatelessWidget {
  final SharedPreferences prefs;

  TransactionScreen({this.prefs});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(context),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: NeumorphicIcon(
                          MaterialCommunityIcons.ethereum,
                          size: 32.0,
                          style: NeumorphicStyle(
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? Colors.grey[800]
                                  : Colors.blueGrey[800],
                              shadowLightColor:
                                  BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? Colors.grey[400]
                                      : Colors.blueGrey[400]),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Neumorphic(
                        style: NeumorphicStyle(
                          shadowLightColor:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? Colors.grey[400]
                                  : Colors.blueGrey[600],
                          shadowDarkColor:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? Colors.grey[400]
                                  : Colors.blueGrey[600],
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          alignment: Alignment.center,
                          child: ProcessTimelinePage(),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        BlocProvider.of<TimelineBloc>(context).state.index == 4 ? 'Your transaction is completed!' : 'Your transaction is processing...',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .isLight
                                ? NeumorphicColors.decorationMaxWhiteColor
                                : NeumorphicColors.embossMaxWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'From:',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .isLight
                                ? NeumorphicColors.decorationMaxWhiteColor
                                : NeumorphicColors.embossMaxWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Neumorphic(
                      padding: const EdgeInsets.all(8.0),
                      style: NeumorphicStyle(
                          depth: 4.0,
                          shadowLightColor:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? Colors.grey[400]
                                  : Colors.blueGrey[400]),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          '${state.senderAddress}',
                          style: GoogleFonts.ibmPlexMono(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'To:',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .isLight
                                ? NeumorphicColors.decorationMaxWhiteColor
                                : NeumorphicColors.embossMaxWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Neumorphic(
                      padding: const EdgeInsets.all(8.0),
                      style: NeumorphicStyle(
                          depth: 4.0,
                          shadowLightColor:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? Colors.grey[400]
                                  : Colors.blueGrey[400]),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          '${state.receiverAddress}',
                          style: GoogleFonts.ibmPlexMono(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Amount:',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .isLight
                                ? NeumorphicColors.decorationMaxWhiteColor
                                : NeumorphicColors.embossMaxWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Neumorphic(
                      padding: const EdgeInsets.all(8.0),
                      style: NeumorphicStyle(
                          depth: 4.0,
                          shadowLightColor:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? Colors.grey[400]
                                  : Colors.blueGrey[400]),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${state.amount}',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? NeumorphicColors.decorationMaxWhiteColor
                                      : NeumorphicColors.embossMaxWhiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'ETH',
                                style: GoogleFonts.ibmPlexMono(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: BlocProvider.of<ThemeBloc>(context)
                                            .state
                                            .isLight
                                        ? NeumorphicColors
                                            .decorationMaxWhiteColor
                                        : NeumorphicColors.embossMaxWhiteColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Transaction Hash:',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .isLight
                                ? NeumorphicColors.decorationMaxWhiteColor
                                : NeumorphicColors.embossMaxWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Neumorphic(
                      padding: const EdgeInsets.all(8.0),
                      style: NeumorphicStyle(
                          depth: 4.0,
                          shadowLightColor:
                              BlocProvider.of<ThemeBloc>(context).state.isLight
                                  ? Colors.grey[400]
                                  : Colors.blueGrey[400]),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          '${state.transactionHash}',
                          style: GoogleFonts.ibmPlexMono(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeumorphicButton(
                          onPressed: () {
                            BlocProvider.of<TimelineBloc>(context)
                                .add(NextStep(index: 1));
                          },
                          child: Text(
                            'Save to PDF',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? NeumorphicColors.decorationMaxWhiteColor
                                      : NeumorphicColors.embossMaxWhiteColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          style: NeumorphicStyle(
                              shadowLightColor:
                                  BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? Colors.grey[400]
                                      : Colors.blueGrey[400],
                              shape: NeumorphicShape.concave,
                              depth: 6.0),
                        ),
                        NeumorphicButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen(
                                          isLight: BlocProvider.of<ThemeBloc>(
                                                  context)
                                              .state
                                              .isLight,
                                          prefs: prefs,
                                        )));
                          },
                          child: Text(
                            'Return to Dashboard',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? NeumorphicColors.decorationMaxWhiteColor
                                      : NeumorphicColors.embossMaxWhiteColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat, depth: -12.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return NeumorphicAppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Ethereum Wallet',
        style: GoogleFonts.ibmPlexMono(
            textStyle: TextStyle(
                color: BlocProvider.of<ThemeBloc>(context).state.isLight
                    ? NeumorphicColors.decorationMaxWhiteColor
                    : NeumorphicColors.embossMaxWhiteColor)),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showMenu(
              color: Colors.black.withOpacity(0.75),
              items: [
                PopupMenuItem<bool>(
                  child: GestureDetector(
                    onTap: () async {
                      BlocProvider.of<ThemeBloc>(context).add(Toggle(
                          isLight: BlocProvider.of<ThemeBloc>(context)
                              .state
                              .isLight));
                      debugPrint(
                          'the light is on: ${BlocProvider.of<ThemeBloc>(context).state.isLight}');
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Text(
                        'Change Theme',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? NeumorphicColors.decorationMaxWhiteColor
                                  : NeumorphicColors.embossMaxWhiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              position: RelativeRect.fromLTRB(65.0, 40.0, 0.0, 0.0),
              context: context,
            );
          },
          icon: Icon(
            MaterialCommunityIcons.dots_vertical,
            color: BlocProvider.of<ThemeBloc>(context).state.isLight
                ? NeumorphicColors.decorationMaxWhiteColor
                : NeumorphicColors.embossMaxWhiteColor,
          ),
        ),
      ],
    );
  }
}
