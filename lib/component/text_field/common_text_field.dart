import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.mexLength,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 24,
    this.paddingVertical = 30,
    this.borderRadius = 0,
    this.inputFormatters,
    this.fillColor = AppColors.filledColor,
    this.hintTextColor = AppColors.textFiledColor,
    this.labelTextColor = AppColors.textFiledColor,
    this.textColor = AppColors.black,
    this.borderColor = AppColors.transparent,
    this.onSubmitted,
    this.onTap,
    this.suffixIcon,
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color borderColor;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final int? mexLength;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: obscureText,
      textInputAction: widget.textInputAction,
      maxLength: widget.mexLength,
      cursorColor: AppColors.white,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(fontSize: 14, color: widget.textColor),
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      validator: widget.validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        prefixIcon: widget.prefixIcon,
        fillColor: widget.fillColor,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.paddingHorizontal.w,
          vertical: widget.paddingVertical.h,
        ),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        errorBorder: _buildBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: widget.hintTextColor,
        ),
        labelStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: widget.labelTextColor,
        ),
        prefix: CommonText(
          text: widget.prefixText ?? "",
          fontWeight: FontWeight.w400,
        ),
        suffixIcon:
            widget.isPassword ? _buildPasswordSuffixIcon() : widget.suffixIcon,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(color: widget.borderColor),
    );
  }

  Widget _buildPasswordSuffixIcon() {
    return GestureDetector(
      onTap: toggle,
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        child: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20.sp,
          color: widget.textColor,
        ),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
