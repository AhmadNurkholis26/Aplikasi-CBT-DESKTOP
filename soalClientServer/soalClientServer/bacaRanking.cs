
using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace soalClientServer
{
	
	public class bacaRanking
	{
		MySqlDataAdapter adapter;
		MySqlCommand komand;
		string sql;
		DataTable tabel;
		koneksi classKoneksi;
		
		public DataTable bacaSemuaRanking()
		{
			classKoneksi = new koneksi();
			sql = "call lihatRanking";
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
