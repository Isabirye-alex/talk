class UssdViewObject {
  final String phoneNumber;
  final String text;
  final String value;
  final List? options;

  UssdViewObject({
    required this.phoneNumber,
    required this.text,
    required this.value,
    this.options,
  });

  /// Creates a [UssdViewObject] from a USSD response string, extracting options from each non-empty line.
  /// 
  /// [text] is the USSD response string, [phoneNumber] and [value] are optional parameters.
  factory UssdViewObject.fromUssdString( String text, { String phoneNumber = '', String value = '',}) {
    final lines = text.split('\n');
    final options = lines.where((line) => line.isNotEmpty).toList();
    return UssdViewObject(
      phoneNumber: phoneNumber,
      text: text,
      value: value,
      options: options,
    );
  }
}
