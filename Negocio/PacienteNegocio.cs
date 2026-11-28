using System;
using Datos;
using System.Collections.Generic;
using Entidades;

namespace Negocio
{
    public class PacienteNegocio
    {
        private DaoPaciente dao = new DaoPaciente();

        public int getCantidadRegistros()
        {
            return dao.ObtenerCantidadRegistros();
        }

        public List<PacienteListado> Listar(string texto, int idProvincia, int idLocalidad, string sexoTexto)
        {
            string sexo = ConvertirSexo(sexoTexto);
            return dao.Listar(texto, idProvincia, idLocalidad, sexo);
        }

        // La vista maneja "Femenino"/"Masculino"/"Otro", la base guarda 'F'/'M'/'O'.
        // Es como una traduccion que la
        // capa Datos no tenga que saber nada de como se ve la pantalla.
        private string ConvertirSexo(string sexoTexto)
        {
            if (string.IsNullOrWhiteSpace(sexoTexto))
            {
                return null;
            }

            switch (sexoTexto)
            {
                case "Femenino": return "F";
                case "Masculino": return "M";
                case "Otro": return "O";
                default: return null;
            }
        }

        public void DarDeBaja(string dni)
        {
            if (string.IsNullOrWhiteSpace(dni))
            {
                throw new System.ArgumentException(
                    "El DNI no puede estar vacío.",
                    nameof(dni));
            }
            if (!long.TryParse(dni, out long dniNum) || dniNum <= 0)
            {
                throw new System.ArgumentException(
                    "El DNI debe ser un número positivo.",
                    nameof(dni));
            }
            if (dni.Length < 7 || dni.Length > 8)
            {
                throw new System.ArgumentException(
                    "El DNI debe tener entre 7 y 8 dígitos.",
                    nameof(dni));
            }
            dao.DarDeBaja(dni);
        }

        public Persona ObtenerPorDni(string dni)
        {
            return dao.ObtenerPorDni(dni);
        }

        // Alta de paciente. Valida los datos de la Persona y que el DNI no este repetido
        // antes de ir a la base (UQ_Personas_DNI tira una excepcion de SQL menos clara).
        // Devuelve el IdPaciente generado.
        public int Alta(Persona persona)
        {
            ValidarPersona(persona);

            if (dao.ExisteDni(persona.DNI))
            {
                throw new ArgumentException("Ya existe una persona registrada con ese DNI.", nameof(persona));
            }

            return dao.Alta(persona);
        }

        private void ValidarPersona(Persona persona)
        {
            if (persona == null)
            {
                throw new ArgumentNullException(nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.DNI)
                || !long.TryParse(persona.DNI, out long dniNum)
                || dniNum <= 0
                || persona.DNI.Length < 7
                || persona.DNI.Length > 8)
            {
                throw new ArgumentException("El DNI debe ser un número de 7 u 8 dígitos.", nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.Nombre))
            {
                throw new ArgumentException("Ingrese el nombre.", nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.Apellido))
            {
                throw new ArgumentException("Ingrese el apellido.", nameof(persona));
            }

            if (persona.Sexo != 'F' && persona.Sexo != 'M' && persona.Sexo != 'O' && persona.Sexo != 'X')
            {
                throw new ArgumentException("Seleccione el sexo.", nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.Nacionalidad))
            {
                throw new ArgumentException("Seleccione la nacionalidad.", nameof(persona));
            }

            if (persona.FechaNacimiento == default(DateTime) || persona.FechaNacimiento.Date > DateTime.Today)
            {
                throw new ArgumentException("La fecha de nacimiento no es válida.", nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.Direccion))
            {
                throw new ArgumentException("Ingrese la dirección.", nameof(persona));
            }

            if (persona.IdLocalidad <= 0)
            {
                throw new ArgumentException("Seleccione la localidad.", nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.Telefono))
            {
                throw new ArgumentException("Ingrese el teléfono.", nameof(persona));
            }

            if (string.IsNullOrWhiteSpace(persona.Email))
            {
                throw new ArgumentException("Ingrese el correo electrónico.", nameof(persona));
            }
        }
    }
}
