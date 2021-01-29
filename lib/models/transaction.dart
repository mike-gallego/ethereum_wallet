class Transaction {
  String txHash;
  String webReceipt;
  String receiver;
  String sender;
  double amount;
  DateTime started;
  DateTime completed;

  Transaction({
    this.txHash,
    this.webReceipt,
    this.receiver,
    this.sender,
    this.amount,
    this.started,
    this.completed,
  });

  String get getTxHash => txHash;

  set setTxHash(String txHash) => this.txHash = txHash;

  String get getWebReceipt => webReceipt;

  set setWebReceipt(String webReceipt) => this.webReceipt = webReceipt;

  double get getAmount => amount;
  
  set setAmount(double amount) => this.amount = amount;

  String get getReceiver => receiver;

  set setReceiver(String receiver) => this.receiver = receiver;

  String get getSender => sender;

  set setSender(String sender) => this.sender = sender;

}
