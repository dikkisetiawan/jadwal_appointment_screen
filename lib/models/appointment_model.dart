final List<String> status = ['Selesai', 'Belum Selesai', 'Reschedule'];

class AppointmentModel {
  final String? idAppointment;
  final String? dokter;
  final String? status;
  final DateTime? waktu;

  AppointmentModel({this.idAppointment, this.dokter, this.status, this.waktu});
}
