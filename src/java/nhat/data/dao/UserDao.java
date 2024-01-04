package nhat.data.dao;

import java.util.List;
import nhat.data.model.User;

public interface UserDao {
    
     public List<User> findAll();
    public User findUser(String emailphone, String password);
    public User findUser(String emailphone);
    public boolean Insert(String name, String email, String phone, String password);
    
}
