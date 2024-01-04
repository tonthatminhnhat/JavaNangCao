/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package nhat.data.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Model {

    private String idmodel, namemodel, note;

    public Model(String idmodel, String namemodel, String note) {
        this.idmodel = idmodel;
        this.namemodel = namemodel;
        this.note = note;
    }

    public Model(ResultSet rs) throws SQLException {
        this.idmodel = rs.getString("idmodel");
        this.namemodel = rs.getString("namemodel");
        this.note = rs.getString("note");
    }

    public void setIdmodel(String idmodel) {
        this.idmodel = idmodel;
    }

    public void setNamemodel(String namemodel) {
        this.namemodel = namemodel;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getIdmodel() {
        return idmodel;
    }

    public String getNamemodel() {
        return namemodel;
    }

    public String getNote() {
        return note;
    }
}
