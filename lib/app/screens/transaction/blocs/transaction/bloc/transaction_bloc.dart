import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehtereum_wallet/app/screens/transaction/blocs/timeline/bloc/timeline_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc(TransactionState transactionState) : super(transactionState);

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is SubmitTransaction) {
      BlocProvider.of<TimelineBloc>(state.context).add(NextStep(index: 0));
      final _rpcUrl = "http://192.168.0.23:7545";
      final _wsUrl = "ws://192.168.0.23:7545/";
      final _privateKey =
          "9891aedc7a5e634b77554e4dbeac7ed0dc8845fe08d3cbd578e94b6ff6703775"; // extract to get sender address
      final _receiver =
          EthereumAddress.fromHex('0x83C94af5d7af787f571AD86B259b462CB292869D');

      final ethClient = new Web3Client(_rpcUrl, Client(), socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      });
      final credentials =
          await ethClient.credentialsFromPrivateKey(event.privateKey);
      final senderAddress = await credentials.extractAddress();
      
      yield(TransactionState(senderAddress: senderAddress.toString(), receiverAddress: event.receiverAddress, amount: event.amount, transactionHash: state.transactionHash, context: state.context));
      BlocProvider.of<TimelineBloc>(state.context).add(NextStep(index: 1));
      final result = await ethClient.sendTransaction(
        credentials,
        Transaction(
          from: senderAddress,
          to: EthereumAddress.fromHex(event.receiverAddress),
          maxGas: 100000,
          gasPrice: EtherAmount.inWei(BigInt.one),
          value:  EtherAmount.fromUnitAndValue(EtherUnit.ether, 1)
        ),
        chainId: 3
      );
      yield(TransactionState(senderAddress: senderAddress.toString(), receiverAddress: event.receiverAddress, amount: event.amount, transactionHash: result, context: state.context));
      BlocProvider.of<TimelineBloc>(state.context).add(NextStep(index: 4));
    }
  }
}
