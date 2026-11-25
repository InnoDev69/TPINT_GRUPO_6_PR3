using Entidades;
using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace Negocio
{
    public class UsuarioNegocio
    {
        private string CalcularHash(string texto)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hash = sha256.ComputeHash(Encoding.Unicode.GetBytes(texto));

                StringBuilder sb = new StringBuilder();

                foreach (byte b in hash)
                {
                    sb.Append(b.ToString("X2"));
                }
                return sb.ToString();
            }
        }

        public Usuarios ValidarLogin(string nombreUsuario, string clave)
        {

            if(string.IsNullOrWhiteSpace(nombreUsuario) || string.IsNullOrWhiteSpace(clave))
            {
                return null;
            }

            string claveHash = CalcularHash(clave);

            DatosUsuario datos = new DatosUsuario();
            
            return datos.ValidarLogin(nombreUsuario.Trim(), claveHash);
            
        }
    }
}
