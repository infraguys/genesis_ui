part of '../user_list_page.dart';

class _ConfirmEmailButton extends StatelessWidget {
  const _ConfirmEmailButton({super.key});  // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionCubit, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return ConfirmEmailElevatedButton(
          onPressed: () {
            context.read<UsersBloc>().add(UsersEvent.forceConfirmEmails(state));
          },
        );
      },
    );
  }
}
