import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/design/border_radius.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/global/widgets/custom_titled_textfield.dart';
import 'package:chat_client/src/global/widgets/responsive_two_sided_card.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:chat_client/src/utilities/responsive/responsive_parent.dart';
import 'package:chat_client/src/utilities/scaffold_utils/snackbar_util.dart';
import 'package:chat_client/src/utilities/tools/form_validator_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/login_controller.dart';
import 'authentication_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const path = "Login";
  static const route = "${AuthenticationScreen.route}/$path";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveParentWrapper(
        builder: (context, state) {
          return switch (state) {
            > ResponsiveState.sm => Center(
                child: ResponsiveTwoSidedCard(
                  leftSideWidget: SizedBox.expand(
                    child: Image.asset(
                      ImageAssets.logoDark,
                      fit: BoxFit.cover,
                    ),
                  ),
                  rightSideWidget: Padding(
                    padding: vertical24 + vertical16 + horizontal12,
                    child: const VerticalLoginArea(),
                  ),
                ),
              ),
            _ => SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: ResponsiveState.xs.max,
                    ),
                    child: const VerticalLoginArea(),
                  ),
                ),
              )
          };
        },
      ),
    );
  }
}

class VerticalLoginArea extends StatefulWidget {
  const VerticalLoginArea({super.key});

  @override
  State<VerticalLoginArea> createState() => _VerticalLoginAreaState();
}

class _VerticalLoginAreaState extends State<VerticalLoginArea> {
  bool _showPassword = false;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen(loginControllerProvider, (previous, next) {
          next.maybeWhen(
            orElse: () {},
            data: (data) {
              if (data.responseMsg != null) {
                switch (data.responseMsg!.level) {
                  case 1:
                    showToastSuccess(data.responseMsg!.msg);
                  default:
                    showToastError(data.responseMsg!.msg);
                }
                ref.read(loginControllerProvider.notifier).removeMessage();
              }
            },
            error: (error, stackTrace) => showToastError(error.toString()),
          );
        });
        final provider = ref.watch(loginControllerProvider);
        final loginState = provider.requireValue;
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: horizontal24,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Hi, Welcome Back! 👋",
                      style: context.textTheme.headlineMedium,
                    ),
                    Text(
                      "Hello again, you've been missed!",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.color.text.withOpacity(0.8),
                      ),
                    ),
                    50.height,
                    CustomTitledTextFormField(
                      title: "Email",
                      hintText: "Please Enter Your Email Address",
                      validators: [isRequired, isEmail],
                      onChange: (value) {
                        final controller = ref.read(
                          loginControllerProvider.notifier,
                        );
                        controller.setLoginMail(value);
                      },
                    ),
                    12.height,
                    CustomTitledTextFormField(
                      title: "Password",
                      hintText: "Please Enter Your Password",
                      isObscured: _showPassword,
                      validators: [isRequired, tooShort6],
                      onChange: (value) {
                        final controller = ref.read(
                          loginControllerProvider.notifier,
                        );
                        controller.setLoginPassword(value);
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(
                          (_showPassword)
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    12.height,
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: loginState.remember,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                onChanged: (value) {
                                  final controller = ref.read(
                                    loginControllerProvider.notifier,
                                  );
                                  controller.switchRememberMe();
                                },
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {
                                      final controller = ref.read(
                                        loginControllerProvider.notifier,
                                      );
                                      controller.switchRememberMe();
                                    },
                                    child: const Padding(
                                      padding: all6,
                                      child: Text(
                                        "Remember me",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              borderRadius: br8,
                              onTap: () {},
                              child: Padding(
                                padding: all6,
                                child: Text(
                                  "Forget password",
                                  style:
                                      context.textTheme.labelMedium?.copyWith(
                                    color: context.color.errorState,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    Builder(
                      builder: (context) {
                        return FilledButton(
                          onPressed: () async {
                            final formState = Form.of(context).validate();
                            if (formState) {
                              final controller = ref.read(
                                loginControllerProvider.notifier,
                              );
                              controller.attemptLogin();
                            }
                          },
                          child: provider.isLoading
                              ? const Padding(
                                  padding: vertical8,
                                  child: SizedBox.square(
                                    dimension: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : const Padding(
                                  padding: vertical8,
                                  child: Text("Login"),
                                ),
                        );
                      },
                    ),
                    18.height,
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: horizontal18,
                          child: Text(
                            "Or With",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.color.accent,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    18.height,
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Padding(
                              padding: vertical8,
                              child: SizedBox.square(
                                dimension: 24,
                                child: Padding(
                                  padding: all3,
                                  child: Image.asset(IconAssets.facebook),
                                ),
                              ),
                            ),
                            label: const Text("Facebook"),
                          ),
                        ),
                        24.width,
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Padding(
                              padding: vertical8,
                              child: SizedBox.square(
                                dimension: 24,
                                child: Padding(
                                  padding: all3,
                                  child: Image.asset(IconAssets.google),
                                ),
                              ),
                            ),
                            label: const Text("Google"),
                          ),
                        ),
                      ],
                    ),
                    32.height,
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: context.textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Register.",
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.go(RegistrationScreen.route),
                              style: TextStyle(
                                color: context.color.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
