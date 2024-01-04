
package nhat.data.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    int iduser;
    String name, email, phone, password;
    boolean admin;

    public User(ResultSet rs) throws SQLException {
        this.iduser = rs.getInt("iduser");
        this.name =  rs.getString("name");
        this.email =  rs.getString("email");
        this.phone =  rs.getString("phone");
        this.password =  rs.getString("password");
        this.admin = rs.getBoolean("admin");
    }

    public User(int id, String name, String email, String phone, String password, boolean admin) {
        this.iduser = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.admin = admin;
    }

    public int getIduser() {
        return iduser;
    }

    public void setId(int iduser) {
        this.iduser = iduser;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean getAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }
     
}
