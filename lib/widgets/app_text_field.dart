import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/app_colors.dart';

Widget appTextField(
    {required String hintText,
    TextEditingController? controler,
    void Function(String)? onchange,
    TextInputAction? action,
    bool isenable = true,
    Widget? sufixWidgit,
    Widget? pefixWidgit,
    List<TextInputFormatter>? inputparamerts,
    bool? removeBorder,
    Color? hintColor,
    bool securetext = false,
    required keyBordType,
    required maxLiness,
    FocusNode? focusNode,
    required String? Function(dynamic value) fieldvalivator}) {
  return TextFormField(
    focusNode: focusNode,
    style: const TextStyle(color: Colors.black),
    textInputAction: action ?? TextInputAction.done,
    obscureText: securetext,
    inputFormatters: inputparamerts ?? [],
    validator: fieldvalivator,
    onChanged: onchange ?? (val) {},
    maxLines: maxLiness,
    keyboardType: keyBordType,
    controller: controler,
    decoration: InputDecoration(
        enabled: isenable,
        suffixIcon: sufixWidgit,
        prefixIcon: pefixWidgit,
        hintText: hintText,
        // label: Text(hintText),
        hintStyle: TextStyle(
            color: hintColor ?? Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w300),
        contentPadding: const EdgeInsets.fromLTRB(25, 5.0, 25, 5.0),
        filled: true,
        fillColor: removeBorder == true ? Colors.white : Colors.white,
        focusColor:
            removeBorder == true ? TxtFieldColors.filColor : Colors.white,
        hoverColor:
            removeBorder == true ? TxtFieldColors.filColor : Colors.white,
        disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: TxtFieldColors.borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: removeBorder == true
                  ? Colors.transparent
                  : TxtFieldColors.borderColor,
              width: 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: removeBorder == true
                  ? Colors.transparent
                  : TxtFieldColors.borderColor,
              width: 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: removeBorder == true
                  ? Colors.transparent
                  : TxtFieldColors.borderColor,
              width: 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: removeBorder == true
                  ? Colors.transparent
                  : TxtFieldColors.borderColor,
              width: 1.0),
          borderRadius: BorderRadius.circular(25),
        )),
  );
}
