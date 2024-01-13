import 'package:fitnessapp/fitness_app/views/Admin/path_search_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/send_notification_page.dart';
import 'package:fitnessapp/fitness_app/views/User/about_us_page.dart';
import 'package:fitnessapp/fitness_app/views/User/blood_pressure_page.dart';
import 'package:fitnessapp/fitness_app/views/User/bmi_page.dart';
import 'package:fitnessapp/fitness_app/views/User/change_email_password_page.dart';
import 'package:fitnessapp/fitness_app/views/User/change_user_info_page.dart';
import 'package:fitnessapp/fitness_app/views/User/loading_page.dart';
import 'package:fitnessapp/fitness_app/views/User/login_page.dart';
import 'package:fitnessapp/fitness_app/views/User/notification_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/qr_code_result_page.dart';
import 'package:fitnessapp/fitness_app/views/User/register_page.dart';
import 'package:fitnessapp/fitness_app/views/User/reset_password_page.dart';
import 'package:fitnessapp/fitness_app/views/User/send_feedback_page.dart';
import 'package:fitnessapp/fitness_app/views/User/staff_ranking_page.dart';
import 'package:fitnessapp/fitness_app/views/User/step_count_page.dart';
import 'package:fitnessapp/fitness_app/views/User/student_ranking_page.dart';
import 'package:fitnessapp/fitness_app/views/User/visceral_fat_page.dart';
import 'package:fitnessapp/fitness_app/views/User/workout_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/root_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:fitnessapp/fitness_app/views/Admin/user_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/admin_login_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/admin_loading_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/admin_root_app.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_user_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/rewards_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_reward_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/add_reward_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/checkpoint_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_checkpoint_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/add_checkpoint_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/path_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_path_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/add_path_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_path_checkpoints_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/set_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_set_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/add_set_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_set_paths_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/checkpoint_search_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/checkpoint_qr_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/view_feedback_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/feedback_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/view_claim_reward_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/claim_reward_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/app_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/about_us_admin_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_about_us_info_page.dart';
import 'package:fitnessapp/fitness_app/views/User/about_us_user_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/rfid_band_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/edit_rfid_band_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/add_rfid_band_info_page.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:get/get.dart';

/// Routes name to directly navigate the route by its name
class Routes {
  late final Rx<UserModel> user;
  static String admin_login = '/admin_login';
  static String admin_loading = '/admin_loading';
  static String admin_root_app = '/admin_root_app';
  static String edit_user_info = '/edit_user_info';
  static String feedback = '/feedback';
  static String view_feedback = '/view_feedback';
  static String send_notification = '/send_notification';
  static String claim_reward = '/feedback';
  static String view_claim_reward = '/view_claim_reward';
  static String rewards = '/rewards';
  static String edit_reward_info = '/edit_reward_info';
  static String add_reward_info = '/add_reward_info';
  static String checkpoint = '/checkpoint';
  static String edit_checkpoint_info = '/edit_checkpoint_info';
  static String add_checkpoint_info = '/add_checkpoint_info';
  static String path = '/path';
  static String edit_path_info = '/edit_path_info';
  static String add_path_info = '/add_path_info';
  static String edit_path_checkpoints = '/edit_path_checkpoints';
  static String checkpoint_search = '/checkpoint_search';
  static String checkpoint_qr = '/checkpoint_qr';
  static String set = '/set';
  static String edit_set_info = '/edit_set_info';
  static String add_set_info = '/add_set_info';
  static String edit_set_paths = '/edit_set_paths';
  static String path_search = '/path_search';
  static String app_info_page = '/app_info_page';
  static String about_us_admin = '/about_us_admin';
  static String about_us_user = '/about_us_user';
  static String edit_about_us_info = '/edit_about_us_info';
  static String user_list_page = '/user_list_page';
  static String rfid_band = '/rfid_band';
  static String edit_rfid_band_info = '/edit_rfid_band_info';
  static String add_rfid_band_info = '/add_rfid_band_info';
  static String login = '/login';
  static String register = '/register';
  static String loading = '/loading';
  static String root_app = '/root_app';
  static String change_userLogin = '/change_userLogin';
  static String about_us = '/about_us';
  static String send_feedback = '/send_feedback';
  static String change_userInfo = '/change_userInfo';
  static String step_count_page = '/stepCount_page';
  static String bmi_page = '/bmi_page';
  static String blood_pressure_page = '/bloodPressure_page';
  static String reset_password = '/reset_password';
  static String visceral_fat_page = '/visceralFat_page';
  static String staff_ranking_page = '/staffRanking_page';
  static String student_ranking_page = '/studentRanking_page';
  static String qr_code_result_page = '/qrResult_page';
  static String workout = '/workout';
  static String notifications = '/notifications';
}

/// Add this list variable into your GetMaterialApp as the value of getPages parameter.
/// You can get the reference to the above GetMaterialApp code.
final getPages = [
  GetPage(
    name: Routes.admin_login,
    page: () => const AdminLoginPage(),
  ),
  GetPage(
    name: Routes.admin_loading,
    page: () => const AdminLoadingPage(),
  ),
  GetPage(
    name: Routes.admin_root_app,
    page: () => const AdminRootApp(),
  ),
  GetPage(
    name: Routes.edit_user_info,
    page: () => const EditUserInfoPage(),
  ),
  GetPage(
    name: Routes.feedback,
    page: () => const FeedbackPage(),
  ),
  GetPage(
    name: Routes.view_feedback,
    page: () => const ViewFeedbackPage(),
  ),
  GetPage(
    name: Routes.claim_reward,
    page: () => const ClaimRewardPage(),
  ),
  GetPage(
    name: Routes.view_claim_reward,
    page: () => const ViewClaimRewardPage(),
  ),
  GetPage(
    name: Routes.rewards,
    page: () => const RewardsListPage(),
  ),
  GetPage(
    name: Routes.edit_reward_info,
    page: () => const EditRewardInfoPage(),
  ),
  GetPage(
    name: Routes.add_reward_info,
    page: () => const AddRewardInfoPage(),
  ),
  GetPage(
    name: Routes.checkpoint,
    page: () => const CheckpointListPage(),
  ),
  GetPage(
    name: Routes.edit_checkpoint_info,
    page: () => const EditCheckpointInfoPage(),
  ),
  GetPage(
    name: Routes.add_checkpoint_info,
    page: () => const AddCheckpointInfoPage(),
  ),
  GetPage(
    name: Routes.path,
    page: () => const PathListPage(),
  ),
  GetPage(
    name: Routes.edit_path_info,
    page: () => const EditPathInfoPage(),
  ),
  GetPage(
    name: Routes.add_path_info,
    page: () => const AddPathInfoPage(),
  ),
  GetPage(
    name: Routes.edit_path_checkpoints,
    page: () => const EditPathCheckpointsPage(),
  ),
  GetPage(
    name: Routes.checkpoint_search,
    page: () => const CheckpointSearchPage(),
  ),
  GetPage(
    name: Routes.checkpoint_qr,
    page: () => const CheckpointQrPage(),
  ),
  GetPage(
    name: Routes.set,
    page: () => const SetListPage(),
  ),
  GetPage(
    name: Routes.edit_set_info,
    page: () => const EditSetInfoPage(),
  ),
  GetPage(
    name: Routes.add_set_info,
    page: () => const AddSetInfoPage(),
  ),
  GetPage(
    name: Routes.edit_set_paths,
    page: () => const EditSetPathsPage(),
  ),
  GetPage(
    name: Routes.path_search,
    page: () => const PathSearchPage(),
  ),
  GetPage(
    name: Routes.app_info_page,
    page: () => const AppInfoFragmentScreen(),
  ),
  GetPage(
    name: Routes.about_us_admin,
    page: () => const AboutUsAdminPage(),
  ),
  GetPage(
    name: Routes.edit_about_us_info,
    page: () => const EditAboutUsInfoPage(),
  ),
  GetPage(
    name: Routes.about_us_user,
    page: () => const AboutUsUserPage(),
  ),
  GetPage(
    name: Routes.user_list_page,
    page: () => const UserListPage(),
  ),
  GetPage(
    name: Routes.rfid_band,
    page: () => const RfidBandListPage(),
  ),
  GetPage(
    name: Routes.edit_rfid_band_info,
    page: () => const EditRfidBandInfoPage(),
  ),
  GetPage(
    name: Routes.add_rfid_band_info,
    page: () => const AddRfidBandInfoPage(),
  ),
  GetPage(
    name: Routes.login,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: Routes.reset_password,
    page: () => const ResetPasswordPage(),
  ),
  GetPage(
    name: Routes.register,
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: Routes.loading,
    page: () => const LoadingPage(),
  ),
  GetPage(
    name: Routes.root_app,
    page: () => const RootApp(),
  ),
  GetPage(
    name: Routes.change_userLogin,
    page: () => const ChangeEmailPasswordPage(),
  ),
  GetPage(
    name: Routes.about_us,
    page: () => const AboutUsPage(),
  ),
  GetPage(
    name: Routes.send_feedback,
    page: () => const SendFeedbackPage(),
  ),
  GetPage(
    name: Routes.send_notification,
    page: () => const SendNotificationPage(),
  ),
  GetPage(
    name: Routes.change_userInfo,
    page: () => const ChangeUserInfoPage(),
  ),
  GetPage(
    name: Routes.step_count_page,
    page: () => const StepCountPage(),
  ),
  GetPage(
    name: Routes.bmi_page,
    page: () => const BmiPage(),
  ),
  GetPage(
    name: Routes.blood_pressure_page,
    page: () => const BloodPressurePage(),
  ),
  GetPage(
    name: Routes.visceral_fat_page,
    page: () => const VisceralFatPage(),
  ),
  GetPage(
    name: Routes.staff_ranking_page,
    page: () => const StaffRankingPage(),
  ),
  GetPage(
    name: Routes.student_ranking_page,
    page: () => const StudentRankingPage(),
  ),
  GetPage(
    name: Routes.qr_code_result_page,
    page: () => const QRCodeResultPage(),
  ),
  GetPage(
    name: Routes.workout,
    page: () => const WorkoutFragmentScreen(),
  ),
  GetPage(
    name: Routes.notifications,
    page: () => const NotificationsFragmentScreen(),
  ),
];
