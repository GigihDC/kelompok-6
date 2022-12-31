class PendapatanRiwayat {
  String kodeTransaksi;
  String tanggal;
  String waktu;
  String namaLengkap;
  String totalPoint;
  String idPengguna;

  PendapatanRiwayat(
      {this.kodeTransaksi,
      this.tanggal,
      this.waktu,
      this.namaLengkap,
      this.totalPoint,
      this.idPengguna});

  PendapatanRiwayat.fromJson(Map<String, dynamic> json) {
    kodeTransaksi = json['kode_transaksi'];
    tanggal = json['tanggal'];
    waktu = json['waktu'];
    namaLengkap = json['nama_lengkap'];
    totalPoint = json['total_point'];
    idPengguna = json['id_pengguna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_transaksi'] = this.kodeTransaksi;
    data['tanggal'] = this.tanggal;
    data['waktu'] = this.waktu;
    data['nama_lengkap'] = this.namaLengkap;
    data['total_point'] = this.totalPoint;
    data['id_pengguna'] = this.idPengguna;
    return data;
  }
}