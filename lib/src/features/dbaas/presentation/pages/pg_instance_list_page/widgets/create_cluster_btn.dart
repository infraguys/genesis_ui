part of '../cluster_list_page.dart';

class _CreateClusterButton extends StatelessWidget {
  const _CreateClusterButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return CreateIconButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          builder: (context) => Dialog(child: CreateClusterDialog()),
        );
      },
    );
  }
}
