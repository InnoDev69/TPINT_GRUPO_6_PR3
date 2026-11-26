using System;

namespace Entidades
{
    //Basicamente representa una fila del listado de pacientes (datos combinados
    // de Pacientes + Personas + Localidades + Provincias).
    public class PacienteListado
    {
        public int IdPaciente { get; set; }
        public string DNI { get; set; }
        public string Paciente { get; set; }
        public string Sexo { get; set; }
        public string Localidad { get; set; }
        public string Provincia { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
    }
}