import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

import '../../components/style/textstyle.dart';
import '../../constants/colors.dart';
import '../../preferences/settings/setting_prefer.dart';

class TestDialog extends StatelessWidget {
  const TestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: SettingPrefer.getLightDark() == null ||
                                    SettingPrefer.getLightDark()
                                ? black
                                : white,
                          ),
                      text:
                          'Điều khoản dịch vụ sửa chữa xe máy tại cửa hàng Snik như sau:\n',
                      children: [
                    TextSpan(
                      text:
                          '1.Quý khách hàng thừa nhận rằng xe máy đã được bàn giao cho Cửa Hàng Snik trong tình trạng hoạt động trước khi bắt đầu công việc sửa chữa.\n',
                      style: MyTextStyle.normal.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: SettingPrefer.getLightDark() == null ||
                                SettingPrefer.getLightDark()
                            ? black
                            : white,
                      ),
                    ),
                    TextSpan(
                        text:
                            '2.Cửa hàng sẽ liên hệ với Khách hàng để thông báo về tình trạng của xe máy cũng như các công việc cần thực hiện trước khi bắt đầu sửa chữa. Tất cả các chi phí sửa chữa đều phải được thống nhất trước với Khách hàng.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    TextSpan(
                        text:
                            '3.Cửa Hàng Snik sẽ chịu trách nhiệm về tất cả các thiết bị và linh kiện tại cửa hàng.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    TextSpan(
                        text:
                            '4.Khách hàng sẽ phải chịu trách nhiệm và chi phí cho tất cả các linh kiện được thay thế moi trong quá trình sửa chữa.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    TextSpan(
                        text:
                            '5.Cửa hàng cam kết với Khách hàng rằng các công việc sửa chữa sẽ được thực hiện chính xác và đầy đủ. Tuy nhiên, trong trường hợp khách hàng không hài lòng về các công việc sửa chữa, Cửa Hàng Snik sẽ tìm cách khắc phục vấn đề một cách nhanh chóng.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    TextSpan(
                        text:
                            '6.Cửa hàng không chịu trách nhiệm cho bất kỳ sự cố, thiệt hại hoặc tai nạn nào xảy ra với xe máy trong quá trình sử dụng sau khi được sửa chữa.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    TextSpan(
                        text:
                            '7.Khách hàng có trách nhiệm thanh toán tất cả các chi phí sửa chữa xe máy trước khi lấy xe tại cửa hàng.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    TextSpan(
                        text:
                            '8.Cửa hàng cam kết bảo mật và bảo vệ thông tin của Khách hàng trong quá trình sửa chữa.\n',
                        style: MyTextStyle.normal.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        )),
                    const TextSpan(
                        text:
                            'Cảm ơn quý khách hàng đã tin tưởng sử dụng dịch vụ của Cửa Hàng Snik!')
                  ])),
              TextButton(
                onPressed: () => DialogNavigator.of(context).push(
                  FluidDialogPage(
                    builder: (context) => const SecondDialogPage(),
                  ),
                ),
                child: const Text('Go to next page'),
              ),
            ],
          )),
    );
  }
}

class SecondDialogPage extends StatelessWidget {
  const SecondDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'And a bigger dialog',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(placeholder),
          TextButton(
            onPressed: () => DialogNavigator.of(context).pop(),
            child: const Text('Go back'),
          ),
          TextButton(
            onPressed: () => DialogNavigator.of(context).close(),
            child: const Text('Close the dialog'),
          ),
        ],
      ),
    );
  }
}

const placeholder = 'dasdsadasd';
