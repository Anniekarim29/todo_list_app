// ✅ Revamped AddTaskScreen UI – Matching Modern Design

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../provider/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  DateTime? selectedDate;
  String selectedPriority = 'Medium';
  String selectedTag = 'Work';

  void saveTask() {
    if (titleController.text.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and Date are required")),
      );
      return;
    }

    final task = TaskModel(
      id: DateTime.now().toString(),
      title: titleController.text,
      description: descController.text,
      dueDate: selectedDate!,
      priority: selectedPriority,
      tag: selectedTag,
    );

    Provider.of<TaskProvider>(context, listen: false).addTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.note_add_rounded, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "New Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInput(titleController, "Title", Icons.title),
                    const SizedBox(height: 16),
                    _buildInput(descController, "Description", Icons.description),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: "Priority",
                      value: selectedPriority,
                      items: ["Low", "Medium", "High"],
                      onChanged: (val) => setState(() => selectedPriority = val!),
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: "Tag",
                      value: selectedTag,
                      items: ["Work", "Personal", "Other"],
                      onChanged: (val) => setState(() => selectedTag = val!),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          "Save Task",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onPressed: saveTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        selectedDate == null
            ? "Select Due Date"
            : "Due: ${selectedDate!.toLocal().toString().split(' ')[0]}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.calendar_today, color: Colors.deepPurple),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
        }
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
