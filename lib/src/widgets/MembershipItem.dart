import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef TaskGetter<T, V> = V Function(T value);

class TaskCard extends StatelessWidget {
  final GlobalKey backdropKey;
  // final Task task;
  final Color color;

  // final TaskGetter<Task, int> getTotalTodos;
  // final TaskGetter<Task, HeroId> getHeroIds;
  // final TaskGetter<Task, int> getTaskCompletionPercent;

  TaskCard({
    @required this.backdropKey,
    @required this.color,
    // @required this.task,
    // @required this.getTotalTodos,
    // @required this.getHeroIds,
    // @required this.getTaskCompletionPercent,
  });

  @override
  Widget build(BuildContext context) {
    // var heroIds = getHeroIds(task);
    return GestureDetector(
      onTap: () {
        final RenderBox renderBox =
            backdropKey.currentContext.findRenderObject();
        var backDropHeight = renderBox.size.height;
        var bottomOffset = 60.0;
        var horizontalOffset = 52.0;
        var topOffset = MediaQuery.of(context).size.height - backDropHeight;

        var rect = RelativeRect.fromLTRB(
            horizontalOffset, topOffset, horizontalOffset, bottomOffset);

        // Navigator.push(
        //   context,
        //   ScaleRoute(
        //     rect: rect,
        //     widget: DetailScreen(
        //       taskId: task.id,
        //       heroIds: heroIds,
        //     ),
        //   ),
        //   // MaterialPageRoute(
        //   //   builder: (context) => DetailScreen(
        //   //         taskId: task.id,
        //   //         heroIds: heroIds,
        //   //       ),
        //   // ),
        // );

        Navigator.pushNamed(context, "SignIn");
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('asdfsdfsdf'),
              Spacer(
                flex: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4.0),
                child: Hero(
                  tag: null,
                  child: Text(
                    "Task",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.grey[500]),
                  ),
                ),
              ),
              Container(
                child: Hero(
                  tag: null,
                  child: Text("as12313213df",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.black54)),
                ),
              ),
              Spacer(),
              Hero(tag: null, child: Text('asdf')),
            ],
          ),
        ),
      ),
    );
  }
}
