package yun.cms.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
    
    //[21-05-07]작업 - 
    @RequestMapping("/upbitTest7")
    public void upbitTest7(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        
        
        model.addAttribute("favCoin", favCoin);
    }
    
    
    
    @RequestMapping(value = "/favRemove.do" ,method = RequestMethod.POST)
    @ResponseBody
    public FavoriteCoin favRemovedo(@RequestBody FavoriteCoin coin){
        System.out.println(coin);
        System.out.println(coin.getClass().getName());
        
        favoriteCoinService.delete(coin);
        
        return coin;
    }
    
    @RequestMapping(value = "/testInsert.do" ,method = RequestMethod.POST)
    @ResponseBody
    public void testInsertdo(){
        //테스트용 자료 세팅
        FavoriteCoin f1= new FavoriteCoin(1,"BTT");
        FavoriteCoin f2= new FavoriteCoin(1,"XRP");
        FavoriteCoin f3= new FavoriteCoin(1,"DOGE");
        FavoriteCoin f4= new FavoriteCoin(1,"ETC");
        FavoriteCoin f5= new FavoriteCoin(1,"BTC");
        
        favoriteCoinService.insert(f1);
        favoriteCoinService.insert(f2);
        favoriteCoinService.insert(f3);
        favoriteCoinService.insert(f4);
        favoriteCoinService.insert(f5);
    }
    
    
    //[21-05-06]작업 - 상세정보, 리스트 그리드 수정 / 코인의 누적된 볼륨을 일정분량씩 삭제(미완) / 볼륨레이블의 단위지정방식 수정
    @RequestMapping("/upbitTest6")
    public void upbitTest6(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        model.addAttribute("favCoin", favCoin);
    }
    
    //[21-05-05]작업 - infoToggle과 coinList를 반씩 나누어서 표현하기로 해봄.
    @RequestMapping("/upbitTest5")
    public void upbitTest5(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        model.addAttribute("favCoin", favCoin);
    }
    
    //[21-05-05]작업 - 작업 중 infoToggle을 왼쪽에 고정하는 방식으로 변경해보게 되어서 페이지를 넘김
    //                CSS도 바꾸게되어서 다시 열어보려면 jsp의 CSS를 globalCSS_Test5_before로 바꿔줘야함
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
