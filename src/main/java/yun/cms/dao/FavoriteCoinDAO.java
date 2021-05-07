package yun.cms.dao;

import java.util.List;
import yun.cms.dto.FavoriteCoin;

public interface FavoriteCoinDAO {
    List<String> findAllByNo(int no);
    
    int insert(FavoriteCoin favoriteCoin);
    int delete(FavoriteCoin favoriteCoin);
}
