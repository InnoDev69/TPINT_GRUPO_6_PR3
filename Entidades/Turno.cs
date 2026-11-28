using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Turno
    {
        public int IdTurno { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan Hora { get; set; }
        public string Legajo { get; set; }
        public int IdEspecialidad { get; set; }
        public string Especialidad { get; set; }
        public int IdPaciente { get; set; }
        public string DNI { get; set; }
        public string Paciente { get; set; }
        public byte IdEstadoTurno { get; set; }
        public string EstadoTurno { get; set; }
        public string Observacion { get; set; }
    }
}
