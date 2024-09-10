import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/features/authentication/controllers/registration_controller.dart';
import 'package:chat_client/src/global/widgets/custom_titled_textfield.dart';
import 'package:chat_client/src/global/widgets/image_button_avatar.dart';
import 'package:chat_client/src/global/widgets/responsive_two_sided_card.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:chat_client/src/utilities/responsive/responsive_parent.dart';
import 'package:chat_client/src/utilities/scaffold_utils/snackbar_util.dart';
import 'package:chat_client/src/utilities/tools/form_validator_helper.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'authentication_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  static const path = "Registration";
  static const route = "${AuthenticationScreen.route}/$path";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveParentWrapper(builder: (context, currentState) {
        return switch (currentState) {
          > ResponsiveState.sm => Center(
              child: ResponsiveTwoSidedCard(
                leftSideWidget: const LeftSideRegistrationPart(),
                rightSideWidget: Padding(
                  padding: vertical24 + vertical16 + horizontal12,
                  child: const VerticalRegistrationArea(
                    showForSinglePart: true,
                  ),
                ),
              ),
            ),
          _ => SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveState.xs.max,
                  ),
                  child: const VerticalRegistrationArea(
                    showForSinglePart: false,
                  ),
                ),
              ),
            ),
        };
      }),
    );
  }
}

class VerticalRegistrationArea extends StatefulWidget {
  const VerticalRegistrationArea({
    super.key,
    required this.showForSinglePart,
  });

  final bool showForSinglePart;

  @override
  State<VerticalRegistrationArea> createState() =>
      _VerticalRegistrationAreaState();
}

class _VerticalRegistrationAreaState extends State<VerticalRegistrationArea> {
  late final nameController = TextEditingController();
  late final emailController = TextEditingController();
  late final phoneController = TextEditingController();
  late final passwordController = TextEditingController();
  late final confirmPasswordController = TextEditingController();

  late final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, child) {
          ref.listen(registrationControllerProvider, (previous, next) {
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
                  ref
                      .read(registrationControllerProvider.notifier)
                      .removeMessage();
                }
              },
              error: (error, stackTrace) => showToastError(error.toString()),
            );
          });
          final provider = ref.watch(registrationControllerProvider);
          final registrationState = provider.requireValue;
          return SingleChildScrollView(
            child: Padding(
              padding: horizontal24,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!widget.showForSinglePart) ...[
                      32.height,
                      Text(
                        "Create an account!",
                        style: context.textTheme.headlineMedium,
                      ),
                      Text(
                        "Let's connect you to the whole world.",
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.color.text.withOpacity(0.8),
                        ),
                      ),
                      25.height,
                    ],
                    Center(
                      child: ImageAvatarWithButton(
                        assetPath: ImageAssets.profile,
                        filePath: registrationState.imagePath?.imageData,
                        onAddClick: () async {
                          final picker = ImagePicker();
                          final res = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (res != null) {
                            final imageName = res.path.split("/").last;
                            final fileData = await res.readAsBytes();
                            ref
                                .read(
                                  registrationControllerProvider.notifier,
                                )
                                .setImagePath(imageName, fileData.toList());
                          }
                        },
                      ),
                    ),
                    25.height,
                    CustomTitledTextFormField(
                      title: "Full Name",
                      hintText: "Please Enter Your Full Name",
                      validators: [isRequired],
                      controller: nameController,
                      onChange: (value) => ref
                          .read(registrationControllerProvider.notifier)
                          .setName(value),
                    ),
                    12.height,
                    CustomTitledTextFormField(
                      title: "Email",
                      hintText: "Please Enter Your Email Address",
                      validators: [isRequired, isEmail],
                      controller: emailController,
                      onChange: (value) => ref
                          .read(registrationControllerProvider.notifier)
                          .setMail(value),
                    ),
                    12.height,
                    CustomTitledTextFormField(
                      title: "Phone",
                      hintText: "Enter Your Phone Number",
                      validators: [
                        isRequired,
                        tooShort10,
                      ],
                      controller: phoneController,
                      onChange: (value) => ref
                          .read(registrationControllerProvider.notifier)
                          .setPhoneNumber(value),
                      prefixIcon: IntrinsicWidth(
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    showCountryPicker(
                                      context: context,
                                      useSafeArea: true,
                                      showPhoneCode: true,
                                      onSelect: (value) {
                                        ref
                                            .read(
                                              registrationControllerProvider
                                                  .notifier,
                                            )
                                            .setPhoneCode(
                                              "+${value.phoneCode}",
                                            );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      12.width,
                                      Text(registrationState.phoneCode),
                                      3.width,
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                indent: 6,
                                endIndent: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    12.height,
                    CustomTitledTextFormField(
                      title: "Password",
                      hintText: "Please Enter Your Password",
                      isObscured: registrationState.passwordVisibility,
                      validators: [isRequired, tooShort6],
                      controller: passwordController,
                      onChange: (value) => ref
                          .read(registrationControllerProvider.notifier)
                          .setPassword(value),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref
                              .read(
                                registrationControllerProvider.notifier,
                              )
                              .switchPasswordVisibility();
                        },
                        icon: Icon(
                          (registrationState.passwordVisibility)
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    12.height,
                    CustomTitledTextFormField(
                      title: "Confirm Password",
                      hintText: "Please Re-Enter Your Password",
                      isObscured: registrationState.passwordVisibility,
                      validators: [
                        isRequired,
                        tooShort6,
                        (value, name) => (
                              value != passwordController.text,
                              "$name doesn't match with Password!"
                            ),
                      ],
                      controller: confirmPasswordController,
                      onChange: (value) => ref
                          .read(registrationControllerProvider.notifier)
                          .setConfirmedPassword(value),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref
                              .read(
                                registrationControllerProvider.notifier,
                              )
                              .switchPasswordVisibility();
                        },
                        icon: Icon(
                          (registrationState.passwordVisibility)
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    16.height,
                    Builder(builder: (context) {
                      return FilledButton(
                        onPressed: () {
                          final formValid = Form.of(context).validate();
                          if (formValid) {
                            final controller = ref.read(
                              registrationControllerProvider.notifier,
                            );
                            controller.attemptRegistration();
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
                                child: Text(
                                  "Sign Up",
                                ),
                              ),
                      );
                    }),
                    if (!widget.showForSinglePart) ...[
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
                            text: "Already have an account? ",
                            style: context.textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "Login.",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.go(LoginScreen.route),
                                style: TextStyle(
                                  color: context.color.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      32.height,
                    ],
                    if (widget.showForSinglePart) 100.height,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LeftSideRegistrationPart extends StatelessWidget {
  const LeftSideRegistrationPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            ImageAssets.logoDark,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox.expand(
          child: ColoredBox(
            color: Colors.white38,
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    32.height,
                    Text(
                      "Create an account!",
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: context.color.opposite,
                      ),
                    ),
                    Text(
                      "Start a organized life today.",
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.color.opposite,
                      ),
                    ),
                    25.height,
                  ],
                ),
              ),
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
                        color: context.color.secondaryText,
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
                            child: Image.asset(IconAssets.logoDarkSVG),
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
                            child: Image.asset(IconAssets.logoDarkSVG),
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
                    text: "Already have an account? ",
                    style: context.textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Login.",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go(LoginScreen.route),
                        style: TextStyle(
                          color: context.color.secondBatch,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              48.height,
            ],
          ),
        ),
      ],
    );
  }
}
