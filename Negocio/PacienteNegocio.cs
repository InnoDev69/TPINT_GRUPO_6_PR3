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
    }
}