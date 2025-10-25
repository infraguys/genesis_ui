part of '../user_list_page.dart';

class _DeleteUserButton extends StatelessWidget {
  const _DeleteUserButton({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionBloc, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return DeleteElevatedButton(
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => DeleteUsersDialog.multiple(
                users: state,
                onDelete: () => context.read<UsersBloc>().add(UsersEvent.deleteUsers(state)),
              ),
            );
          },
        );
      },
    );
  }
}
