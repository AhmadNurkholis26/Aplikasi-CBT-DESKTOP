
using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace adminSoalClientServer
{
	
	public class bacaDataNilai
	{
		MySqlDataAdapter adapter;
		MySqlCommand komand;
		koneksi classKoneksi;
		DataTable tabel;
		string sql;
		
		public DataTable bacaNilaiPerSiswa(int no_induk)
		{
			classKoneksi = new koneksi();
			sql = "call lihatNilaiPerSiswa("+no_induk+")";
			tabel = new DataTable();
			
			try {
				classKoneksi.koneksiBuka();
				komand = new MySqlCommand(sql,classKoneksi.konek);
				adapter = new MySqlDataAdapter(komand);
				adapter.Fill(tabel);
			} catch (Exception) {
				
			}
			classKoneksi.koneksiTutup();
			return tabel;
		}
		
		public DataTable bacaNilaiPerKat(int no_induk)
		{
			classKoneksi = new koneksi();
			sql = "call lihatNilaiPerKategori("+no_induk+")";
			tabel = new DataTable();
			
			try {
				classKoneksi.koneksiBuka();
				komand = new MySqlCommand(sql,classKoneksi.konek);
				adapter = new MySqlDataAdapter(komand);
				adapter.Fill(tabel);
			} catch (Exception) {
				
			}
			classKoneksi.koneksiTutup();
			return tabel;
		}
		
		public DataTable bacaNilaiPerMat(int no_induk)
		{
			classKoneksi = new koneksi();
			sql = "call lihatNilaiPerMataPelajaran("+no_induk+")";
			tabel = new DataTable();
			
			try {
				classKoneksi.koneksiBuka();
				komand = new MySqlCommand(sql,classKoneksi.konek);
				adapter = new MySqlDataAdapter(komand);
				adapter.Fill(tabel);
			} catch (Exception) {
				
			}
			classKoneksi.koneksiTutup();
			return tabel;
		}
	}
}
