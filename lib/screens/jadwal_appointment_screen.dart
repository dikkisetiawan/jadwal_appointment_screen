import 'dart:math';

import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '/theme.dart';

class JadwalAppointmentScreen extends StatelessWidget {
  JadwalAppointmentScreen({super.key});

  final List<String> namaNamaDokter = [
    'Jhonny',
    'Jhonny',
    'Yes',
    'Papa',
    'Sugar',
    'Hahaha'
  ];

  @override
  Widget build(BuildContext context) {
    final List<AppointmentModel> appointmentListData =
        List.generate(50, (index) {
      return AppointmentModel(
          idAppointment: 'Apt-$index',
          dokter: namaNamaDokter[Random().nextInt(namaNamaDokter.length)],
          status: status[Random().nextInt(status.length)],
          waktu: DateTime.now());
    });

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBarWidget(),
      body: bodyWidget(appointmentListData),
    );
  }

  ListView bodyWidget(List<AppointmentModel> appointmentListData) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(defaultMargin),
      itemCount: appointmentListData.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: defaultMargin),
          padding: const EdgeInsets.all(defaultMargin / 2),
          decoration: BoxDecoration(
            color: kWhiteColor,
            boxShadow: [kShadow],
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultCircular)),
          ),
          child: ListTile(
            onTap: () {
              snackBarWidget(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: kBorderRadius,
            ),
            title: itemContentWidget(
                appointmentListData[index].idAppointment,
                appointmentListData[index].dokter,
                appointmentListData[index].status,
                appointmentListData[index].waktu),
            trailing: trailingButtonWidget(context),
          ),
        );
      },
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: IconButton(
          onPressed: () {}, icon: Icon(Icons.arrow_back, color: kWhiteColor)),
      centerTitle: false,
      title: Text(
        'Jadwal Appointment',
        style: whiteTextStyle.copyWith(fontSize: 20),
      ),
    );
  }

  Widget trailingButtonWidget(BuildContext context) {
    return TextButton(
      onPressed: () {
        snackBarWidget(context);
      },
      child: Text(
        'Lihat Detail',
        style: buttonTextStyle,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarWidget(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: kDangerColor,
        content: Text(
          'Dalam Perbaikan',
          style: whiteTextStyle,
        ),
      ),
    );
  }

  Column itemContentWidget(
      String? idAppointment, String? dokter, String? status, DateTime? waktu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          label: Text(
            status?.toUpperCase() ?? '-',
            style: whiteTextStyle,
          ),
          backgroundColor:
              status?.contains('B') ?? false ? kSecondaryColor : kPrimaryColor,
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        Text('$idAppointment ',
            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: defaultMargin / 4,
        ),
        Row(
          children: [
            Text('Dokter : ',
                style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
            Text('Dr. $dokter', style: blackTextStyle),
          ],
        ),
        const SizedBox(
          height: defaultMargin / 4,
        ),
        Text('Waktu Awal : ',
            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 3,
        ),
        Text(
          ' ${waktu?.day ?? 0} - ${waktu?.month} - ${waktu?.year ?? 0}  ${waktu?.hour ?? 0}:${waktu?.second ?? 0}',
          style: blackTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ],
    );
  }
}
