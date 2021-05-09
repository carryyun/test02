package yun.cms.dao;

import java.util.List;
import yun.cms.dto.Coin;

public interface CoinDAO {
    List<Coin> findAll();
    int insert(Coin coin);
}
