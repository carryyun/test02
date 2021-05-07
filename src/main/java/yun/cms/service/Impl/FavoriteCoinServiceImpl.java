package yun.cms.service.Impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yun.cms.dao.FavoriteCoinDAO;
import yun.cms.dto.FavoriteCoin;
import yun.cms.service.FavoriteCoinService;

@Service
public class FavoriteCoinServiceImpl implements FavoriteCoinService {

    @Autowired
    FavoriteCoinDAO favoriteCoinDAO; 
    
    @Override
    public List<String> listByNo(int no) {
        return favoriteCoinDAO.findAllByNo(no);
    }

    @Override
    public int insert(FavoriteCoin favoriteCoin) {
        return favoriteCoinDAO.insert(favoriteCoin);
    }

    @Override
    public int delete(FavoriteCoin favoriteCoin) {
        return favoriteCoinDAO.delete(favoriteCoin);
    }

}
