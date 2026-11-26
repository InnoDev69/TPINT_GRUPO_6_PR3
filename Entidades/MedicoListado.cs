using System;

namespace Entidades
{
    // Representa una fila del listado de médicos (datos combinados de
    // Medicos + Personas + Especialidades + Localidades + Provincias + MedicosHorarios).
    public class MedicoListado
    {
        public string Legajo { get; set; }
        public string DNI { get; set; }
        public string Medico { get; set; }
        public string Especialidad { get; set; }
        public string Localidad { get; set; }
        public string Provincia { get; set; }
        public string DiasAtencion { get; set; }
        public string Horario { get; set; }
    }
}
