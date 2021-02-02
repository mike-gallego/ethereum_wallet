import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 3,
      itemBuilder: (context, idx) {
        return _buildLotteryTile(context, idx);
      },
    ));
  }

  Widget _buildLotteryTile(BuildContext context, int idx) {
    return InkWell(
      onTap: () {},
      child: Neumorphic(
          margin: const EdgeInsets.all(16.0),
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: -5,
            shadowLightColor: BlocProvider.of<ThemeBloc>(context).state.isLight
                ? Colors.grey[800]
                : Colors.blueGrey[600],
            shadowDarkColor: BlocProvider.of<ThemeBloc>(context).state.isLight
                ? Colors.grey[800]
                : Colors.blueGrey[600],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '0/10 Participants',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            color:
                                BlocProvider.of<ThemeBloc>(context).state.isLight
                                    ? Colors.grey[800]
                                    : NeumorphicColors.embossMaxWhiteColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Time left: N/A seconds',
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            color:
                                BlocProvider.of<ThemeBloc>(context).state.isLight
                                    ? Colors.grey[800]
                                    : NeumorphicColors.embossMaxWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Admission: N/A ETH',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            color:
                                BlocProvider.of<ThemeBloc>(context).state.isLight
                                    ? Colors.grey[800]
                                    : NeumorphicColors.embossMaxWhiteColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Total: N/A ETH',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                            color:
                                BlocProvider.of<ThemeBloc>(context).state.isLight
                                    ? Colors.grey[800]
                                    : NeumorphicColors.embossMaxWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
