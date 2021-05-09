package yun.cms.service;

import java.util.List;
import yun.cms.dto.Coin;

public interface CoinService {
    List<Coin> list();
    int insert(Coin coin);
}
