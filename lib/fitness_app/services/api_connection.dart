class Api {
  static const hostConnect = "http://192.168.0.208:8080/api_healthApp";
  static const hostConnectUser = "$hostConnect/user";

  //signUp user
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  //login
  static const login = "$hostConnect/user/login.php";
  //validate reset password
  static const validateResetPassword =
      "$hostConnect/user/validateResetPassword.php";
  //reset password
  static const resetPassword = "$hostConnect/user/resetPassword.php";
  //get user details
  static const getUserDetails = "$hostConnect/user/getUserDetails.php";
  //change login details
  static const updateUserEmail = "$hostConnect/user/updateUserEmail.php";
  static const updateUserPassword = "$hostConnect/user/updateUserPassword.php";
  static const validatePassword = "$hostConnect/user/validate_password.php";
  //change user info
  static const updateUserInfo = "$hostConnect/user/updateUserInfo.php";
  //send feedback
  static const addFeedback = "$hostConnect/user/addFeedback.php";
  //get user step count
  static const getUserStepCount = "$hostConnect/user/getUserStepCount.php";
  //update stepCount
  static const updateStepCount = "$hostConnect/user/updateStepCount.php";
  //get user current bmi
  static const getUserBmi = "$hostConnect/user/getUserBmi.php";
  //get user all bmi
  static const getUserAllBmi = "$hostConnect/user/getUserAllBmi.php";
  //add new bmi
  static const addNewBmi = "$hostConnect/user/addBmi.php";
  //update bmi
  static const updateBmi = "$hostConnect/user/updateBmi.php";
  //delete user bmi
  static const deleteUserBmi = "$hostConnect/user/deleteUserBmi.php";
  //get user blood pressure
  static const getUserBloodPressure =
      "$hostConnect/user/getUserBloodPressure.php";
  //add new blood pressure
  static const addNewBloodPressure = "$hostConnect/user/addBloodPressure.php";
  //get user all blood pressure
  static const getUserAllBloodPressure =
      "$hostConnect/user/getUserAllBloodPressure.php";
  //update blood pressure
  static const updateBloodPressure =
      "$hostConnect/user/updateBloodPressure.php";
  //delete blood pressure
  static const deleteUserBloodPressure =
      "$hostConnect/user/deleteUserBloodPressure.php";
}
