import 'package:car_portal/Bloc/sign_up/sign_up_bloc.dart';
import 'package:car_portal/Constant/constant.dart';
import 'package:car_portal/My%20Widgets/app_button.dart';
import 'package:car_portal/My%20Widgets/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signin_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer(
          bloc: BlocProvider.of<SignUpBloc>(context),
          listener: (context, state) {
            // TODO: implement listener

            if (state is SignupSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignInView()));
            }
          },
          builder: (context, state) {
            if (state is SignUpInitial) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text "Car Portal Login"

                    const Text(
                      "Car Portal SignUp",
                      style: Constant.text,
                    ),

                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "UserName",
                              style: Constant.selectedStyle,
                            ),
                            //Textfield
                            AppFormField(
                              controller: _userNameController,
                              validator: (v) {
                                return Constant.userNameValidator(v);
                              },
                            ),
                            const Text(
                              "PhoneNumber",
                              style: Constant.selectedStyle,
                            ),
                            //Textfield
                            AppFormField(
                              controller: _phoneNumberController,
                              validator: (v) {
                                return Constant.phoneNumberValidator(v);
                              },
                              keyboardType: TextInputType.phone,
                            ),
                            const Text(
                              "Email",
                              style: Constant.selectedStyle,
                            ),
                            //Textfield
                            AppFormField(
                              controller: _emailController,
                              validator: (v) {
                                return Constant.emailValidator(v);
                              },
                            ),

                            const Text(
                              "Password",
                              style: Constant.selectedStyle,
                            ),
                            AppFormField(
                              controller: _passwordController,
                              validator: (v) {
                                return Constant.passwordValidator(v);
                              },
                              isPasswordField: true,
                            ),
                            const Text(
                              " confirm Password",
                              style: Constant.selectedStyle,
                            ),
                            AppFormField(
                              controller: _confirmPasswordController,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return Constant.passwordValidator(v);
                                } else if (_confirmPasswordController.text !=
                                    _passwordController.text) {
                                  return "Password does not match";
                                }
                              },
                              isPasswordField: true,
                            ),
                            //button
                            AppButton(
                                title: "SignUp",
                                fontWeight: FontWeight.w600,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<SignUpBloc>(context).add(
                                        TheSignUpEvent(
                                            userName: _userNameController.text,
                                            phoneNumber: int.parse(
                                                _phoneNumberController.text),
                                            email: _emailController.text,
                                            password: _confirmPasswordController
                                                .text));
                                  }
                                },
                                fontSize: 17.0,
                                isBlack: true),
                            // dont have account or create account
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already Have account? "),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      " Login Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
