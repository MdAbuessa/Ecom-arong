class WithdrawRequest {
  final double amount;
  final String method; // "Bank Transfer" or "Stripe"
  final String? holderName;
  final String? bankName;
  final String? accountNumber;
  final String? routingNumber;
  final String? swift;
  final String? stripeEmail;

  WithdrawRequest({
    required this.amount,
    required this.method,
    this.holderName,
    this.bankName,
    this.accountNumber,
    this.routingNumber,
    this.swift,
    this.stripeEmail,
  });

  WithdrawRequest copyWith({
    double? amount,
    String? method,
    String? holderName,
    String? bankName,
    String? accountNumber,
    String? routingNumber,
    String? swift,
    String? stripeEmail,
  }) {
    return WithdrawRequest(
      amount: amount ?? this.amount,
      method: method ?? this.method,
      holderName: holderName ?? this.holderName,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      routingNumber: routingNumber ?? this.routingNumber,
      swift: swift ?? this.swift,
      stripeEmail: stripeEmail ?? this.stripeEmail,
    );
  }
}
