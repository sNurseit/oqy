import 'package:auto_route/auto_route.dart';
import  'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/register_model.dart';

@RoutePage() 
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body:Center(
          child: _FormWidget.create()
      )
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key});

  static Widget create(){
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(), 
      child: const _FormWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Consumer<RegisterModel>(
          builder: (myContext, model, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (model.openBottomSheet) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: myContext,
                  builder: (modalContext) {
                    return Container(
                      padding: const EdgeInsets.all(20.0),
                      height: MediaQuery.of(modalContext).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Verification Code',
                            ),
                            controller: model.codeTextController,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => model.verifyConfirmationCode(context),
                            child: const Text('Verify'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            });
      
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'First name',
                    ),
                    controller: model.firstnameTextController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Last name',
                    ),
                    controller: model.lastnameTextController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    controller: model.emailTextController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    controller: model.passwordTextController,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                    ),
                    controller: model.dateOfBirthTextController,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        model.setDateOfBirth(selectedDate);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => model.register(),
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20),
                  if (model.isLoading) const CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
    
    );
  }
}