import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/responsive_size.dart';
import 'package:we_dev_assignment_project/utils/text_style.dart';

import '../../../utils/gaps.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("My Account"),
        centerTitle: true,
        titleTextStyle: AppTextStyles.textStyleRoboto700.setFontSize(22),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Gaps.verticalGapOf(30),
                Center(
                  child: DottedBorder(
                    color: const Color(0xffFFADAD), // Set the border color
                    strokeCap: StrokeCap.round, // Ensure rounded dots
                    strokeWidth: 2.0, // Adjust the border width
                    dashPattern: const [5.0, 10.0],
                    borderType: BorderType.Circle, // Set circular border type
                    child: Container(
                    height: 130,
                      width: 130,
                      margin: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/images/man_img.png"), fit: BoxFit.fill)
                      ),
                    ),
                  ),
                ),
                Gaps.verticalGapOf(30),
                Text("John Smith", style: AppTextStyles.textStyleRoboto700.setColor(AppColor.blackColor).setFontSize(24),),
                Text("info@johnsmith.com", style: AppTextStyles.textStyleRoboto400.setColor(const Color(0xff535353)).setFontSize(15),)
              ],
            ),
            Container(
               width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: const Color(0xff4D587721).withOpacity(.13),
                     offset: const Offset(3, 7),
                     blurRadius: 5,
                     spreadRadius: -6,
                   )
                 ]
              ),
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    buildExpansionTile(titleText: "Account", leadingIcon: Icons.person_outline, children: [
                    buildTexField(labelText: "Email", hintText: "youremail@xmail.com",),
                    buildTexField(labelText: "Full Name", hintText: "William Bennett",),
                    buildTexField(labelText: "Street Address", hintText: "465 Nolan Causeway Suite 079",),
                    buildTexField(labelText: "Apt, Suite, Bldg (optional)", hintText: "Unit 512",),
                    buildTexField(labelText: "Zip Code", hintText: "77017", width: 150),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      // fixedSize:  Size(context.sWidth * .35, 50),
                                      padding: const EdgeInsets.all(20),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: AppColor.whiteColor,
                                      side: const BorderSide(color: Color(0xffD2DBE0), width: 1)
                                  ),
                                  onPressed: () {

                                  }, child: Text("Cancel", style: AppTextStyles.textStyleRoboto700.setColor(const Color(0xff818995)),)),
                            ),
                            Gaps.horizontalGapOf(20),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      // fixedSize:  Size(context.sWidth * .35, 50),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: AppColor.bottomSheetApplyBtnColor
                                  ),
                                  onPressed: () {

                                  }, child: Text("Apply", style: AppTextStyles.textStyleRoboto700.setColor(AppColor.whiteColor),)),
                            ),
                          ],
                        ),
                      )
                  ]),
                  buildExpansionTile(titleText: "Passwords", leadingIcon: Icons.lock_outline),
                  buildExpansionTile(titleText: "Notification", leadingIcon: Icons.notifications_none_outlined),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: buildExpansionTile(titleText: "Wishlist (00)", leadingIcon: Icons.favorite_border_outlined, isHideDivider: true)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTexField({required String labelText, required String hintText, double? width, TextEditingController? textEditingController}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: SizedBox(
        width: width,
         child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(labelText, style: AppTextStyles.textStyleRoboto400.fontSize14.setColor(AppColor.accountPageTextColor.withOpacity(.56)),),
                         Gaps.verticalGapOf(5),
                          TextField(
                            decoration: InputDecoration(
                               hintText: hintText, // Hint text
                              hintStyle:   TextStyle(
                                color: AppColor.accountPageTextColor.withOpacity(.32), // Hint text color (optional)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0), // Border radius
                                borderSide:   BorderSide(
                                  color: const Color(0xff2632381F).withOpacity(.13), // Border color
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0), // Border radius
                                borderSide:   BorderSide(
                                  color: const Color(0xff2632381F).withOpacity(.13), // Border color
                                ),
                              ),
                            ),
                           ),
                        ],
                      ),
      ),
    );
  }

  Widget buildExpansionTile({required IconData leadingIcon, required String titleText, List<Widget> children  = const [], bool isHideDivider = false}) {
    return Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: Column(
                  children: [
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      iconColor: const Color(0xff606B71),
                      collapsedIconColor: const Color(0xff899AA2),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Text(
                        titleText,
                        style: AppTextStyles.textStyleRoboto400.setColor(AppColor.blackColor).setFontSize(17),),

                      leading:  Icon(leadingIcon),
                      children: children,),
                    if(!isHideDivider)
                    const Divider(color: Color(0xffa0a9bd50),)
                  ],
                ),
              );
  }
}
