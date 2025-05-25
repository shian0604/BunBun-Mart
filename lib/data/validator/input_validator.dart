class InputValidator {
  static String? validateEmptyText(String? fieldnName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldnName is required';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Basic email regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Basic PH mobile number validation
    final phoneRegex = RegExp(r'^(09|\+639)\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid PH phone number';
    }

    return null;
  }

   static String? validateNumber(String? fieldName, String? value, {bool allowDecimal = false}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final pattern = allowDecimal ? r'^\d+(\.\d+)?$' : r'^\d+$';
    final numberRegex = RegExp(pattern);

    if (!numberRegex.hasMatch(value.trim())) {
      return '$fieldName must be a valid ${allowDecimal ? "number" : "whole number"}';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateReEnterPassword(
    String? value,
    String? originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter password';
    } else if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    } else if (value.length < 3) {
      return 'Full name must be at least 3 characters';
    }
    return null;
  }

  static String? validateStoreName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Store name is required';
    } else if (value.length < 3) {
      return 'Store name must be at least 3 characters';
    }
    return null;
  }

  static String? validateStreetAddress(String? value) {
    return validateEmptyText('Street Address', value);
  }

  static String? validateBarangay(String? value) {
    return validateEmptyText('Barangay', value);
  }

  static String? validateMunicipality(String? value) {
    return validateEmptyText('Municipality', value);
  }

  static String? validateProvinceRegion(String? value) {
    return validateEmptyText('Province/Region', value);
  }

  static String? validatePostalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }

    // Basic PH postal code validation (should be 4 digits)
    final postalCodeRegex = RegExp(r'^\d{4}$');
    if (!postalCodeRegex.hasMatch(value)) {
      return 'Enter a valid 4-digit postal code';
    }

    return null;
  }

  static String? validateBankAccountName(String? value) {
    return validateEmptyText('Bank Account Name', value);
  }

  static String? validateBankName(String? value) {
    return validateEmptyText('Bank Name', value);
  }

  static String? validateBankAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bank account number is required';
    }

    // Basic validation for bank account number (length can vary by bank)
    final bankAccountNumberRegex = RegExp(
      r'^\d{10,12}$',
    ); // Example: 10 to 12 digits
    if (!bankAccountNumberRegex.hasMatch(value)) {
      return 'Enter a valid bank account number';
    }

    return null;
  }

  static String? validatePaymentMethodPreferences(String? value) {
    return validateEmptyText('Payment Method Preferences', value);
  }

  static String? validateProductCategory(String? value) {
    return validateEmptyText('Product Category', value);
  }

  static String? validateShippingCourier(String? value) {
    return validateEmptyText('Shipping Courier', value);
  }

  static String? validateReturnAndRefundPolicy(bool? value) {
    if (value == null || !value) {
      return 'You must agree to the Return and Refund Policy';
    }
    return null;
  }

  static String? validateAgreementToTerms(bool? value) {
    if (value == null || !value) {
      return 'You must agree to the Terms and Conditions';
    }
    return null;
  }

  static String? validateAgreementToDataPrivacy(bool? value) {
    if (value == null || !value) {
      return 'You must agree to the Data Privacy Policy';
    }
    return null;
  }

  static final List<String> cssNamedColors = [
    'aliceblue',
    'antiquewhite',
    'aqua',
    'aquamarine',
    'azure',
    'beige',
    'bisque',
    'black',
    'blanchedalmond',
    'blue',
    'blueviolet',
    'brown',
    'burlywood',
    'cadetblue',
    'chartreuse',
    'chocolate',
    'coral',
    'cornflowerblue',
    'cornsilk',
    'crimson',
    'cyan',
    'darkblue',
    'darkcyan',
    'darkgoldenrod',
    'darkgray',
    'darkgreen',
    'darkkhaki',
    'darkmagenta',
    'darkolivegreen',
    'darkorange',
    'darkorchid',
    'darkred',
    'darksalmon',
    'darkseagreen',
    'darkslateblue',
    'darkslategray',
    'darkturquoise',
    'darkviolet',
    'deeppink',
    'deepskyblue',
    'dimgray',
    'dodgerblue',
    'firebrick',
    'floralwhite',
    'forestgreen',
    'fuchsia',
    'gainsboro',
    'ghostwhite',
    'gold',
    'goldenrod',
    'gray',
    'green',
    'greenyellow',
    'honeydew',
    'hotpink',
    'indianred',
    'indigo',
    'ivory',
    'khaki',
    'lavender',
    'lavenderblush',
    'lawngreen',
    'lemonchiffon',
    'lightblue',
    'lightcoral',
    'lightcyan',
    'lightgoldenrodyellow',
    'lightgreen',
    'lightgrey',
    'lightpink',
    'lightsalmon',
    'lightseagreen',
    'lightskyblue',
    'lightslategray',
    'lightsteelblue',
    'lightyellow',
    'lime',
    'limegreen',
    'linen',
    'magenta',
    'maroon',
    'mediumaquamarine',
    'mediumblue',
    'mediumorchid',
    'mediumpurple',
    'mediumseagreen',
    'mediumslateblue',
    'mediumspringgreen',
    'mediumturquoise',
    'mediumvioletred',
    'midnightblue',
    'mintcream',
    'mistyrose',
    'moccasin',
    'navajowhite',
    'navy',
    'oldlace',
    'olive',
    'olivedrab',
    'orange',
    'orangered',
    'orchid',
    'palegoldenrod',
    'palegreen',
    'paleturquoise',
    'palevioletred',
    'papayawhip',
    'peachpuff',
    'peru',
    'pink',
    'plum',
    'powderblue',
    'purple',
    'rebeccapurple',
    'red',
    'rosybrown',
    'royalblue',
    'saddlebrown',
    'salmon',
    'sandybrown',
    'seagreen',
    'seashell',
    'sienna',
    'silver',
    'skyblue',
    'slateblue',
    'slategray',
    'snow',
    'springgreen',
    'steelblue',
    'tan',
    'teal',
    'thistle',
    'tomato',
    'turquoise',
    'violet',
    'wheat',
    'white',
    'whitesmoke',
    'yellow',
    'yellowgreen',
  ];

  static String? validateCustomColor(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final trimmed = value.trim().toLowerCase();
    if (!cssNamedColors.contains(trimmed)) {
      return 'Enter a valid named color (e.g., "blue", "red", "green")';
    }

    return null;
  }

  static String? validateMaxLength(
    String? value,
    int maxLength,
    String fieldName,
  ) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be at most $maxLength characters';
    }
    return null;
  }

  static String? validateProductName(String? value) {
    final error = validateEmptyText('Product Name', value);
    if (error != null) return error;
    return validateMaxLength(value, 50, 'Product Name'); // 50-character limit
  }

  static String? validateProductDescription(String? value) {
    final error = validateEmptyText('Product Description', value);
    if (error != null) return error;
    return validateMaxLength(
      value,
      300,
      'Product Description',
    ); // 200-character limit
  }

  static String? validateProductPrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product Price is required';
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Enter a valid positive price';
    }
    return null;
  }

  static String? validateProductStocks(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product Stocks is required';
    }
    final stocks = int.tryParse(value);
    if (stocks == null || stocks < 0) {
      return 'Enter a valid non-negative stock quantity';
    }
    return null;
  }
}
