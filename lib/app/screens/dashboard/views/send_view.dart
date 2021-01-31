import 'package:ehtereum_wallet/app/screens/dashboard/blocs/text/text_bloc.dart';
import 'package:ehtereum_wallet/app/screens/dashboard/blocs/theme/bloc/theme_bloc.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:ehtereum_wallet/app/screens/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendView extends StatelessWidget {

  final SharedPreferences prefs;

  SendView({this.prefs});  

  final addressController = new TextEditingController(text: '');
  final amountController = new TextEditingController(text: '');
  final messageController = new TextEditingController(text: '');

  Future<void> _scanQRCode(context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666', 'Cancel', true, ScanMode.QR);
    debugPrint('the code is: $qrCode');
    addressController.text = qrCode;
    BlocProvider.of<TextBloc>(context)
        .add(ChangeText(address: qrCode, amount: '', message: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextBloc, TextState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Fill out fields',
                                style: GoogleFonts.ibmPlexMono(
                                  textStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: BlocProvider.of<ThemeBloc>(context)
                                              .state
                                              .isLight
                                          ? NeumorphicColors
                                              .decorationMaxWhiteColor
                                          : NeumorphicColors
                                              .embossMaxWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Neumorphic(
                              padding: const EdgeInsets.all(8.0),
                              style: NeumorphicStyle(
                                  shadowLightColor: BlocProvider.of<ThemeBloc>(context).state.isLight ? Colors.grey[400] : Colors.blueGrey[400]),
                              child: TextField(
                                maxLines: 1,
                                controller: addressController,
                                onChanged: (val) {
                                  BlocProvider.of<TextBloc>(context).add(ChangeText(address: val, amount: state.amount, message: state.message));
                                  addressController.value = TextEditingValue(
                                    text: val,
                                    selection: TextSelection.fromPosition(TextPosition(offset: val.length))
                                  );
                                },
                                style: TextStyle(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? Colors.grey[700]
                                      : NeumorphicColors.embossMaxWhiteColor,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                    .state
                                                    .isLight
                                                ? Colors.grey[500]
                                                    .withOpacity(0.85)
                                                : NeumorphicColors
                                                    .embossMaxWhiteColor
                                                    .withOpacity(0.35),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w100),
                                    hintText: 'Address: i.e., 0x1d1...y18a62l'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Neumorphic(
                              padding: const EdgeInsets.all(8.0),
                              style: NeumorphicStyle(
                                  shadowLightColor: BlocProvider.of<ThemeBloc>(context).state.isLight ? Colors.grey[400] : Colors.blueGrey[400]),
                              child: TextField(
                                maxLines: 1,
                                controller: amountController,
                                onChanged: (val) {
                                  BlocProvider.of<TextBloc>(context).add(ChangeText(address: state.address, amount: val, message: state.message));
                                  amountController.value = TextEditingValue(
                                    text: val,
                                    selection: TextSelection.fromPosition(TextPosition(offset: val.length))
                                  );
                                },
                                style: TextStyle(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? Colors.grey[700]
                                      : NeumorphicColors.embossMaxWhiteColor,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                    .state
                                                    .isLight
                                                ? Colors.grey[500]
                                                    .withOpacity(0.85)
                                                : NeumorphicColors
                                                    .embossMaxWhiteColor
                                                    .withOpacity(0.35),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w100),
                                    hintText:
                                        'Amount: i.e., 0.00131319319 ETH'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Neumorphic(
                              padding: const EdgeInsets.all(8.0),
                              style: NeumorphicStyle(
                                  shadowLightColor: BlocProvider.of<ThemeBloc>(context).state.isLight ? Colors.grey[400] : Colors.blueGrey[400]),
                              child: TextField(
                                maxLines: 1,
                                controller: messageController,
                                onChanged: (val) {
                                  BlocProvider.of<TextBloc>(context).add(ChangeText(address: state.address, amount: state.amount, message: val));
                                  messageController.value = TextEditingValue(
                                    text: val,
                                    selection: TextSelection.fromPosition(TextPosition(offset: val.length))
                                  );
                                },
                                style: TextStyle(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? Colors.grey[700]
                                      : NeumorphicColors.embossMaxWhiteColor,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                    .state
                                                    .isLight
                                                ? Colors.grey[500]
                                                    .withOpacity(0.85)
                                                : NeumorphicColors
                                                    .embossMaxWhiteColor
                                                    .withOpacity(0.35),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w100),
                                    hintText:
                                        'Message (optional): i.e., bills, gift, food'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: NeumorphicButton(
                              onPressed: () {
                                BlocProvider.of<TransactionBloc>(context).add(SubmitTransaction(privateKey: '9891aedc7a5e634b77554e4dbeac7ed0dc8845fe08d3cbd578e94b6ff6703775', receiverAddress: '0x83C94af5d7af787f571AD86B259b462CB292869D', amount: '0.0007123'));
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransactionScreen(prefs: prefs,)));
                              },
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.beveled(BorderRadius.all(Radius.circular(9.0)),),
                                depth: 3.0,
                                shape: NeumorphicShape.concave,
                                shadowLightColor: BlocProvider.of<ThemeBloc>(context).state.isLight ? Colors.grey[400] : Colors.blueGrey[500]
                              ),
                              child: NeumorphicText(
                                'Submit Transaction',
                                textStyle: NeumorphicTextStyle(
                                  
                                ),
                                style: NeumorphicStyle(
                                  shadowLightColor: BlocProvider.of<ThemeBloc>(context).state.isLight ? Colors.grey[400] : Colors.blueGrey[500],
                                  color: BlocProvider.of<ThemeBloc>(context)
                                            .state
                                            .isLight
                                        ? Colors.grey[700]
                                        : NeumorphicColors.embossMaxWhiteColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Scan a QR Code',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: TextStyle(
                                  fontSize: 24.0,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .isLight
                                      ? NeumorphicColors.decorationMaxWhiteColor
                                      : NeumorphicColors.embossMaxWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await _scanQRCode(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Lottie.asset(
                                    'assets/qr_code_animation.json',
                                    height: 150),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
