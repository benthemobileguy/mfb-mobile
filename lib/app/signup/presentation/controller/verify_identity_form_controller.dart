import 'package:flutter/material.dart';

class VerifyIdentityFormController extends ChangeNotifier {
  // Text controllers for form fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bvnController = TextEditingController();

  // Focus nodes for managing input focus
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode bvnFocusNode = FocusNode();

  // Track the state of the form fields
  bool isFirstNameValid = false;
  bool isLastNameValid = false;
  bool isBvnValid = false;

  VerifyIdentityFormController() {
    // Add listeners to form field controllers
    firstNameController.addListener(_validateFirstName);
    lastNameController.addListener(_validateLastName);
    bvnController.addListener(_validateBvn);
  }

  // Validation logic for first name
  void _validateFirstName() {
    isFirstNameValid = firstNameController.text.isNotEmpty;
    notifyListeners();
  }

  // Validation logic for last name
  void _validateLastName() {
    isLastNameValid = lastNameController.text.isNotEmpty;
    notifyListeners();
  }

  // Validation logic for BVN (should be at least 10 characters)
  void _validateBvn() {
    isBvnValid = bvnController.text.length >= 10;
    notifyListeners();
  }

  // Form is valid if all fields are valid
  bool get isFormValid => isFirstNameValid && isLastNameValid && isBvnValid;

  // Dispose controllers and focus nodes when no longer needed
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bvnController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    bvnFocusNode.dispose();
    super.dispose();
  }
}
