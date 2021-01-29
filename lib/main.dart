import 'package:ehtereum_wallet/blocs/hide/bloc/hide_bloc.dart';
import 'package:ehtereum_wallet/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/theme/bloc/theme_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(ThemeState(isLight: false,)),
        ),
        BlocProvider(
          create: (context) => HideBloc(HideState(isBlur: true,))
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: _buildTheme),
    );
  }

  Future<SharedPreferences> _getSharedPref() async {
    return await SharedPreferences.getInstance();
  }

  Widget _buildTheme(BuildContext context, ThemeState state) {
    return FutureBuilder<SharedPreferences>(
      future: _getSharedPref(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
            break;
          case ConnectionState.done:
            return NeumorphicApp(
              home: DashboardScreen(isLight: state.isLight, prefs: snapshot.data,),
              debugShowCheckedModeBanner: false,
              title: 'Ethereum Wallet',
              themeMode: state.isLight ? ThemeMode.light : ThemeMode.dark,
              theme: NeumorphicThemeData(
                textTheme: GoogleFonts.ibmPlexMonoTextTheme(
                    Theme.of(context).textTheme),
                baseColor:
                    NeumorphicColors.embossMaxWhiteColor, // Color(0xFFFFFFFF),
                intensity: 0.8,
                appBarTheme: NeumorphicAppBarThemeData(),
                lightSource: LightSource.topLeft,
                depth: 10,
              ),
              darkTheme: NeumorphicThemeData.dark(
                baseColor: NeumorphicColors.darkVariant,
                textTheme: GoogleFonts.ibmPlexMonoTextTheme(
                    Theme.of(context).textTheme), // Color(0xFFFFFFFF),
                lightSource: LightSource.topLeft,
                depth: 10,
              ),
            );
          default:
            return Container();
            break;
        }
      },
    );
  }
}