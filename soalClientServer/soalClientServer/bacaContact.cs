
using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace soalClientServer
{
	
	public class bacaContact
	{
		MySqlDataAdapter adapter;
		MySqlCommand komand;
		koneksi classKoneksi;
		DataTable tabel;
		string sql;
		
		public DataTable bacaPesanMasuk(int id_siswa)
		{
			classKoneksi = new koneksi();
			sql = "call bacaPesanMasuk("+id_siswa+")";
			tabel = new DataTable();
			
			try 
			{
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
