class AppValidator {
  static String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return ("Please enter your email address");
    } else if (!regex.hasMatch(value)) {
      return ("Please enter a valid email address");
    } else {
      return null;
    }
  }

  static String? emptyField(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return ("Enter your name");
    } else {
      return null;
    }
  }

  static String? validateIndianMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mobile number is required";
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return "Enter a valid 10-digit mobile number";
    }

    return null; // valid
  }
  static String? comNameValidator(String? value) {
    if (value!.isEmpty) {
      return ("Enter your name company name");
    } else {
      return null;
    }
  }

  static String? billTo(String? value) {
    if (value!.isEmpty) {
      return ("Please fill bill to");
    } else {
      return null;
    }
  }

  static String? invoiceFrom(String? value) {
    if (value!.isEmpty) {
      return ("Please fill Invoice from");
    } else {
      return null;
    }
  }

  static String? shipTo(String? value) {
    if (value!.isEmpty) {
      return ("Please fill ship to");
    } else {
      return null;
    }
  }

  static String? date(String? value) {
    if (value!.isEmpty) {
      return ("Please select date");
    } else {
      return null;
    }
  }

  static String? description(String? value) {
    if (value!.isEmpty) {
      return ("Please add description");
    } else {
      return null;
    }
  }

  static String? rate(String? value) {
    if (value!.isEmpty) {
      return ("Please add rate");
    } else {
      return null;
    }
  }

  static String? quantity(String? value) {
    if (value!.isEmpty) {
      return ("Please add quantity");
    } else {
      return null;
    }
  }

  static String? note(String? value) {
    if (value!.isEmpty) {
      return ("Please add note");
    } else {
      return null;
    }
  }




// static bool isAdult(String dob) {
//   final dateOfBirth = DateFormat("MM-dd-yyyy").parse(dob);
//   final now = DateTime.now();
//   final eighteenYearsAgo = DateTime(
//     now.year - 16,
//     now.month,
//     now.day + 1, // add day to return true on birthday
//   );
//   return dateOfBirth.isBefore(eighteenYearsAgo);
// }
}
