package yun.cms.service.Impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import yun.cms.dao.UserAccountDAO;
import yun.cms.dto.UserAccount;
import yun.cms.service.UserAccountService;

@Service
public class UserAccountServiceImpl implements UserAccountService{

    @Autowired UserAccountDAO userAccountDAO;
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    
    @Override
    public UserAccount get(int no) {
        return userAccountDAO.findByNo(no);
    }

    @Override
    public List<UserAccount> list() {
        return userAccountDAO.findAll();
    }

    @Override
    public int update(UserAccount userAccount) {
        return userAccountDAO.update(userAccount);
    }

    @Override
    public int delete(UserAccount userAccount) {
        return userAccountDAO.delete(userAccount);
    }
}
