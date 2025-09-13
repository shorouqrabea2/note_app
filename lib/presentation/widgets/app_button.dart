import 'package:firebase_project/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Function function;
  String text;
  double width;
  bool loadingState;
  AppButton({
    super.key,
    required this.function,
    required this.text,
    this.width = double.infinity,
    this.loadingState = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {           // onTap:function()
        function();
      },
      child: Container(
        height: 80,
        width: width,
        decoration: BoxDecoration(
          color: ColorsManager.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: (loadingState)
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "OpenSans",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}
