package yun.cms.service;

import java.util.List;
import yun.cms.dto.UserAccount;

public interface UserAccountService {
    UserAccount get(int no);
    List<UserAccount> list();
    int update(UserAccount userAccount);
    int delete(UserAccount userAccount);
}
