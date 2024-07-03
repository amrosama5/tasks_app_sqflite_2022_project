import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    required this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.obscureText=false,
    this.hintText,
    this.suffixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.key,
    this.validator,
    this.controller,
    this.padding,
    this.onTap,
    this.hintStyle,
    this.isClickable,
    this.labelStyle,
    this.prefixStyle,
    this.suffixStyle,
  });


  String labelText;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  ValueChanged<String>? onSubmitted;
  ValueChanged<String>? onChanged;
  void Function()? onTap;
  String? Function(String ?)? validator;
  bool obscureText;
  BorderRadius borderRadius ;
  Key? key;
  TextEditingController? controller;
  EdgeInsetsGeometry? padding;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  TextStyle? suffixStyle;
  TextStyle? prefixStyle;
  bool? isClickable=true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onTap: onTap,
      enabled: isClickable,
      decoration:  InputDecoration(
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        suffixStyle: suffixStyle,
        prefixStyle: prefixStyle,
        contentPadding: padding,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderRadius: borderRadius
        ),
      ),

    );
  }
}



class CustomMaterialButton extends StatelessWidget {
  CustomMaterialButton({
    required this.color,
    this.width= double.infinity,
    this.height = 50,
    required this.text,
    required this.onPressed,
    this.borderRadius,
    this.textStyle
  }) ;

  Color color;
  double width;
  double height;
  String text;
  BorderRadiusGeometry? borderRadius;
  void Function() onPressed;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
      ),
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        child:  Text(text,style: textStyle,),
      ),
    );
  }
}


