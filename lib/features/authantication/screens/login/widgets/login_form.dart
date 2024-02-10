import 'package:ecommerce_app/features/authantication/controllers/login/login_controller.dart';
import 'package:ecommerce_app/features/authantication/screens/password_configuration/forgetPassword.dart';
import 'package:ecommerce_app/features/authantication/screens/signup/sign_up.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailCtrl,
                validator: (value) => TValidation.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: "E-mail"),
              ),
              const SizedBox(
                height: TSizes.spaceBtwFields,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordCtrl,
                  validator: (value) =>
                      TValidation.validateEmptyText(value, 'Password'),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(
                            controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                          ))),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwFields / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberme.value,
                          onChanged: (value) => controller.rememberme.value =
                              !controller.rememberme.value)),
                      const Text('Rememeber Me')
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPasswordScreen());
                      },
                      child: const Text("Forget Password"))
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.emailandPasswordSignIn(),
                      child: const Text("SignIn"))),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => const SighnUpScreen());
                      },
                      child: const Text("Create Account")))
            ],
          ),
        ));
  }
}
