// lib/screens/home/widgets/home_search_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/providers/selection_provider.dart';

class HomeSearchSection extends ConsumerWidget {
  final bool typeSelected;
  final bool isSearching, isSearchingCompleted;
  final SearchController searchController, searchControllerCompleted;
  final Function({
    required String keyword,
    required SearchController controller,
  })
  onSearchButtonPressed;
  final Function(SearchController) onClearSearchButtonPressed;

  const HomeSearchSection({
    super.key,
    required this.typeSelected,
    required this.isSearching,
    required this.isSearchingCompleted,

    required this.searchController,
    required this.searchControllerCompleted,
    required this.onSearchButtonPressed,
    required this.onClearSearchButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = context.text;
    final colors = context.colors;
    final width = context.width;
    final height = context.height;
    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );
    final controller = typeSelected
        ? searchControllerCompleted
        : searchController;
    final isSearchingUsed = typeSelected ? isSearchingCompleted : isSearching;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.05,
            0,
            width * 0.05,
            height * 0.015,
          ),
          child: IgnorePointer(
            ignoring: isSelectionMode,
            child: SearchAnchor(
              searchController: controller,
              viewOnSubmitted: (_) {
                onSearchButtonPressed(
                  keyword: controller.text.trim(),
                  controller: controller,
                );
              },
              builder: (BuildContext context, _) {
                return SearchBar(
                  controller: controller,
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.fromLTRB(width * 0.02, 0, width * 0.02, 0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  textInputAction: TextInputAction.search,
                  hintText: "Enter content...",
                  hintStyle: WidgetStatePropertyAll(
                    text.labelLarge!.copyWith(color: colors.onSurfaceVariant),
                  ),
                  textStyle: WidgetStatePropertyAll(
                    text.labelLarge!.copyWith(color: colors.onSurface),
                  ),
                  trailing: isSearchingUsed
                      ? <Widget>[
                          IconButton(
                            onPressed: () {
                              onClearSearchButtonPressed(controller);
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ]
                      : null,
                );
              },
              suggestionsBuilder: (BuildContext context, _) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      onSearchButtonPressed(
                        keyword: item,
                        controller: controller,
                      );
                    },
                  );
                });
              },
            ),
          ),
        ),
        if (isSelectionMode)
          Positioned.fill(
            child: Container(
              color: colors.primaryContainer.withValues(alpha: 0.95),
            ),
          ),
      ],
    );
  }
}
