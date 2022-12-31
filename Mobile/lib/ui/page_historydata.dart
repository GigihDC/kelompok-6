class DataRiwayat {
  String idPengantaran;
  String idPengguna;
  String namaLengkap;
  String alamat;
  String tanggal;
  String status;

  DataRiwayat(
      {this.idPengantaran,
      this.idPengguna,
      this.namaLengkap,
      this.alamat,
      this.tanggal,
      this.status});

  DataRiwayat.fromJson(Map<String, dynamic> json) {
    idPengantaran = json['id_pengantaran'];
    idPengguna = json['id_pengguna'];
    namaLengkap = json['nama_lengkap'];
    alamat = json['alamat'];
    tanggal = json['tanggal'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pengantaran'] = this.idPengantaran;
    data['id_pengguna'] = this.idPengguna;
    data['nama_lengkap'] = this.namaLengkap;
    data['alamat'] = this.alamat;
    data['tanggal'] = this.tanggal;
    data['status'] = this.status;
    return data;
  }
}