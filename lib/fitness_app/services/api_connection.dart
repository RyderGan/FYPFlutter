//port 8080 for app
//port 51036 for web
class Api {
  // Use localhost:3000 for iOS and 10.0.2.2:3000 for Android

  // void getPlatform() {
  //   if (Platform.isAndroid) {
  //     // Android-specific connection
  //     hostConnect = "10.0.2.2:3000/api_healthApp";
  //   } else if (Platform.isIOS) {
  //     // iOS-specific connection
  //     hostConnect = "http://localhost/api_healthApp";
  //   } else {
  //     // Website connection
  //     hostConnect = "http://192.168.0.208:51036/api_healthApp";
  //   }
  // }

  static const hostConnect = "http://localhost/api_healthApp";
  static const hostConnectUser = "$hostConnect/user";

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
  //delete visceral fat
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

  //get all sets
  static const getAllWorkoutSets = "$hostConnect/user/getAllWorkoutSets.php";
  //get path details
  static const getPathDetails = "$hostConnect/user/getOnePath.php";
  //add user checkpoint
  static const recordUserCheckpoint = "$hostConnect/user/addUserCheckpoint.php";
  //add set bonus points to user
  static const addSetBonusPoints = "$hostConnect/user/addSetBonusPoints.php";

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
  static const getcheckpointList = "$hostConnect/admin/getcheckpointList.php";
  //delete checkpoint
  static const deleteCheckpoint = "$hostConnect/admin/deleteCheckpoint.php";
  //change checkpoint info
  static const updateCheckpointInfo =
      "$hostConnect/admin/updateCheckpointInfo.php";
  //add checkpoint
  static const addCheckpoint = "$hostConnect/admin/addCheckpoint.php";
  //get path list
  static const getPathList = "$hostConnect/admin/getPathList.php";
  //delete path heckpoint
  static const deletePath = "$hostConnect/admin/deletePath.php";
  //update path info
  static const updatePathInfo = "$hostConnect/admin/updatePathInfo.php";
  //update path checkpoint info
  static const updatePathCheckpoints =
      "$hostConnect/admin/updatePathCheckpoints.php";
  //add path
  static const addSet = "$hostConnect/admin/addSet.php";
  //get set list
  static const getSetList = "$hostConnect/admin/getSetList.php";
  //delete set
  static const deleteSet = "$hostConnect/admin/deleteSet.php";
  //update set info
  static const updateSetInfo = "$hostConnect/admin/updateSetInfo.php";
  //update set checkpoint info
  static const updateSetPaths = "$hostConnect/admin/updateSetPaths.php";
  //add set
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
  //get claim rewards list
  static const addClaimReward = "$hostConnect/user/addClaimReward.php";
  //get claim rewards list
  static const getClaimRewardList = "$hostConnect/admin/getClaimRewardList.php";
  //delete claim reward
  static const deleteClaimReward = "$hostConnect/admin/deleteClaimReward.php";
  //admin claim reward
  static const adminClaimReward = "$hostConnect/admin/adminClaimReward.php";
  //send notification
  static const addNotification = "$hostConnect/user/addNotification.php";
  //get all notifications
  static const getAllUserNotifications =
      "$hostConnect/user/getUserAllNotifications.php";
  //mark notification as read
  static const markNotificationAsRead =
      "$hostConnect/user/markNotificationAsRead.php";
  //unmark notification as read
  static const unmarkNotificationAsRead =
      "$hostConnect/user/unmarkNotificationAsRead.php";
  //delete notification
  static const deleteOneNotification =
      "$hostConnect/user/deleteNotification.php";
  //start workout
  static const startRFIDWorkout = "$hostConnect/user/startWorkout.php";
  //stop workout
  static const stopRFIDWorkout = "$hostConnect/user/stopWorkout.php";
  //get current workout
  static const getRFIDWorkout = "$hostConnect/user/getWorkout.php";
  //get checkpoint info
  static const getCheckpointInfo = "$hostConnect/user/getCheckpointInfo.php";
  //change user info
  static const adminUpdateUserInfo = "$hostConnect/admin/updateUserInfo.php";
}
