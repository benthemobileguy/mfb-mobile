import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_controller.dart';
import 'package:tampay_mobile/base/custom_progess_dialog.dart';
import 'package:tampay_mobile/base/resizer/fetch_pixels.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class TierTwoUpgradeScreen extends ConsumerStatefulWidget {
  const TierTwoUpgradeScreen({super.key});

  @override
  ConsumerState<TierTwoUpgradeScreen> createState() =>
      _TierTwoUpgradeScreenState();
}

class _TierTwoUpgradeScreenState extends ConsumerState<TierTwoUpgradeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Page 1 Controllers
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController incomeRangeController = TextEditingController();
  final TextEditingController employmentStatusController =
      TextEditingController();
  File? bankStatementFile;

  // Page 2 Controllers
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController lgaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  File? utilityBillFile;

  final ImagePicker _picker = ImagePicker();

  // Dropdown options
  final List<String> occupationOptions = [
    'Accountant',
    'Actor',
    'Architect, Banker'
  ];
  final List<String> incomeRangeOptions = [
    '200000',
    '500000',
    '2000000',
    '3000000'
  ];
  final List<String> employmentStatusOptions = ['Employed', 'Unemployed'];
  final List<String> stateOptions = ['State 1', 'State 2', 'State 3'];
  final List<String> lgaOptions = ['LGA 1', 'LGA 2', 'LGA 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              appBar(context, ""),
              getSvgImage("tier_two.svg", height: 78, width: 78),
              getVerSpace(20),
              getCustomFont("You Deserve A Tier 2 Account", 16, grey700, 1,
                  fontWeight: FontWeight.w500),
              getVerSpace(5),
              getCustomFont(
                "You need to upgrade your account to get\naccess to foreign wallets",
                14.5,
                grey700,
                2,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.center,
              ),
              getVerSpace(30),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildPageOne(),
                    _buildPageTwo(),
                  ],
                ),
              ),
              getButton(
                context,
                _isPageComplete() ? primaryColor : Colors.grey,
                _currentPage == 0 ? "Next step" : "Complete Upgrade",
                Colors.white,
                _isPageComplete()
                    ? (_currentPage == 0
                        ? () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            )
                        : _completeUpgrade)
                    : null,
                16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60),
              ),
              getVerSpace(14),
            ],
          ),
        ),
      ),
    );
  }

  bool _isPageComplete() {
    if (_currentPage == 0) {
      return occupationController.text.isNotEmpty &&
          incomeRangeController.text.isNotEmpty &&
          employmentStatusController.text.isNotEmpty &&
          bankStatementFile != null;
    } else {
      return houseNumberController.text.isNotEmpty &&
          stateController.text.isNotEmpty &&
          lgaController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          utilityBillFile != null;
    }
  }

  Widget _buildPageOne() {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () => showDropdownModal(context, occupationOptions, (value) {
              setState(() {
                occupationController.text = value;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Occupation",
              title: "Select your occupation",
              occupationController,
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImage: "dropdown.svg",
              showCursor: false,
              isEnable: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () =>
                showDropdownModal(context, incomeRangeOptions, (value) {
              setState(() {
                incomeRangeController.text = value;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Income range",
              title: "Select income range",
              incomeRangeController,
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImage: "dropdown.svg",
              showCursor: false,
              isEnable: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () =>
                showDropdownModal(context, employmentStatusOptions, (value) {
              setState(() {
                employmentStatusController.text = value;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Select employment status",
              title: "Select employment status",
              employmentStatusController,
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImage: "dropdown.svg",
              showCursor: false,
              isEnable: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () => _showImagePickerModal((file) {
              setState(() {
                bankStatementFile = file;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Upload bank statement",
              title: "Upload statement",
              TextEditingController(
                  text: bankStatementFile != null ? "Image Selected" : ""),
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImage: "upload.svg",
              showCursor: false,
              isEnable: false,
            ),
          ),
          if (bankStatementFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(bankStatementFile!.path.split('/').last),
            ),
        ],
      ),
    );
  }

  Widget _buildPageTwo() {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: getDefaultTextFiledWithLabel(
              context,
              "Enter house number",
              title: "House number",
              houseNumberController,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () => showDropdownModal(context, stateOptions, (value) {
              setState(() {
                stateController.text = value;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Select state",
              title: "State",
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              stateController,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImage: "dropdown.svg",
              isEnable: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () => showDropdownModal(context, lgaOptions, (value) {
              setState(() {
                lgaController.text = value;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Select LGA",
              title: "LGA",
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              lgaController,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImage: "dropdown.svg",
              isEnable: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () {},
            child: getDefaultTextFiledWithLabel(
              context,
              "Enter city",
              title: "City",
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              cityController,
              height: FetchPixels.getPixelHeight(60),
              withSuffix: false,
            ),
          ),
          getVerSpace(14),
          InkWell(
            onTap: () => _showImagePickerModal((file) {
              setState(() {
                utilityBillFile = file;
              });
            }),
            child: getDefaultTextFiledWithLabel(
              context,
              "Upload utility bill",
              title: "Utility Bill",
              TextEditingController(
                  text: utilityBillFile != null ? "Image Selected" : ""),
              height: FetchPixels.getPixelHeight(60),
              withSuffix: true,
              suffixImageHeight: 23,
              suffixImageWidth: 23,
              suffixImage: "upload.svg",
              showCursor: false,
              isEnable: false,
            ),
          ),
          if (utilityBillFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(utilityBillFile!.path.split('/').last),
            ),
          getVerSpace(20),
        ],
      ),
    );
  }

  Future<void> _completeUpgrade() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final String utilityBillUrl = utilityBillFile?.path ?? '';
    final String bankStatementUrl = bankStatementFile?.path ?? '';
    final String street = houseNumberController.text;
    final String city = cityController.text;
    const String country = 'Nigeria';
    const String postalCode = '234';
    final String houseNo = houseNumberController.text;
    final String lga = lgaController.text;
    final String state = stateController.text;
    final String occupation = occupationController.text;
    final String employmentStatus = employmentStatusController.text;
    const String incomeSource = 'Salary';
    final String incomeRange = incomeRangeController.text;
    const String accountDesignation = 'Personal Use';

    await ref.read(signUpControllerProvider).tier2Upgrade(
          utilityBillUrl: utilityBillUrl,
          bankStatementUrl: bankStatementUrl,
          street: street,
          city: city,
          country: country,
          postalCode: postalCode,
          houseNo: houseNo,
          lga: lga,
          state: state,
          occupation: occupation,
          employmentStatus: employmentStatus,
          incomeSource: incomeSource,
          incomeRange: incomeRange,
          accountDesignation: accountDesignation,
          context: context,
        );

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Future<void> _showImagePickerModal(Function(File) onImageSelected) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: getCustomFont("Upload from Gallery", 16, grey800, 1),
            onTap: () async {
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                onImageSelected(File(pickedFile.path));
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: getCustomFont("Upload from Camera", 16, grey800, 1),
            onTap: () async {
              final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                onImageSelected(File(pickedFile.path));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
