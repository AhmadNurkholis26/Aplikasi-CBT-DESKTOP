
using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace adminSoalClientServer
{
	
	public class hapusSiswa
	{
		MySqlDataAdapter adapter;
		MySqlCommand komand;
		koneksi classKoneksi;
		DataTable tabel;
		string sql;
		
		public DataTable hapusDataSiswa(int id)
		{
			classKoneksi = new koneksi();
			sql = "call hapusSiswa("+id+")";
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
