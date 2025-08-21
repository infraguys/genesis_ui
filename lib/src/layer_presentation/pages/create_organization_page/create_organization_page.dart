import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class CreateOrganizationPage extends StatefulWidget {
  const CreateOrganizationPage({super.key});

  @override
  State<CreateOrganizationPage> createState() => _CreateOrganizationPageState();
}

class _CreateOrganizationPageState extends State<CreateOrganizationPage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    _controllersManager = _ControllersManager();
    super.initState();
  }

  @override
  void dispose() {
    _controllersManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizationBloc, OrganizationState>(
      listener: (context, state) {
        if (state is OrganizationStateSuccess) {
          _controllersManager.clear();
          context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
          final navigator = GoRouter.of(context);
          final snack = SnackBar(
            duration: const Duration(milliseconds: 500),
            backgroundColor: Palette.color6DCF91,
            content: Text(context.$.success),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack).closed.then((_) => navigator.pop());
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.organizations),
                BreadcrumbItem(text: context.$.create),
              ],
            ),
            ButtonsBar(
              children: [
                SaveIconButton(onPressed: () => save(context)),
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        AppTextInput(
                          controller: _controllersManager.nameController,
                          hintText: context.$.name,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        AppTextInput.multiLine(
                          controller: _controllersManager.descriptionController,
                          hintText: context.$.description,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<OrganizationBloc>().add(
        OrganizationEvent.create(
          CreateOrganizationParams(
            name: _controllersManager.nameController.text,
            description: _controllersManager.descriptionController.text,
          ),
        ),
      );
    }
  }
}

class _ControllersManager extends FormControllersManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  List<TextEditingController> get all => [nameController, descriptionController];
}
