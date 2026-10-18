import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../providers/task_list_summary.dart';
import 'list_summary_card.dart';
import 'new_list_card.dart';

/// The adaptive grid of list summary cards, terminated by the new-list tile.
class ListsGrid extends StatelessWidget {
  /// Creates the lists grid.
  const ListsGrid({
    required this.summaries,
    required this.onOpenList,
    required this.onCreateList,
    super.key,
  });

  /// The lists to render.
  final List<TaskListSummary> summaries;

  /// Called when a list card is tapped.
  final ValueChanged<TaskListSummary> onOpenList;

  /// Called when the new-list tile is tapped.
  final VoidCallback onCreateList;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        const gap = AnjizSpacing.md12;
        final columns = box.maxWidth >= 720 ? 3 : 2;
        final itemWidth = (box.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < summaries.length; i++)
              SizedBox(
                width: itemWidth,
                child: ListSummaryCard(
                  summary: summaries[i],
                  featured: i == 0,
                  onTap: () => onOpenList(summaries[i]),
                ),
              ),
            SizedBox(
              width: itemWidth,
              child: NewListCard(onTap: onCreateList),
            ),
          ],
        );
      },
    );
  }
}
