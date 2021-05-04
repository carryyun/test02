package yun.cms.dto;

public class UserAccount {
    private int usersid;
    private String id;
    private String pw;
    
    public int getUsersid() {
        return usersid;
    }
    public void setUsersid(int usersid) {
        this.usersid = usersid;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPw() {
        return pw;
    }
    public void setPw(String pw) {
        this.pw = pw;
    }
    @Override
    public String toString() {
        return "UserAccount [usersid=" + usersid + ", id=" + id + ", pw=" + pw + "]";
    }
    
}
