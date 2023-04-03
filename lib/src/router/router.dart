import 'package:flutter/material.dart' show MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../screens/home/home.dart';
import '../screens/location/location_screen.dart';
import '../screens/onboarding/forgot_passwd.dart';
import '../screens/onboarding/list_place.dart';
import '../screens/onboarding/login_with_mail.dart';
import '../screens/onboarding/login_with_phone.dart';
import '../screens/onboarding/new_password.dart';
import '../screens/onboarding/onboarding.dart';
import '../screens/onboarding/otp_with_mail.dart';
import '../screens/onboarding/otp_with_phone.dart';
import '../screens/onboarding/password_changed.dart';
import '../screens/onboarding/register_with_mail.dart';
import '../screens/onboarding/register_with_otp.dart';
import '../screens/onboarding/register_with_phone.dart';
import '../screens/pages/add_food_place.dart';
import '../screens/pages/insights.dart';
import '../screens/pages/menu.dart';
import '../screens/pages/add_new_item.dart';
import '../screens/pages/modify_item.dart';
import '../screens/settings/feedback.dart';
import '../screens/settings/help_about.dart';
import '../screens/settings/edit_profile.dart';
import '../screens/settings/profile.dart';
import '../screens/settings/suggest_place.dart';
import '../screens/settings/about.dart';
import '../screens/settings/settings.dart';
import '../style/transitions.dart';
import 'constants.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Onboarding(),
      redirect: (context, GoRouterState state) async {
        bool token = await context.read<TokenProvider>().doesTokenExists();
        if (token) {
          // Enter initial location here to test
          // Overrider token not initialzed error
          return home;
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: 'loginWithMail',
          builder: (context, state) => const LoginWithMail(),
          routes: [
            GoRoute(
              path: 'forgotPassword',
              builder: (context, state) => const ForgotPassword(),
              routes: [
                GoRoute(
                  path: 'otpWithMail',
                  builder: (context, state) => const OTPWithMail(),
                ),
                GoRoute(
                  path: 'newPassword',
                  builder: (context, state) => const NewPassword(),
                ),
              ],
            ),
            GoRoute(
              path: 'passwdChanged',
              builder: (context, state) => const PasswordChanged(),
            ),
            GoRoute(
              path: 'registerWithMail',
              builder: (context, state) => const RegisterWithMail(),
            ),
          ],
        ),
        GoRoute(
          path: 'loginWithPhone',
          builder: (context, state) => const LoginWithPhone(),
          routes: [
            GoRoute(
              path: 'otpWithPhone',
              builder: (context, state) => const OTPWithPhone(),
            ),
            GoRoute(
              path: 'registerWithPhone',
              builder: (context, state) => const RegisterWithPhone(),
              routes: [
                GoRoute(
                  path: "registerWithOtp",
                  builder: (context, state) => const RegisterWithOTP(),
                )
              ],
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/location',
      pageBuilder: (context, state) =>
          const MaterialPage(fullscreenDialog: true, child: LocationScreen()),
    ),

    GoRoute(
      path: '/listPlace',
      builder: (context, state) => const ListPlace(),
    ),

    // Home
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          FadeTransitionPage(key: state.pageKey, child: const Home()),
      redirect: (context, GoRouterState state) async {
        final listPlaceProvider = context.read<ListPlaceProvider>();
        await listPlaceProvider.getListPlace();
        if (listPlaceProvider.listPlaceModel?.status == null) {
          return listPlace;
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: 'addFoodPlace',
          builder: (context, state) => const AddFoodPlace(),
        ),
        GoRoute(
          path: 'menu',
          builder: (context, state) => const Menu(),
          routes: [
            GoRoute(
              path: 'coverImage',
              pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true, child: CoverImage()),
            ),
            // Modify Item takes a MenuItem object & menuCategory String
            // to create Modify Item Page
            GoRoute(
              path: 'modifyItem',
              pageBuilder: (context, state) {
                assert(state.extra is MenuItem);
                assert(state.queryParams['category'] != null);
                MenuItem menuItem = state.extra as MenuItem;
                return MaterialPage(
                  fullscreenDialog: true,
                  child: ModifyItem(
                      menuItem: menuItem,
                      menuCategory: state.queryParams['category']!),
                );
              },
            ),

            GoRoute(
              path: 'addNewItem',
              pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true, child: AddNewItem()),
              routes: [
                GoRoute(
                  path: 'addNewCategory',
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: AddNewCategory()),
                ),
              ],
            ),
          ],
        ),

        // Insights
        GoRoute(
          path: 'insights',
          builder: (context, state) => const Insights(),
          routes: [
            GoRoute(
              path: 'details',
              pageBuilder: (context, state) {
                assert(state.extra is Rate);
                return MaterialPage(
                  fullscreenDialog: true,
                  child: ReviewDetails(rate: state.extra as Rate),
                );
              },
            ),
          ],
        ),

        // Settings
        GoRoute(
          path: 'profile',
          builder: (context, state) => const Profile(),
          routes: [
            GoRoute(
              path: 'myProfile',
              builder: (context, state) => const EditProfile(),
            ),
            GoRoute(
              path: 'suggestPlace',
              builder: (context, state) => const SuggestPlace(),
            ),
            GoRoute(
              path: 'help',
              builder: (context, state) => const HelpAbout(),
            ),
            GoRoute(
              path: 'feedback',
              builder: (context, state) => const Feedback(),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => const Settings(),
            ),
            GoRoute(
              path: 'aboutUs',
              builder: (context, state) => const About(),
            ),
          ],
        ),
      ],
    ),
  ],
);
