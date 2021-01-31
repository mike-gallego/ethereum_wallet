import 'package:ehtereum_wallet/app/screens/dashboard/blocs/page/page_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/blocs/text/text_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/blocs/hide/bloc/hide_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/dashboard_screen.dart';
import 'package:ehtereum_wallet/app/screens/placeholders/splash_screen.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/timeline/bloc/timeline_bloc.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        BlocProvider(
          create: (context) => PageBloc(PageState(pageID: 'Wallet')),
        ),
        BlocProvider(
          create: (context) => TextBloc(TextState(address: '', amount: '', message: '')),
        ),
        BlocProvider(
          create: (context) => TimelineBloc(TimelineState(index: 0)),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(TransactionState(amount: '', transactionHash: '', receiverAddress: '', senderAddress: '', context: context)),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: _buildTheme),
    );
  }

  Future<SharedPreferences> _getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
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
            return NeumorphicApp(
              home: SplashScreen(),
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
