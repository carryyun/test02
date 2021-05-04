package yun.cms.dao;

import java.util.List;
import yun.cms.dto.UserAccount;

public interface UserAccountDAO {
    UserAccount findByNo(int no);
    List<UserAccount> findAll();
    
    UserAccount insert(UserAccount userAccount);
    int update(UserAccount userAccount);
    int delete(UserAccount userAccount);
}
