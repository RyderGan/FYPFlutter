class Api {
  // Use localhost:3000 for iOS and 10.0.2.2:3000 for Android
  static const hostConnect = "http://localhost/api_healthApp";
  static const hostConnectUser = "$hostConnect/user";
  //http://192.168.0.208:8080/

  //signUp user
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  //login
  static const login = "$hostConnect/user/login.php";
  //admin login
  static const adminLogin = "$hostConnect/user/login.php";
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
  //get user all step counts
  static const getUserAllStepCounts =
      "$hostConnect/user/getUserAllStepCounts.php";
  //get user total stepcounts
  static const getUserLastStepCount =
      "$hostConnect/user/getUserLastStepCount.php";
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
  //get user visceral fat
  static const getUserVisceralFat = "$hostConnect/user/getUserVisceralFat.php";
  //add new visceral fat
  static const addNewVisceralFat = "$hostConnect/user/addVisceralFat.php";
  //get user all visceral fat
  static const getUserAllVisceralFat =
      "$hostConnect/user/getUserAllVisceralFat.php";
  //update visceral fat
  static const updateVisceralFat = "$hostConnect/user/updateVisceralFat.php";
  //delete blood pressure
  static const deleteUserVisceralFat =
      "$hostConnect/user/deleteUserVisceralFat.php";
  //get top first staff
  static const getTopFirstStaff = "$hostConnect/user/getTopFirstStaff.php";
  //get top second staff
  static const getTopSecondStaff = "$hostConnect/user/getTopSecondStaff.php";
  //get top third staff
  static const getTopThirdStaff = "$hostConnect/user/getTopThirdStaff.php";
  //get top first student
  static const getTopFirstStudent = "$hostConnect/user/getTopFirstStudent.php";
  //get top second student
  static const getTopSecondStudent =
      "$hostConnect/user/getTopSecondStudent.php";
  //get top third student
  static const getTopThirdStudent = "$hostConnect/user/getTopThirdStudent.php";
  //get staff ranking
  static const getStaffRanking = "$hostConnect/user/getStaffRanking.php";
  //get student ranking
  static const getStudentRanking = "$hostConnect/user/getStudentRanking.php";
  //add user checkpoint
  static const recordUserCheckpoint = "$hostConnect/user/addUserCheckpoint.php";
  //get all rewards
  static const getAllRewards = "$hostConnect/user/getAllRewards.php";
  //claim reward
  static const claimReward = "$hostConnect/user/claimReward.php";

  //get user list
  static const getUserList = "$hostConnect/admin/getUserList.php";
  //get feedback list
  static const getFeedbackList = "$hostConnect/admin/getFeedbackList.php";
  //get checkpoint list
  static const getCheckpointList = "$hostConnect/admin/getCheckpointList.php";
  //get reward list
  static const getRewardList = "$hostConnect/admin/getRewardList.php";
  //delete user
  static const deleteUser = "$hostConnect/admin/deleteUser.php";
  //delete feedback
  static const deleteFeedback = "$hostConnect/admin/deleteFeedback.php";
  //delete reward
  static const deleteReward = "$hostConnect/admin/deleteReward.php";
  //change reward info
  static const updateRewardInfo = "$hostConnect/admin/updateRewardInfo.php";
  //add reward
  static const addReward = "$hostConnect/admin/addReward.php";
  //get rfid checkpoint list
  static const getRfidCheckpointList =
      "$hostConnect/admin/getRfidCheckpointList.php";
  //delete rfid heckpoint
  static const deleteRfidCheckpoint =
      "$hostConnect/admin/deleteRfidCheckpoint.php";
  //change rfid heckpoint info
  static const updateRfidCheckpointInfo =
      "$hostConnect/admin/updateRfidCheckpointInfo.php";
  //add rfid checkpoint
  static const addRfidCheckpoint = "$hostConnect/admin/addRfidCheckpoint.php";
  //get path list
  static const getPathList = "$hostConnect/admin/getPathList.php";
  //delete path heckpoint
  static const deletePath = "$hostConnect/admin/deletePath.php";
  //change path info
  static const updatePathInfo = "$hostConnect/admin/updatePathInfo.php";
  //add path
  static const addPath = "$hostConnect/admin/addPath.php";
  //get about us
  static const getAboutUs = "$hostConnect/admin/getAboutUs.php";
  //update about us
  static const updateAboutUsInfo = "$hostConnect/admin/updateAboutUsInfo.php";
  //get rfid band list
  static const getRfidBandList = "$hostConnect/admin/getRfidBandList.php";
  //delete rfid band heckpoint
  static const deleteRfidBand = "$hostConnect/admin/deleteRfidBand.php";
  //change rfid band info
  static const updateRfidBandInfo = "$hostConnect/admin/updateRfidBandInfo.php";
  //add rfid band
  static const addRfidBand = "$hostConnect/admin/addRfidBand.php";
}
