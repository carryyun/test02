package yun.cms.dto;

public class Test {
    String name;
    String pw;
    @Override
    public String toString() {
        return "Test [name=" + name + ", pw=" + pw + "]";
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPw() {
        return pw;
    }
    public void setPw(String pw) {
        this.pw = pw;
    }
    
    
}
