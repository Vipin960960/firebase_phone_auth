class Validation{

  static final RegExp _mobileNoRegExp = RegExp(r"[6789]");

  static String? validMobile(mobileNo) {
    if (mobileNo.toString().isNotEmpty &&
        mobileNo.toString().length == 10 &&
        mobileNo.toString().startsWith(_mobileNoRegExp)) {
      return null;
    }
    return "Enter Valid Mobile Number";
  }

}