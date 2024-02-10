import 'package:ecommerce_app/features/authantication/controllers/sign_up/sign_up_controller.dart';
import 'package:ecommerce_app/features/authantication/screens/signup/widgets/terms_and_conditions.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpFormScreen extends StatelessWidget {
  const SignUpFormScreen({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                /// First And Last Name
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidation.validateEmptyText(value, 'First name'),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwFields,
                ),
                Expanded(
                  child: TextFormField(
                    validator: (value) =>
                        TValidation.validateEmptyText(value, 'Last name'),
                    controller: controller.lastName,
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
              ],
            ),

            /// User Name
            const SizedBox(
              height: TSizes.spaceBtwFields,
            ),
            TextFormField(
              validator: (value) =>
                  TValidation.validateEmptyText(value, 'Username'),
              controller: controller.userName,
              expands: false,
              decoration: const InputDecoration(
                  labelText: "User Name", prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwFields,
            ),

            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidation.validateEmail(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: "email", prefixIcon: Icon(Iconsax.direct)),
            ),

            /// Phone Number
            const SizedBox(
              height: TSizes.spaceBtwFields,
            ),
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => TValidation.validatePhoneNumer(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: "Phone Number", prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwFields,
            ),

            /// Password
            Obx(() => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidation.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(
                            controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                          ))),
                )),
            const SizedBox(
              height: TSizes.spaceBtwFields,
            ),

            /// Terms & COnditions

            TermsAndConditions(dark: dark),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Sigh up button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signUp(),
                  child: const Text("Created Account")),
            ),
          ],
        ));
  }
}
