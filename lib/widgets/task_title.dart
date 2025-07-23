import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../screens/task_details.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text("Due: ${task.dueDate.toLocal().toString().split(' ')[0]}"),
        trailing: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
          );
          if (result == 'delete') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Task deleted (you should remove it from provider too)")),
            );
          }
        },
      ),
    );
  }
}
