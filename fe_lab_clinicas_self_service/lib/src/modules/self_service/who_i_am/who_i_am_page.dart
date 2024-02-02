import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

class _WhoIAmPageState extends State<WhoIAmPage> {
  final selfServiceController = Injector.get<SelfServiceController>();

  final formKey = GlobalKey<FormState>();

  final fistNameEC = TextEditingController();
  final lastNameEC = TextEditingController();

  @override
  void dispose() {
    fistNameEC.dispose();
    lastNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {
        fistNameEC.text = '';
        lastNameEC.text = '';
        selfServiceController.clearForm();
      }),
      child: Scaffold(
        appBar: LabClinicasAppBar(
          actions: [
            PopupMenuButton(
              child: const IconPopupMenuWidget(),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Finalizar Terminal'),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 1) {
                  final nav = Navigator.of(context);
                  await SharedPreferences.getInstance().then((sp) => sp.clear());
                  nav.pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
            )
          ],
        ),
        body: LayoutBuilder(builder: (_, constrains) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_login.png',
                ),
                fit: BoxFit.cover,
              )),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  constraints: BoxConstraints(maxWidth: sizeOf.width * .8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo_vertical.png'),
                        const SizedBox(
                          height: 48,
                        ),
                        const Text(
                          'Bem Vindo!',
                          style: LabClinicasTheme.titleStyle,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        TextFormField(
                          controller: fistNameEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Nome Obrigatório'),
                            // Validatorless.email('Email inválido')
                          ]),
                          decoration: const InputDecoration(
                              label: Text('Digite seu nome')),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          // obscureText: controller.obscurePassword,
                          controller: lastNameEC,
                          decoration: InputDecoration(
                            label: const Text('Digite seu sobrenome'),
                            // suffixIcon: IconButton(
                            //   onPressed: () {
                            //     controller.passwordToggle();
                            //   },
                            //   icon: controller.obscurePassword
                            //       ? const Icon(Icons.visibility)
                            //       : const Icon(Icons.visibility_off),
                            // ),
                          ),
                          validator:
                              Validatorless.required('Sobrenome Obrigatório'),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          width: sizeOf.width * .8,
                          height: 48,
                          child: ElevatedButton(
                              onPressed: () {
                                final valid =
                                    formKey.currentState?.validate() ?? false;
                                if (valid) {
                                  selfServiceController
                                      .setWhiIAmDatastepAndNext(
                                          fistNameEC.text, lastNameEC.text);
                                }
                              },
                              child: const Text('CONTINUAR')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
