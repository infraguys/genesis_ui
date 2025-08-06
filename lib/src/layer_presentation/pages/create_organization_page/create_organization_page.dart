import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/params/create_organization_params.dart';
import 'package:genesis/src/layer_presentation/pages/create_organization_page/blocs/organization_editor_bloc/organization_editor_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
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
    return BlocListener<OrganizationEditorBloc, OrganizationEditorState>(
      listener: (context, state) {
        if (state is OrganizationEditorStateSuccess) {
          context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
          _controllersManager.clear();
          final navigator = GoRouter.of(context);

          final snack = SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Palette.color6DCF91,
            content: Text(context.$.success),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snack)
              .closed
              .then(
                (_) => navigator.pop(),
              );
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
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      controller: _controllersManager.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: context.$.name,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.hardcoded;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      controller: _controllersManager.descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: context.$.description,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Palette.color6DCF91),
                    ),
                    onPressed: () => save(context),
                    child: Text(context.$.create),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<OrganizationEditorBloc>().add(
        OrganizationEditorEvent.createOrganization(
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

  @override
  bool get allFilled => all.every((it) => it.text.isNotEmpty);
}
