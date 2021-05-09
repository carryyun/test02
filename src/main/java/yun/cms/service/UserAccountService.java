package yun.cms.service;

import java.util.List;
import yun.cms.dto.UserAccount;

public interface UserAccountService {
    UserAccount get(int no);
    UserAccount get(UserAccount userAccount);
    List<UserAccount> list();
    int update(UserAccount userAccount);
    int delete(UserAccount userAccount);
}
