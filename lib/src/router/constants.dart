const String root = '/';
const String loginWithMail = '/loginWithMail';
const String loginWithPhone = '/loginWithPhone';
const String otpWithPhone = '$loginWithPhone/otpWithPhone';
const String forgotPassword = '$loginWithMail/forgotPassword';
const String otpWithMail = '$forgotPassword/otpWithMail';
const String newPassword = '$forgotPassword/newPassword';
const String passwdChanged = '$loginWithMail/passwdChanged';
const String registerWithPhone = '$loginWithPhone/registerWithPhone';
const String registerWithOtp = '$registerWithPhone/registerWithOtp';
const String registerWithMail = '$loginWithMail/registerWithMail';

// TODO: Configure root
const String detectingLocation = '/detectingLocation';
const String detectedLocation = '/detectedLocation';
const String manualLocation = '/manualLocation';

// List Place
const String listPlace = '/listPlace';

// Home Route
const String home = '/home';
const String insights = '$home/insights';

// Pages Route
const String menu = '$home/menu';
const String addFoodPlace = '$home/addFoodPlace';
const String coverImage = '$menu/coverImage';
const String modifyItem = '$menu/modifyItem';
const String addNewItem = '$menu/addNewItem';
const String addNewCategory = '$addNewItem/addNewCategory';

// Settings Route
const String profile = '$home/profile';
const String myProfile = '$profile/myProfile';
const String help = '$profile/help';
const String feedback = '$profile/feedback';
const String settings = '$profile/settings';
const String aboutUs = '$profile/aboutUs';
const String ourStory = '$aboutUs/ourStory';
const String ourValue = '$aboutUs/ourValue';
const String ourMission = '$aboutUs/ourMission';
const String ourTeam = '$aboutUs/ourTeam';
const String suggestPlace = '$profile/suggestPlace';
