package yun.cms.service.Impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yun.cms.dao.CoinDAO;
import yun.cms.dto.Coin;
import yun.cms.service.CoinService;

@Service
public class CoinServiceImpl implements CoinService{

    @Autowired
    CoinDAO coinDAO;
    
    @Override
    public List<Coin> list() {
        return coinDAO.findAll();
    }

    @Override
    public int insert(Coin coin) {
        return coinDAO.insert(coin);
    }

}
