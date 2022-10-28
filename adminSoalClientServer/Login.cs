
using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace adminSoalClientServer
{
	public class Login
	{
		MySqlCommand komand;
		MySqlDataAdapter adapter;
		koneksi classKoneksi;
		string sql;
		DataTable tabel;
		
		public DataTable ValidasiLogin(string user, string pass)
		{
			classKoneksi = new koneksi();
			sql = "call loginAdmin('"+user+"','"+pass+"')";
			tabel = new DataTable();
			
			try 
			{
				classKoneksi.koneksiBuka();
				komand = new MySqlCommand(sql,classKoneksi.konek);
				adapter = new MySqlDataAdapter(komand);
				adapter.Fill(tabel);
			} catch (Exception) 
			{
				
			}
			classKoneksi.koneksiTutup();
			return tabel;
			
		}
	}
}
