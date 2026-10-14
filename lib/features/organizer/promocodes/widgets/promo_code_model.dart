enum DiscountType { percentage, fixed }
enum ApplyToType { single, multiple, all }

class PromoCode {
  final String name;
  final DiscountType discountType;
  final int discountValue;
  final int usageLimit;
  final DateTime? startDate;
  final DateTime? endDate;
  final ApplyToType applyTo;
  final List<String> selectedEvents;
  final String promoCode;

  const PromoCode({
    required this.name,
    required this.discountType,
    required this.discountValue,
    required this.usageLimit,
    this.startDate,
    this.endDate,
    required this.applyTo,
    required this.selectedEvents,
    required this.promoCode,
  });

  String get discountString {
    if (discountType == DiscountType.percentage) {
      return "$discountValue% OFF";
    } else {
      return "\$$discountValue OFF";
    }
  }

  String get expiryString {
    if (endDate == null) return "No Expiration";
    // Format to "MMM dd, yyyy" e.g., "Feb 14, 2025" or "Aug 31, 2025"
    final months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    final month = months[endDate!.month - 1];
    return "$month ${endDate!.day.toString().padLeft(2, '0')}, ${endDate!.year}";
  }

  String get appliedToSummary {
    switch (applyTo) {
      case ApplyToType.single:
        return "1 Event";
      case ApplyToType.multiple:
        return "${selectedEvents.length} Events";
      case ApplyToType.all:
        return "All Events";
    }
  }
}
