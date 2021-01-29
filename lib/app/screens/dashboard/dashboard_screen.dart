import 'dart:ui';

import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/views/wallet_view/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandabar/pandabar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardScreen extends StatelessWidget {
  final bool isLight;
  final SharedPreferences prefs;

  DashboardScreen({this.isLight, this.prefs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: WalletView(
        prefs: prefs,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return NeumorphicAppBar(
      centerTitle: true,
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
                      BlocProvider.of<ThemeBloc>(context)
                          .add(Toggle(isLight: isLight));
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

  Widget _buildBottomNavBar(BuildContext context) {
    return PandaBar(
      backgroundColor: BlocProvider.of<ThemeBloc>(context).state.isLight
          ? Colors.grey[800]
          : Colors.blueGrey[400],
      buttonColor: Colors.grey[300],
      buttonSelectedColor: BlocProvider.of<ThemeBloc>(context).state.isLight
          ? NeumorphicColors.decorationMaxWhiteColor
          : Colors.blueGrey[800],
      fabColors: BlocProvider.of<ThemeBloc>(context).state.isLight
          ? [NeumorphicColors.background, NeumorphicColors.background]
          : [NeumorphicColors.darkVariant, NeumorphicColors.darkVariant],
      fabIcon: Icon(
        MaterialCommunityIcons.cube_send,
        size: 24,
        color: BlocProvider.of<ThemeBloc>(context).state.isLight ? Colors.grey[700] : NeumorphicColors.decorationMaxWhiteColor,
      ),
      buttonData: [
        PandaBarButtonData(
            id: 'Wallet', icon: MaterialCommunityIcons.wallet, title: 'Wallet'),
        PandaBarButtonData(
            id: 'Deposit/Withdraw',
            icon: MaterialCommunityIcons.ethereum,
            title: 'Feed/Extract'),
        PandaBarButtonData(
            id: 'Lend/Borrow',
            icon: MaterialCommunityIcons.bank_transfer,
            title: 'Lend/Borrow'),
        PandaBarButtonData(
            id: 'Lottery',
            icon: MaterialCommunityIcons.dice_multiple,
            title: 'Lottery'),
      ],
      onChange: (id) {},
      onFabButtonPressed: () {},
    );
  }
}