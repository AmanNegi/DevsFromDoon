import 'package:lpu_events/core/auth/application/auth.dart';
import 'package:lpu_events/core/home/presentation/home_page.dart';
import 'package:lpu_events/widgets/loading_widget.dart';

import '/globals.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late AuthManager _authManager;
  String email = "", password = "";

  @override
  void initState() {
    _authManager = AuthManager(context, ref);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: ValueNotifier(false),
      child: _buildLoginPage(context),
    );
  }

  SingleChildScrollView _buildLoginPage(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Image.asset(
            "assets/logo_app.png",
            height: 100,
            width: 100,
          ),
          SizedBox(height: 0.025 * getHeight(context)),
          const Center(
            child: Text(
              "LPU Events",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              "Simplify Events, Amplify Experience",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 0.025 * getHeight(context)),
          CustomTextField(
            value: email,
            onChanged: (v) => email = v,
            label: "UMS ID",
          ),
          const SizedBox(height: 10),
          CustomTextField(
            value: password,
            isPassword: true,
            onChanged: (v) => password = v,
            label: "UMS Password",
          ),
          SizedBox(height: 0.3 * getHeight(context)),
          ActionButton(
            isFilled: true,
            onPressed: () async {
              return goToPage(context, const HomePage(), clearStack: true);
              // if (email.trim().isEmpty) {
              //   showToast("Enter a valid email");
              //   return;
              // }

              // if (password.trim().isEmpty) {
              //   showToast("Enter a valid password");
              //   return;
              // }

              // var res = await _authManager.loginUsingEmailPassword(
              //   email: email.trim(),
              //   password: password.trim(),
              // );

              // if (res == 1 && mounted) {
              //   // goToPage(context, const RolePage(), clearStack: true);
              // }
            },
            text: "Log in",
          ),
          SizedBox(height: 0.015 * getHeight(context)),
          GestureDetector(
            // onTap: () => goToPage(
            //   context,
            //   const SignUpPage(),
            //   clearStack: true,
            // ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(
                    text: "Want to host your event?\n",
                  ),
                  TextSpan(
                    text: " Request for access",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
