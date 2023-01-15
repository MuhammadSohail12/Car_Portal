import 'package:car_portal/Bloc/car_crud/car_crud_bloc.dart';
import 'package:car_portal/Bloc/sign_in/sign_in_bloc.dart';
import 'package:car_portal/Bloc/sign_up/sign_up_bloc.dart';
import 'package:car_portal/Models/usermodel.dart';
import 'package:car_portal/View/authentication/signin_view.dart';
import 'package:car_portal/View/car_dashboad/car_dashboard_crud.dart';
import 'package:car_portal/services/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // initialization of bloc to access all over the app
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CarCrudBloc(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,

        // home: SignInView(),
        home: CheckUserSession(),
      ),
    );
  }
}

class CheckUserSession extends StatefulWidget {
  const CheckUserSession({Key? key}) : super(key: key);

  @override
  State<CheckUserSession> createState() => _CheckUserSessionState();
}

class _CheckUserSessionState extends State<CheckUserSession> {
  @override
  void initState() {
    super.initState();
    checkUserSession();
  }

  Future<void> checkUserSession() async {
    SembastDb db = SembastDb();
    await db.init();

    await db.session().then((value) {
      setState(() {
        print(value);
        userAvailable = value;
      });
    });
  }

  dynamic userAvailable;

  Widget build(BuildContext context) {
    return Scaffold(
      body: userAvailable == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userAvailable
              ? const CarDashboardView()
              : const SignInView(),
    );
  }
}
