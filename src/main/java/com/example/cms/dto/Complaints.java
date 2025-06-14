package com.example.cms.dto;

import lombok.*;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Complaints {
    private int id;
    private int userId;
    private String subject;
    private String description;
    private String status;
    private Date date_submitted;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDate_submitted() {
        return date_submitted;
    }

    public void setDate_submitted(Date date_submitted) {
        this.date_submitted = date_submitted;
    }

    public String toJson() {
        return "{" +
                "\"id\":" + id + "," +
                "\"userId\":" + userId + "," +
                "\"subject\":\"" + escapeJson(subject) + "\"," +
                "\"description\":\"" + escapeJson(description) + "\"," +
                "\"status\":\"" + status + "\"," +
                "\"dateSubmitted\":\"" + (date_submitted != null ? date_submitted.toString() : "") + "\"" +
                "}";
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

}
