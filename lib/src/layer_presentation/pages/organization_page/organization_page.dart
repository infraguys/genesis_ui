import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_blocs/organization_editor_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({required this.organization, super.key});

  final Organization organization;

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    _controllersManager = _ControllersManager(widget.organization);
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
          context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
          _controllersManager.clear();
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
                BreadcrumbItem(text: widget.organization.name),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
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
                      minLines: 2,
                      maxLines: null,
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
                    child: Text(context.$.update),
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
      context.read<OrganizationBloc>().add(
        OrganizationEvent.updateOrganization(
          UpdateOrganizationParams(
            uuid: widget.organization.uuid,
            name: _controllersManager.nameController.text,
            description: _controllersManager.descriptionController.text,
          ),
        ),
      );
    }
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(Organization organization)
    : nameController = TextEditingController(text: organization.name),
      descriptionController = TextEditingController(text: organization.description);

  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  List<TextEditingController> get all => [nameController, descriptionController];

  @override
  bool get allFilled => all.every((it) => it.text.isNotEmpty);
}
