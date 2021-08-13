import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/models/activity.dart';

class ActivityDialog extends StatefulWidget {
  final Activity? activity;
  final Function(String name, String categoty) onClickedDone;

  const ActivityDialog({
    Key? key,
    this.activity,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _ActivityDialogState createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.activity != null) {
      final activity = widget.activity!;

      nameController.text = activity.name;
      categoryController.text = activity.category;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.activity != null;
    final title = isEditing ? 'Edit Activity' : 'Add Activity';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildCategory(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildCategory() => TextFormField(
        controller: categoryController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Category',
        ),
        validator: (category) =>
            category != null && category.isEmpty ? 'Enter a category' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final category = categoryController.text;

          widget.onClickedDone(name, category);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
