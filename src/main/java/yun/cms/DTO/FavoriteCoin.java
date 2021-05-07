package yun.cms.dto;

public class FavoriteCoin {
    private int usersid;
    private String coinname;

    public FavoriteCoin(int usersid, String coinname) {
        this.usersid = usersid;
        this.coinname = coinname;
    }
    public FavoriteCoin() {
    }


    public Integer getUsersid() {
        return usersid;
    }
    public void setUsersid(int usersid) {
        this.usersid = usersid;
    }
    public String getCoinname() {
        return coinname;
    }
    public void setCoinname(String coinname) {
        this.coinname = coinname;
    }
    @Override
    public String toString() {
        return "FavoriteCoin [usersid=" + usersid + ", coinname=" + coinname + "]";
    }
}
