import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatefulWidget {
  final String? hint;
  final String? labelText;
  final String? label;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isPasswordField;
  final bool enabled;
  final double? height;
  final int maxLines;
  final Function()? onTap;
  final bool readOnly;
  final bool isOutlineBorder;
  final List<TextInputFormatter>? inputFormatterList;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final double bottomPadding;
  final Widget? prefixIcon;
  final Function()? onEditingComp;
  final Widget? suffixIcon;

  const AppFormField({
    Key? key,
    this.labelText,
    this.hint,
    this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    required this.controller,
    this.focusNode,
    this.enabled = true,
    this.height,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.isOutlineBorder = true,
    this.inputFormatterList,
    this.validator,
    this.onChanged,
    this.bottomPadding = 15.0,
    this.prefixIcon,
    this.onEditingComp,
  }) : super(key: key);
  @override
  _AppFormFieldState createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      child: TextFormField(
        focusNode: widget.focusNode,
        validator: widget.validator,

        decoration: InputDecoration(
          filled: true,
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0x33000000),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffEDEDED), ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffEDEDED), ),


          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffEDEDED), ),


      ),



          fillColor: const Color(0xffEDEDED),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: Color(0x33000000),
          ),
          prefixIcon: (widget.prefixIcon != null)
              ? widget.prefixIcon
              : (widget.icon != null)
                  ? Icon(widget.icon, color: Colors.grey.withOpacity(0.4))
                  : null,
          // border: InputBorder.none,
          suffixIcon: widget.suffixIcon ??
              (widget.isPasswordField ? _buildPasswordFieldVisibilityToggle() : null),
        ),
        style: const TextStyle(fontWeight: FontWeight.w600),
        keyboardType: widget.keyboardType,
        cursorColor: Theme.of(context).primaryColor,
        obscureText: widget.isPasswordField ? _obscureText : false,
        controller: widget.controller,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComp,
      ),
    );
  }

  Widget _buildPasswordFieldVisibilityToggle() {
    return IconButton(
      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
      onPressed: () => setState(() => _obscureText = !_obscureText),
    );
  }
}
