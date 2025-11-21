import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final bool? autofocus;
  final VoidCallback? onTapOutside;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.onTap,
    this.autofocus,
    this.onTapOutside,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  OutlineInputBorder _getBorder(
    BuildContext context, {
    Color? color,
    double width = 0.5,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? Theme.of(context).colorScheme.outlineVariant,
        width: width,
      ),
    );
  }

  String? _validateInput(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "${widget.label ?? widget.hint ?? 'Field'} cannot be empty";
    }

    if (widget.keyboardType == TextInputType.emailAddress) {
      final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
      if (!emailRegex.hasMatch(text)) {
        return "Enter a valid email";
      }
    }

    if (widget.obscureText) {
      final hasUpper = RegExp(r"[A-Z]").hasMatch(text);
      final hasLower = RegExp(r"[a-z]").hasMatch(text);
      final hasNumber = RegExp(r"[0-9]").hasMatch(text);

      final hasSpecial = RegExp(r'[!@#\$&*~%^(),.?":{}|<>]').hasMatch(text);

      if (text.length < 6 || !hasUpper || !hasLower || !hasNumber || !hasSpecial) {
        return "Password must contain:\n"
            "- Uppercase letter\n"
            "- Lowercase letter\n"
            "- Number\n"
            "- Special character\n"
            "- At least 6 characters";
      }
    }

    if (widget.validator != null) {
      return widget.validator!(value);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      autofocus: widget.autofocus ?? false,
      enabled: widget.enabled,
      obscureText: widget.obscureText ? _obscure : false,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      validator: _validateInput,
      onTap: widget.onTap,
      onTapOutside: (event) {
        widget.onTapOutside?.call();
      },
      maxLength: 64,
      buildCounter: (context,
              {required currentLength, required isFocused, required maxLength}) =>
          const SizedBox(),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefix,
        suffixIcon: widget.obscureText
            ? IconButton(
                iconSize: 16,
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : widget.suffix,
        enabledBorder: _getBorder(context),
        disabledBorder: _getBorder(context),
        focusedBorder: _getBorder(context, color: scheme.primary, width: 0.5),
        errorBorder: _getBorder(context, color: scheme.error, width: 0.5),
        focusedErrorBorder:
            _getBorder(context, color: scheme.error, width: 0.5),
      ),
    );
  }
}
