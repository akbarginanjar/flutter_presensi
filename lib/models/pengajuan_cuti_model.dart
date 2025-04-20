class PengajuanCuti {
  int? id;
  int? userId;
  String? tanggalCuti;
  String? tanggalCutiSelesai;
  String? alasanCuti;
  int? statusPermohonan;
  String? createdAt;
  String? updatedAt;
  String? tanggalPengajuan;

  PengajuanCuti(
      {this.id,
      this.userId,
      this.tanggalCuti,
      this.tanggalCutiSelesai,
      this.alasanCuti,
      this.statusPermohonan,
      this.createdAt,
      this.updatedAt,
      this.tanggalPengajuan});

  PengajuanCuti.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tanggalCuti = json['tanggal_cuti'];
    tanggalCutiSelesai = json['tanggal_cuti_selesai'];
    alasanCuti = json['alasan_cuti'];
    statusPermohonan = json['status_permohonan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tanggalPengajuan = json['tanggal_pengajuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['tanggal_cuti'] = tanggalCuti;
    data['tanggal_cuti_selesai'] = tanggalCutiSelesai;
    data['alasan_cuti'] = alasanCuti;
    data['status_permohonan'] = statusPermohonan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['tanggal_pengajuan'] = tanggalPengajuan;
    return data;
  }
}
