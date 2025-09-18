part of '../user_list_page.dart';

class _ConfirmEmailButton extends StatelessWidget {
  const _ConfirmEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionBloc, List<User>>(
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
