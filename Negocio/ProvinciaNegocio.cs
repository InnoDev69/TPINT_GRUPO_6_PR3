using Datos;
using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class ProvinciaNegocio
    {
        private readonly ProvinciaDatos dao = new ProvinciaDatos();

        public List<Provincia> Listar()
        {
            return dao.Listar();
        }
    }
}
