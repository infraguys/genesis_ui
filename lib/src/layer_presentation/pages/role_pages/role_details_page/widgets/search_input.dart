part of '../role_details_page.dart';

class _SearchInput extends StatefulWidget {
  const _SearchInput({super.key}); // ignore: unused_element_parameter

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchInput(
      controller: _controller,
      onChanged: (value) {
        context.read<PermissionsBloc>().add(PermissionsEvent.search(value));
      },
    );
  }
}
