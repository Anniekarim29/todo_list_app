import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../provider/task_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;
  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late DateTime dueDate;
  late String priority;
  late String tag;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.task.title);
    descController = TextEditingController(text: widget.task.description);
    dueDate = widget.task.dueDate;
    priority = widget.task.priority;
    tag = widget.task.tag;
    super.initState();
  }

  void saveUpdate() {
    final updated = TaskModel(
      id: widget.task.id,
      title: titleController.text,
      description: descController.text,
      dueDate: dueDate,
      priority: priority,
      tag: tag,
      isCompleted: widget.task.isCompleted,
    );
    Provider.of<TaskProvider>(context, listen: false).updateTask(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Description")),
            ListTile(
              title: Text("Due: ${dueDate.toLocal().toString().split(' ')[0]}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => dueDate = picked);
              },
            ),
            DropdownButtonFormField(
              value: priority,
              items: ['Low', 'Medium', 'High'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (val) => setState(() => priority = val!),
              decoration: const InputDecoration(labelText: "Priority"),
            ),
            DropdownButtonFormField(
              value: tag,
              items: ['Work', 'Personal', 'Other'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (val) => setState(() => tag = val!),
              decoration: const InputDecoration(labelText: "Tag"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveUpdate, child: const Text("Update Task")),
          ],
        ),
      ),
    );
  }
}
