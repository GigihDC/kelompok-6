class ChangeHistori {
  String idPenukaran;
  String idPengguna;
  String point;
  String nominal;
  String tanggal;
  String waktu;

  ChangeHistori(
      {this.idPenukaran,
      this.idPengguna,
      this.point,
      this.nominal,
      this.tanggal,
      this.waktu});

  ChangeHistori.fromJson(Map<String, dynamic> json) {
    idPenukaran = json['id_penukaran'];
    idPengguna = json['id_pengguna'];
    point = json['point'];
    nominal = json['nominal'];
    tanggal = json['tanggal'];
    waktu = json['waktu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_penukaran'] = this.idPenukaran;
    data['id_pengguna'] = this.idPengguna;
    data['point'] = this.point;
    data['nominal'] = this.nominal;
    data['tanggal'] = this.tanggal;
    data['waktu'] = this.waktu;
    return data;
  }
}