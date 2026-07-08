import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/providers/selection_provider.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(ref),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colors.primary,
      title: Text(
        "Todo",
        style: text.titleLarge!.copyWith(color: colors.onPrimary),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return navigationShell;
  }

  Widget _buildBottomBar(WidgetRef ref) {
    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );

    return isSelectionMode
        ? SizedBox.shrink()
        : BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(index);
            },

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            ],
          );
  }
}
