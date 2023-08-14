class Transaction {
  final String? hash;
  final String? nonce;
  final String? transactionIndex;
  final String? fromAddress;
  final String? toAddress;
  final String? value;
  final String? gas;
  final String? gasPrice;
  final String? input;
  final String? receiptCumulativeGasUsed;
  final String? receiptGasUsed;
  final String? receiptContractAddress;
  final String? receiptRoot;
  final String? receiptStatus;
  final String? blockTimestamp;
  final String? blockNumber;
  final String? blockHash;
  final List<int>? transferIndex;
  final String? toAddressLabel;

  Transaction({
    this.hash,
    this.nonce,
    this.transactionIndex,
    this.fromAddress,
    this.toAddress,
    this.value,
    this.gas,
    this.gasPrice,
    this.input,
    this.receiptCumulativeGasUsed,
    this.receiptGasUsed,
    this.receiptContractAddress,
    this.receiptRoot,
    this.receiptStatus,
    this.blockTimestamp,
    this.blockNumber,
    this.blockHash,
    this.transferIndex,
    this.toAddressLabel,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      hash: json['hash'],
      nonce: json['nonce'],
      transactionIndex: json['transaction_index'],
      fromAddress: json['from_address'],
      toAddress: json['to_address'],
      value: json['value'],
      gas: json['gas'],
      gasPrice: json['gas_price'],
      input: json['input'],
      receiptCumulativeGasUsed: json['receipt_cumulative_gas_used'],
      receiptGasUsed: json['receipt_gas_used'],
      receiptContractAddress: json['receipt_contract_address'],
      receiptRoot: json['receipt_root'],
      receiptStatus: json['receipt_status'],
      blockTimestamp: json['block_timestamp'],
      blockNumber: json['block_number'],
      blockHash: json['block_hash'],
      transferIndex: List<int>.from(json['transfer_index'] ?? []),
      toAddressLabel: json['to_address_label'] ?? '',
    );
  }
}


class ApiResponse {
  final int? total;
  final int pageSize;
  final int page;
  final String? cursor;
  final List<Transaction> result;

  ApiResponse({
    this.total,
    required this.pageSize,
    required this.page,
    this.cursor,
    required this.result,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      total: json['total'],
      pageSize: json['page_size'],
      page: json['page'],
      cursor: json['cursor'],
      result: List<Transaction>.from(json['result'].map((x) => Transaction.fromJson(x))),
    );
  }
}