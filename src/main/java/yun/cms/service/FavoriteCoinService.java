package yun.cms.service;

import java.util.List;
import yun.cms.dto.FavoriteCoin;

public interface FavoriteCoinService {
    List<String> listByNo(int no);
    FavoriteCoin insert(FavoriteCoin favoriteCoin);
    int delete(FavoriteCoin favoriteCoin);
}
