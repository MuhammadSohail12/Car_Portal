import 'dart:developer';

import 'package:car_portal/Bloc/sign_in/sign_in_bloc.dart';
import 'package:car_portal/Constant/constant.dart';
import 'package:car_portal/My%20Widgets/app_button.dart';
import 'package:car_portal/My%20Widgets/app_form_field.dart';
import 'package:car_portal/View/authentication/signup_view.dart';
import 'package:car_portal/View/car_dashboad/car_dashboard_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer(
          bloc: BlocProvider.of<SignInBloc>(context),
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignInSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CarDashboardView()));
            }
          },
          builder: (context, state) {
            if (state is SignInInitial) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text "Car Portal Login"

                    const Text(
                      "Car Portal Login",
                      style: Constant.text,
                    ),

                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              isPasswordField: true,
                              validator: (v) {
                                return Constant.passwordValidator(v);
                              },
                            ),
                            //button
                            AppButton(
                              title: "Login",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0,
                              isBlack: true,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {

                                  BlocProvider.of<SignInBloc>(context).add(TheSignInEvent(email: _emailController.text.trim(), password: _passwordController.text.trim()));

                                }
                              },
                            ),
                            // dont have account or create account
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don`t have an account? "),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpView()));
                                    },
                                    child: const Text(
                                      " Register here",
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
