package com.dunnas.reservasalas.core.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class FormatarData {

    private static final DateTimeFormatter FORMATTER_PADRAO = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private static final DateTimeFormatter FORMATTER_DATA_HORA = DateTimeFormatter.ofPattern("dd/MM/yyyy 'às' HH:mm");

    private static final DateTimeFormatter FORMATTER_DATA = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private static final DateTimeFormatter FORMATTER_HORA = DateTimeFormatter.ofPattern("HH:mm");

    private static final DateTimeFormatter FORMATTER_HTML5 = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    /**
     * Converte LocalDateTime para String no formato padrão (dd/MM/yyyy HH:mm)
     */
    public static String toString(LocalDateTime dataHora) {
        if (dataHora == null) {
            return "N/A";
        }
        return dataHora.format(FORMATTER_PADRAO);
    }

    /**
     * Converte LocalDateTime para String no formato amigável (dd/MM/yyyy às HH:mm)
     */
    public static String toStringAmigavel(LocalDateTime dataHora) {
        if (dataHora == null) {
            return "N/A";
        }
        return dataHora.format(FORMATTER_DATA_HORA);
    }

    /**
     * Converte LocalDateTime para String apenas com a data (dd/MM/yyyy)
     */
    public static String toStringData(LocalDateTime dataHora) {
        if (dataHora == null) {
            return "N/A";
        }
        return dataHora.format(FORMATTER_DATA);
    }

    /**
     * Converte LocalDateTime para String apenas com a hora (HH:mm)
     */
    public static String toStringHora(LocalDateTime dataHora) {
        if (dataHora == null) {
            return "N/A";
        }
        return dataHora.format(FORMATTER_HORA);
    }

    /**
     * Converte String para LocalDateTime (formato dd/MM/yyyy HH:mm)
     */
    public static LocalDateTime fromString(String dataHoraString) {
        if (dataHoraString == null || dataHoraString.trim().isEmpty()) {
            return null;
        }

        try {
            return LocalDateTime.parse(dataHoraString, FORMATTER_PADRAO);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Formato de data/hora inválido. Use: dd/MM/yyyy HH:mm", e);
        }
    }

    /**
     * Converte String para LocalDateTime com formato específico
     */
    public static LocalDateTime fromString(String dataHoraString, String formato) {
        if (dataHoraString == null || dataHoraString.trim().isEmpty()) {
            return null;
        }

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(formato);
            return LocalDateTime.parse(dataHoraString, formatter);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Formato de data/hora inválido: " + formato, e);
        }
    }

    /**
     * Verifica se uma string pode ser convertida para LocalDateTime
     */
    public static boolean isValid(String dataHoraString) {
        if (dataHoraString == null || dataHoraString.trim().isEmpty()) {
            return false;
        }

        try {
            LocalDateTime.parse(dataHoraString, FORMATTER_PADRAO);
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    /**
     * Verifica se uma string pode ser convertida para LocalDateTime com formato
     * específico
     */
    public static boolean isValid(String dataHoraString, String formato) {
        if (dataHoraString == null || dataHoraString.trim().isEmpty()) {
            return false;
        }

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(formato);
            LocalDateTime.parse(dataHoraString, formatter);
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    /**
     * Converte LocalDateTime para String no formato HTML5 (yyyy-MM-ddTHH:mm)
     * Para uso em inputs do tipo datetime-local
     */
    public static String toHtml5String(LocalDateTime dateTime) {
        if (dateTime == null) {
            return "";
        }
        return dateTime.format(FORMATTER_HTML5); // CORREÇÃO: Usar a constante
    }

    /**
     * Converte String no formato HTML5 (yyyy-MM-ddTHH:mm) para LocalDateTime
     */
    public static LocalDateTime fromHtml5String(String dataHoraString) {
        if (dataHoraString == null || dataHoraString.trim().isEmpty()) {
            return null;
        }

        try {
            return LocalDateTime.parse(dataHoraString, FORMATTER_HTML5);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Formato de data/hora inválido para HTML5. Use: yyyy-MM-ddTHH:mm", e);
        }
    }
}
