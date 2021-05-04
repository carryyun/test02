package yun.cms.web;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import yun.cms.dto.FavoriteCoin;
import yun.cms.dto.Test;
import yun.cms.service.FavoriteCoinService;
import yun.cms.service.UserAccountService;


@Controller
public class TestController {
    UserAccountService userAccountService;
    FavoriteCoinService favoriteCoinService;
    
    public TestController(UserAccountService userAccountService,
                        FavoriteCoinService favoriteCoinService) {
        this.userAccountService=userAccountService;
        this.favoriteCoinService=favoriteCoinService;
    }

    
    //[21-05-05]작업
    @RequestMapping("/upbitTest4")
    public void upbitTest4(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        model.addAttribute("favCoin", favCoin);
    }
    
    
    //[21-05-04]작업
    @RequestMapping("/upbitTest3")
    public void upbitTest3(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        List<String> result=new ArrayList<String>();
        for(String f:list) {
            result.add(f);
        }
        
        ObjectMapper mapper = new ObjectMapper();
        String str=mapper.writeValueAsString(result);
        
        model.addAttribute("str", str);
    }
    
    //[21-05-03]작업
    @RequestMapping("/upbitTest2")
    public void upbitTest2(){
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
    }
    
    @RequestMapping("/upbitTest")
    public void upbitTest() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
    }
    
    @RequestMapping("/upbit")
    public void upbit() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
        System.out.println(t);
    }
    
    @RequestMapping("/test")
    public void test() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
        System.out.println(t);
    }
}
