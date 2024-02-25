// import 'package:celebrity_dashboard/Widget/AppButtons.dart';
// import 'package:celebrity_dashboard/Widget/AppCheckbox.dart';
// import 'package:celebrity_dashboard/Widget/AppIcons.dart';
// import 'package:celebrity_dashboard/Widget/AppMessage.dart';
// import 'package:celebrity_dashboard/Widget/HandleException.dart';
// import 'package:celebrity_dashboard/screens/Authintication/Login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../../../Widget/AppColor.dart';
// import '../../../../Widget/AppSize.dart';
// import '../../../../Widget/AppText.dart';
// import '../../../../Widget/GeneralWidget.dart';
// import '../../../BackEnd/api_models.dart';
// import '../../../BackEnd/data_handle.dart';
// import '../../../BackEnd/provider_class.dart';
// import '../../../Widget/AppBar.dart';
// import '../../../Widget/AppRoutes.dart';
// import '../../../Widget/AppSnackBar.dart';
//
// class FilterAdLicense extends StatefulWidget {
//   const FilterAdLicense({super.key});
//
//   @override
//   State<FilterAdLicense> createState() => _FilterAdLicenseState();
// }
//
// class _FilterAdLicenseState extends State<FilterAdLicense> {
//   bool loading = false;
//   @override
//   void initState() {
//     super.initState();
//     lode();
//     // from = GeneralWidget.convertStringToDate(DateTime.now());
//     // to = GeneralWidget.convertStringToDate(
//     //     DateTime.now().add(const Duration(days: 1)));
//   }
//
//   lode() async {
//     ///get status list
//     if (!mounted) return;
//     context.read<ProviderClass>().verifyStatusProvider?.data == null
//         ? await context
//         .read<ProviderClass>()
//         .getVerifiedStatus()
//         .catchError((e) {
//       debugPrint('verifyStatusProvider Error:$e');
//     })
//         : null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ProviderClass? providerObject = context.read<ProviderClass>();
//     return Scaffold(
//       appBar: AppBarWidget(
//         text: AppMessage.filterResult,
//         showBar: false,
//         elevation: 2,
//         centerTitle: false,
//         textColor: AppColor.black,
//       ),
//       body: GeneralWidget.body(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//           child: Column(
//             children: [
// //status=======================================================================================
//               Selector<ProviderClass, String?>(
//                   selector: (_, provider) =>
//                   provider.verifyStatusProvider?.result,
//                   builder:
//                       (BuildContext context1, String? result, Widget? child) {
//                     return (result == AppMessage.loading ||
//                         result == AppMessage.initial)
//                         ? GeneralWidget.lodeWidget(
//                         context: context, listName: AppMessage.status)
//                         : (result != AppMessage.loaded &&
//                         result != AppMessage.unAuthorized)
//                         ? GeneralWidget.errorWidget(
//                         context: context, listName: AppMessage.status)
//                         : Selector<ProviderClass, VerifiedStatusObject?>(
//                         selector: (_, provider) =>
//                         (provider.verifyStatusProvider?.data),
//                         builder: (BuildContext context2,
//                             VerifiedStatusObject? providerData,
//                             Widget? child2) {
//                           List<VerifiedStatus> statusList =
//                           providerData!.data!.verifiedStatus!;
//                           return statusList.isEmpty
//                               ? GeneralWidget.emptyData(
//                               context: context)
//                               : ExpansionTile(
//                             expandedCrossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             tilePadding: EdgeInsets.zero,
//                             childrenPadding: EdgeInsets.zero,
//                             collapsedIconColor: AppColor.black,
//                             iconColor: AppColor.black,
//
//                             ///title=======
//                             title: AppText(
//                               text: AppMessage.status,
//                               fontSize: AppSize.subTitle,
//                               color: AppColor.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//
//                             ///children
//                             children: statusList
//                                 .map((VerifiedStatus status) {
//                               return AppCheckBox(
//                                 label: status.name!,
//                                 value: providerObject
//                                     .selectedStatusInFilter
//                                     .contains(status),
//                                 onChanged: (bool? value) {
//                                   GeneralWidget.getSelectedValues(
//                                       isSelect: value!,
//                                       item: status,
//                                       list: providerObject
//                                           .selectedStatusInFilter,
//                                       refreshUi: () {
//                                         setState(() {});
//                                       });
//                                 },
//                               );
//                             }).toList(),
//                           );
//                         });
//                   }),
//               const Divider(),
// //date=========================================================================================
//               ExpansionTile(
//                   expandedCrossAxisAlignment: CrossAxisAlignment.center,
//                   tilePadding: EdgeInsets.zero,
//                   childrenPadding: EdgeInsets.zero,
//                   collapsedIconColor: AppColor.black,
//                   iconColor: AppColor.black,
//                   shape: Border(
//                     top: BorderSide(color: AppColor.noColor),
//                     bottom: BorderSide(color: AppColor.noColor),
//                   ),
//
//                   ///title=======
//                   title: AppText(
//                     text: AppMessage.date,
//                     fontSize: AppSize.subTitle,
//                     color: AppColor.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//
//                   ///children
//                   children: [
//                     ///select date
//                     GestureDetector(
//                       onTap: () async {
//                         List<DateTime?>? r =
//                         await GeneralWidget.showDateRangDialog(
//                             context: context);
//                         if (r != null) {
//                           ///need this format to display month name to user
//                           providerObject.from =
//                               GeneralWidget.convertStringToDate(r[0]);
//                           providerObject.to = (r.length == 1
//                               ? providerObject.from
//                               : GeneralWidget.convertStringToDate(r[1]));
//
//                           ///save selected start date and end date in provider
//                           ///need this format to pass to api
//                           providerObject.startDateTime =
//                               DateFormat('dd-MM-yyyy').format(r[0]!);
//                           providerObject.endDateTime = (r.length == 1
//                               ? providerObject.startDateTime
//                               : DateFormat('dd-MM-yyyy').format(r[1]!));
//                         }
//                         setState(() {});
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(right: 10.w),
//                         alignment: AlignmentDirectional.center,
//                         decoration: GeneralWidget.decoration(
//                             color: AppColor.scaffoldColor,
//                             showBorder: true,
//                             borderColor: AppColor.textColor),
//                         height: 40.h,
//                         width: double.infinity,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               AppIcons.date,
//                               color: AppColor.mainColor,
//                               size: AppSize.appBarIconsSize,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
// //date====================================================================================================================================
//                             Padding(
//                               padding: EdgeInsets.only(top: 5.0.h),
//                               child: AppText(
//                                 text:
//
//                                 /// check if user tap date box or not
//                                 ///check if user select one or tow date
//                                 ///if user select only one date don't show (-)
//                                 providerObject.from == null
//                                     ? AppMessage.selectDate
//                                     : "${providerObject.from} ${providerObject.to == providerObject.from ? '' : '-'} ${providerObject.to == providerObject.from ? '' : "${providerObject.to}"}",
//                                 fontSize: AppSize.subTitle,
//                                 color: AppColor.textColor,
//                               ),
//                             ),
//                             const Spacer(),
// //clear date====================================================================================================================================
//                             providerObject.from == null
//                                 ? const SizedBox()
//                                 : IconButton(
//                                 onPressed: () {
//                                   providerObject.from = null;
//                                   providerObject.to = null;
//                                   providerObject.startDateTime = null;
//                                   providerObject.endDateTime = null;
//                                   setState(() {});
//                                 },
//                                 icon: Icon(
//                                   AppIcons.x,
//                                   color: AppColor.textColor,
//                                   size: AppSize.iconsSize,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     )
//                   ]),
//               const Spacer(),
// //reset button====================================================================================================================================
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: AppButtons(
//                         backgroundColor: AppColor.noColor,
//                         elevation: 0,
//                         side: BorderSide(color: AppColor.textColor),
//                         textStyleColor: AppColor.textColor,
//                         onPressed: () {
//                           providerObject.resetFilter();
//                           Navigator.pop(context);
//                         },
//                         text: AppMessage.reset),
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
// //apply button====================================================================================================================================
//                   Expanded(
//                     flex: 3,
//                     child: AppButtons(
//                         text: AppMessage.apply,
//                         label: loading
//                             ? CircularProgressIndicator(
//                           color: AppColor.white,
//                         )
//                             : null,
//                         onPressed: () async {
//                           providerObject.filterPage = 1;
//                           setState(() {
//                             loading = true;
//                           });
//
//                           ///check if user select any value or not
//                           if (context
//                               .read<ProviderClass>()
//                               .selectedStatusInFilter
//                               .isEmpty &&
//                               providerObject.startDateTime == null &&
//                               providerObject.endDateTime == null) {
//                             Navigator.pop(context);
//                           } else {
//                             ///get result=================================
//                             PostDataHandle result = await context
//                                 .read<ProviderClass>()
//                                 .getFilterAdvLicense();
//
//                             ///show loading in button
//                             setState(() {
//                               loading = false;
//                             });
//
//                             ///if no error pop page to show result
//                             if (!mounted) return;
//                             if (result.hasError == false) {
//                               Navigator.pop(context);
//                             }
//
//                             ///show snack bar base on message
//                             else {
//                               if (result.message == AppMessage.unAuthorized) {
//                                 AppRoutes.pushAndRemoveAllPageTo(
//                                     context, Login(),
//                                     removeProviderData: true);
//                               }
//                               Future.delayed(const Duration(milliseconds: 100),
//                                       () {
//                                     AppSnackBar.showInSnackBar(
//                                         context: context,
//                                         message: HandleException.getMessage(
//                                             result.message),
//                                         isSuccessful: !result.hasError);
//                                   });
//                             }
//                           }
//                         }),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.h,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }