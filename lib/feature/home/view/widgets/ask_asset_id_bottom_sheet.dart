import 'package:flutter/material.dart';
import 'package:magic_slides/utils/widgets/app_text_field.dart';

class AskAssetIdBottomSheet extends StatefulWidget {
  final Function(String assetId) onSubmit;

  const AskAssetIdBottomSheet({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AskAssetIdBottomSheet> createState() => _AskAssetIdBottomSheetState();
}

class _AskAssetIdBottomSheetState extends State<AskAssetIdBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              "Enter Asset ID",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _controller,
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a valid Asset ID";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit(_controller.text.trim());
                    Navigator.pop(context);
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
