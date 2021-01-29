import 'package:barcode_widget/barcode_widget.dart';
import 'package:ehtereum_wallet/blocs/hide/bloc/hide_bloc.dart';
import 'package:ehtereum_wallet/blocs/theme/bloc/theme_bloc.dart';
import 'package:ehtereum_wallet/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandabar/pandabar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:date_format/date_format.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:ui';

class DashboardScreen extends StatefulWidget {
  final bool isLight;
  final SharedPreferences prefs;

  DashboardScreen({this.isLight, this.prefs});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final _key = new GlobalKey();
  final _scrollController = new ScrollController();

  AnimationController _animationController;
  Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curveAnimation = new CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      if (!BlocProvider.of<HideBloc>(context).state.isBlur) {
        BlocProvider.of<HideBloc>(context).add(ShowPrivateKey(isBlur: false));
      }
      _animationController.reverse();
    }
  }

  var testItems = [
    Transaction(
      txHash: '[transaction hash goes here]',
      receiver: '[receiver address goes here]',
      sender: '[sender address goes here]',
      amount: 0.007,
      started: DateTime.now(),
      completed: DateTime.now().add(Duration(days: 1)),
    ),
    Transaction(
      txHash: '[transaction hash goes here]',
      receiver: '[receiver address goes here]',
      sender: '[sender address goes here]',
      amount: 0.007,
      started: DateTime.now(),
      completed: DateTime.now().add(Duration(days: 1)),
    ),
    Transaction(
      txHash: '[transaction hash goes here]',
      receiver: '[receiver address goes here]',
      sender: '[sender address goes here]',
      amount: 0.007,
      started: DateTime.now(),
      completed: DateTime.now().add(Duration(days: 1)),
    ),
    Transaction(
      txHash: '[transaction hash goes here]',
      receiver: '[receiver address goes here]',
      sender: '[sender address goes here]',
      amount: 0.007,
      started: DateTime.now(),
      completed: DateTime.now().add(Duration(days: 1)),
    ),
    Transaction(
      txHash: '[transaction hash goes here]',
      receiver: '[receiver address goes here]',
      sender: '[sender address goes here]',
      amount: 0.007,
      started: DateTime.now(),
      completed: DateTime.now().add(Duration(days: 1)),
    ),
    Transaction(
      txHash: '[transaction hash goes here]',
      receiver: '[receiver address goes here]',
      sender: '[sender address goes here]',
      amount: 0.007,
      started: DateTime.now(),
      completed: DateTime.now().add(Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        appBar: NeumorphicAppBar(
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
                                .add(Toggle(isLight: widget.isLight));
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
                                        ? NeumorphicColors
                                            .decorationMaxWhiteColor
                                        : NeumorphicColors
                                            .embossMaxWhiteColor),
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
                )),
          ],
        ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.black.withOpacity(0.75)),
                child: Text('Michael\'s Wallet',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Align(alignment: Alignment.center, child: _buildCard(context)),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 1.7),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                key: _key,
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "TRANSACTIONS",
                            style: GoogleFonts.ibmPlexMono(
                                textStyle: TextStyle(
                                    fontSize: 24.0,
                                    color: BlocProvider.of<ThemeBloc>(context)
                                            .state
                                            .isLight
                                        ? NeumorphicColors
                                            .decorationMaxWhiteColor
                                        : NeumorphicColors
                                            .embossMaxWhiteColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    _buildTransactions(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: PandaBar(
          backgroundColor: BlocProvider.of<ThemeBloc>(context).state.isLight
              ? Colors.grey[800]
              : Colors.blueGrey[400],
          buttonColor: Colors.grey[300],
          buttonSelectedColor:
              BlocProvider.of<ThemeBloc>(context).state.isLight
                  ? NeumorphicColors.decorationMaxWhiteColor
                  : Colors.blueGrey[800],
          fabColors: BlocProvider.of<ThemeBloc>(context).state.isLight
              ? [
                  NeumorphicColors.darkDefaultBorder,
                  NeumorphicColors.background
                ]
              : [NeumorphicColors.darkVariant, NeumorphicColors.darkVariant],
          fabIcon: NeumorphicIcon(
            MaterialCommunityIcons.cube_send,
            size: 24,
            style: NeumorphicStyle(
                color: NeumorphicColors.decorationMaxWhiteColor),
          ),
          buttonData: [
            PandaBarButtonData(
                id: 'Grey', icon: Icons.dashboard, title: 'Transactions'),
            PandaBarButtonData(
                id: 'Blue',
                icon: MaterialCommunityIcons.ethereum,
                title: 'Deposit'),
            PandaBarButtonData(
                id: 'Red',
                icon: MaterialCommunityIcons.wallet,
                title: 'Withdraw'),
            PandaBarButtonData(
                id: 'Yellow',
                icon: MaterialCommunityIcons.dice_multiple,
                title: 'Lottery'),
          ],
          onChange: (id) {},
          onFabButtonPressed: () {},
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return FlipView(
        animationController: _curveAnimation,
        front: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            width: 250,
            height: 300,
            child: Neumorphic(
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                  WaveWidget(
                    config: CustomConfig(
                      gradients:
                          BlocProvider.of<ThemeBloc>(context).state.isLight
                              ? [
                                  [Colors.grey[200], Colors.grey],
                                  [Colors.grey[800], Colors.blueGrey],
                                  [Colors.grey[200], Colors.blue],
                                  [Colors.white, Colors.grey[800]]
                                ]
                              : [
                                  [Colors.blueGrey, Colors.grey],
                                  [Colors.blueGrey[200], Colors.blue],
                                  [Colors.grey[200], Colors.blueGrey[300]],
                                  [Colors.blueGrey, Colors.white]
                                ],
                      durations: [35000, 19440, 10800, 6000],
                      heightPercentages: [0.30, 0.33, 0.42, 0.30],
                      blur: MaskFilter.blur(BlurStyle.solid, 10),
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    waveAmplitude: 0,
                    size: Size(
                      double.infinity,
                      double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.prefs.setInt('id', 1);
                            _flip(true);
                          });
                        },
                        child: NeumorphicIcon(
                          MaterialCommunityIcons.ethereum,
                          size: 32,
                          style: NeumorphicStyle(
                              color: Colors.black.withOpacity(0.7), depth: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.prefs.setInt('id', 2);
                            _flip(true);
                          });
                        },
                        child: NeumorphicIcon(
                          MaterialCommunityIcons.information,
                          size: 32,
                          style: NeumorphicStyle(
                              surfaceIntensity: 0.9,
                              color: Colors.grey[900],
                              depth: 2,
                              shape: NeumorphicShape.convex),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.prefs.setInt('id', 3);
                            _flip(true);
                          });
                        },
                        child: NeumorphicIcon(
                          MaterialCommunityIcons.qrcode_scan,
                          size: 24,
                          style: NeumorphicStyle(
                              surfaceIntensity: 0.9,
                              color: Colors.grey[900],
                              depth: 13,
                              shape: NeumorphicShape.flat),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '11.183413841414',
                          style: GoogleFonts.ibmPlexMono(
                              textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          '- ETHEREUM -',
                          style: GoogleFonts.ibmPlexMono(
                              textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[800],
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
                border: NeumorphicBorder(
                  color: Color(0x33000000),
                  width: 0.4,
                ),
                shape: NeumorphicShape.concave,
                depth: -5,
              ),
            ),
          ),
        ),
        back: _buildBackCard());
  }

  Widget _buildBackCard() {
    int id = widget.prefs.getInt('id');
    switch (id) {
      case 1:
        widget.prefs.setInt('id', 0);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            width: 250,
            height: 300,
            child: Neumorphic(
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _flip(false);
                  //         });
                  //       },
                  //       child: NeumorphicIcon(
                  //         MaterialCommunityIcons.home,
                  //         size: 32,
                  //         style: NeumorphicStyle(
                  //             color: Colors.black.withOpacity(0.7), depth: 2),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _flip(false);
                  //         });
                  //       },
                  //       child: NeumorphicIcon(
                  //         MaterialCommunityIcons.information,
                  //         size: 32,
                  //         style: NeumorphicStyle(
                  //             surfaceIntensity: 0.9,
                  //             color: Colors.grey[900],
                  //             depth: 2,
                  //             shape: NeumorphicShape.convex),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _flip(false);
                  //         });
                  //       },
                  //       child: NeumorphicIcon(
                  //         MaterialCommunityIcons.qrcode_scan,
                  //         size: 24,
                  //         style: NeumorphicStyle(
                  //             surfaceIntensity: 0.9,
                  //             color: Colors.grey[900],
                  //             depth: 13,
                  //             shape: NeumorphicShape.flat),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
                border: NeumorphicBorder(
                  color: Color(0x33000000),
                  width: 0.4,
                ),
                shape: NeumorphicShape.concave,
                depth: -5,
              ),
            ),
          ),
        );
      case 2:
        widget.prefs.setInt('id', 0);
        return BlocBuilder<HideBloc, HideState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                width: 250,
                height: 300,
                child: Neumorphic(
                  child: Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 100,
                              padding: const EdgeInsets.only(top: 4.0),
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Public Address',
                                    style: GoogleFonts.ibmPlexMono(
                                      textStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[800],
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Neumorphic(
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(8.0),
                                    style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.beveled(
                                          BorderRadius.all(
                                              Radius.circular(8.0))),
                                    ),
                                    child: Text(
                                      '0xc155483474DEBb590268Ad5a7EC74A30F8983F26',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ibmPlexMono(
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: BlocProvider.of<ThemeBloc>(
                                                        context)
                                                    .state
                                                    .isLight
                                                ? Colors.grey[800]
                                                : NeumorphicColors
                                                    .embossMaxWhiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 8.0),
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Private Key',
                                      style: GoogleFonts.ibmPlexMono(
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[800],
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      child: Neumorphic(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.beveled(
                                                  BorderRadius.all(
                                                      Radius.circular(16.0))),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'd3627d8b7d097df538b4e89b16f7701afa67ac488790869eb21b268a5f30d82b',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.ibmPlexMono(
                                                    textStyle: TextStyle(
                                                        fontSize: 16.0,
                                                        color: BlocProvider.of<
                                                                        ThemeBloc>(
                                                                    context)
                                                                .state
                                                                .isLight
                                                            ? Colors.grey[800]
                                                            : NeumorphicColors
                                                                .embossMaxWhiteColor),
                                                  ),
                                                ),
                                              ),
                                              ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: BlocProvider.of<HideBloc>(context).state.isBlur ? 10.0 : 0.0,
                                                    sigmaY: state.isBlur ? 10.0 : 0.0,
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        color: Colors
                                                            .transparent,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                onPressed: () {
                                  BlocProvider.of<HideBloc>(context).add(ShowPrivateKey(isBlur: state.isBlur));
                                },
                                style: NeumorphicStyle(
                                  color: Colors.grey[200],
                                ),
                                child: Text(
                                  state.isBlur ? 'Show private key' : 'Hide private key',
                                  style: GoogleFonts.ibmPlexMono(
                                    textStyle: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Align(
                      //     alignment: Alignment.topLeft,
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _flip(false);
                      //         });
                      //       },
                      //       child: NeumorphicIcon(
                      //         MaterialCommunityIcons.ethereum,
                      //         size: 32,
                      //         style: NeumorphicStyle(
                      //             color: Colors.black.withOpacity(0.7), depth: 2),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Align(
                      //     alignment: Alignment.topRight,
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _flip(false);
                      //         });
                      //       },
                      //       child: NeumorphicIcon(
                      //         MaterialCommunityIcons.home,
                      //         size: 32,
                      //         style: NeumorphicStyle(
                      //             surfaceIntensity: 0.9,
                      //             color: Colors.grey[900],
                      //             depth: 2,
                      //             shape: NeumorphicShape.convex),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _flip(false);
                      //         });
                      //       },
                      //       child: NeumorphicIcon(
                      //         MaterialCommunityIcons.qrcode_scan,
                      //         size: 24,
                      //         style: NeumorphicStyle(
                      //             surfaceIntensity: 0.9,
                      //             color: Colors.grey[900],
                      //             depth: 13,
                      //             shape: NeumorphicShape.flat),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(16.0)),
                    border: NeumorphicBorder(
                      color: Color(0x33000000),
                      width: 0.4,
                    ),
                    shape: NeumorphicShape.concave,
                    depth: -5,
                  ),
                ),
              ),
            );
          },
        );
      case 3:
        widget.prefs.setInt('id', 0);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            width: 250,
            height: 300,
            child: Neumorphic(
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                  BarcodeWidget(
                    padding: const EdgeInsets.all(32.0),
                    barcode: Barcode.qrCode(),
                    data: widget.prefs.getInt('id').toString(),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _flip(false);
                  //         });
                  //       },
                  //       child: NeumorphicIcon(
                  //         MaterialCommunityIcons.ethereum,
                  //         size: 32,
                  //         style: NeumorphicStyle(
                  //             color: Colors.black.withOpacity(0.7), depth: 2),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           id = 2;
                  //           _flip(false);
                  //         });
                  //       },
                  //       child: NeumorphicIcon(
                  //         MaterialCommunityIcons.information,
                  //         size: 32,
                  //         style: NeumorphicStyle(
                  //             surfaceIntensity: 0.9,
                  //             color: Colors.grey[900],
                  //             depth: 2,
                  //             shape: NeumorphicShape.convex),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _flip(false);
                  //         });
                  //       },
                  //       child: NeumorphicIcon(
                  //         MaterialCommunityIcons.home,
                  //         size: 24,
                  //         style: NeumorphicStyle(
                  //             surfaceIntensity: 0.9,
                  //             color: Colors.grey[900],
                  //             depth: 13,
                  //             shape: NeumorphicShape.flat),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
                border: NeumorphicBorder(
                  color: Color(0x33000000),
                  width: 0.4,
                ),
                shape: NeumorphicShape.concave,
                depth: -5,
              ),
            ),
          ),
        );
      default:
        widget.prefs.setInt('id', 0);
        return Container();
        break;
    }
  }

  Widget _buildTransactions() {
    return Column(
      children: <Widget>[
        ...testItems.map((item) {
          return _buildTransactionTile(item);
        })
      ],
    );
  }

  Widget _buildTransactionTile(Transaction tx) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${formatDate(tx.completed, [mm, '/', dd, '/', yyyy])}',
                        style: GoogleFonts.ibmPlexMono(
                            textStyle: TextStyle(
                                color: BlocProvider.of<ThemeBloc>(context)
                                        .state
                                        .isLight
                                    ? NeumorphicColors.decorationMaxWhiteColor
                                    : NeumorphicColors.embossMaxWhiteColor))),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '+ ${tx.amount.toStringAsFixed(18)}',
                      style: GoogleFonts.ibmPlexMono(
                          textStyle: TextStyle(
                              color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .isLight
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.green[200])),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Future<bool> _onBackButtonPressed() async {
    
    int id = widget.prefs.getInt('id');
    if (id == 0) {
      
      _flip(false);
    }
    return Future.value(false);
  }
}
