import 'package:car_portal/Bloc/car_crud/car_crud_bloc.dart';
import 'package:car_portal/Constant/constant.dart';
import 'package:car_portal/Models/carmodel.dart';
import 'package:car_portal/My%20Widgets/app_button.dart';
import 'package:car_portal/My%20Widgets/app_form_field.dart';
import 'package:car_portal/main.dart';
import 'package:car_portal/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDashboardView extends StatefulWidget {
  const CarDashboardView({Key? key}) : super(key: key);

  @override
  State<CarDashboardView> createState() => _CarDashboardViewState();
}

class _CarDashboardViewState extends State<CarDashboardView> {
  final TextEditingController _color = TextEditingController();
  final TextEditingController _make = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _registerationNumber = TextEditingController();
  final TextEditingController _updatedColor = TextEditingController();
  final TextEditingController _updatedMake = TextEditingController();
  final TextEditingController _updatedModel = TextEditingController();
  final TextEditingController _updatedRegisterationNumber =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CarCrudBloc>(context).add(CarDataLoadEvent());
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          creatSheet(context);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Car DashBoard",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SembastDb db = SembastDb();
                await db.allDeletedCarData();
               await db.deleteAll().then((value) {

                  Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const CheckUserSession()),
                      (route) => false);
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 22,
              ))
        ],
      ),
      body: BlocConsumer(
        bloc: BlocProvider.of<CarCrudBloc>(context),
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is CarDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CarDataLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Total Registered Car",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          state.totalCars.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.carModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = state.carModel[index];
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Make  :${data.make}",
                                        style: Constant.text1,
                                      ),
                                      Text("Model :${data.model}",
                                          style: Constant.text1),
                                      Text(
                                          "Registeration Number : ${data.registerationNumber} ",
                                          style: Constant.text1),
                                      Text("Color : ${data.color}",
                                          style: Constant.text1),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // code to handle editing item

                                  editSheet(context, data);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<CarCrudBloc>(context).add(
                                      CarDataDeleted(deletedCarData: data));
                                  // code to handle deleting item
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }

  creatSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Make",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _make,
                        hint: "Toyota,Honda",
                        validator: (v) {
                          return Constant.makeValidator(v);
                        },
                      ),
                      const Text(
                        "Model",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _model,
                        hint: "ABC-1234,DEF-5678",
                        // keyboardType: TextInputType.number,
                        validator: (v) {
                          return Constant.modelNumberValidator(v);
                        },
                      ),
                      const Text(
                        "Registeration Number",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _registerationNumber,
                        hint: "AB12CD3456,ZZ99YY7890",
                        validator: (v) {
                          return Constant.registerationNumberValidator(v);
                        },
                      ),
                      const Text(
                        "Color",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _color,
                        hint: "black,red,",
                        validator: (v) {
                          return Constant.carColorValidation(v);
                        },
                      ),
                      AppButton(
                        title: "Create",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        isBlack: true,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<CarCrudBloc>(context).add(
                                CarDataInsert(
                                    make: _make.text.trim(),
                                    model: _model.text.trim(),
                                    registeration:
                                        _registerationNumber.text.trim(),
                                    color: _color.text.trim()));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  editSheet(BuildContext context, CarModel data) {
    _updatedMake.text = data.make.toString();
    _updatedModel.text = data.model.toString();
    _updatedRegisterationNumber.text = data.registerationNumber.toString();
    _updatedColor.text = data.color.toString();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Make",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _make,
                        hint: "Toyota,Honda",
                        validator: (v) {
                          return Constant.makeValidator(v);
                        },
                      ),
                      const Text(
                        "Model",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _model,
                        hint: "ABC-1234,DEF-5678",
                        // keyboardType: TextInputType.number,
                        validator: (v) {
                          return Constant.modelNumberValidator(v);
                        },
                      ),
                      const Text(
                        "Registeration Number",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _registerationNumber,
                        hint: "AB12CD3456,ZZ99YY7890",
                        validator: (v) {
                          return Constant.registerationNumberValidator(v);
                        },
                      ),
                      const Text(
                        "Color",
                        style: Constant.selectedStyle,
                      ),
                      AppFormField(
                        controller: _color,
                        hint: "black,red,",
                        validator: (v) {
                          return Constant.carColorValidation(v);
                        },
                      ),
                      AppButton(
                        title: "Update",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        isBlack: true,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<CarCrudBloc>(context)
                                .add(CarDataUpdated(updatedCarData: data));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
