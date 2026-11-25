using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Medico
    {
        public string Legajo { get; set; }
        public int IdPersona {  get; set; }
        public int IdEspecialidad {  get; set; }
        public bool EstadoRegistro {  get; set; }

    }
}
