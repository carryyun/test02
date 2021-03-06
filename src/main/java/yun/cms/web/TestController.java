package yun.cms.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import yun.cms.dto.Coin;
import yun.cms.dto.FavoriteCoin;
import yun.cms.dto.Test;
import yun.cms.dto.UserAccount;
import yun.cms.service.CoinService;
import yun.cms.service.FavoriteCoinService;
import yun.cms.service.UserAccountService;

@Controller
public class TestController {
    UserAccountService userAccountService;
    FavoriteCoinService favoriteCoinService;
    CoinService coinService;
    
    public TestController(UserAccountService userAccountService,
                        FavoriteCoinService favoriteCoinService,
                        CoinService coinService) {
        this.userAccountService=userAccountService;
        this.favoriteCoinService=favoriteCoinService;
        this.coinService=coinService;
    }
    private String location="upbitTest11";
        
    
    //[21-05-14]
    @RequestMapping("/upbitTest12")
    public void upbitTest12(Model model, HttpSession session) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        UserAccount getUser;
        String favCoin="null";
        System.out.println(session.getAttribute("curUser"));
        
        
        if( session.getAttribute("curUser") !=null ) {
            getUser = mapper.readValue(session.getAttribute("curUser").toString(), UserAccount.class);
            List<String> list = favoriteCoinService.listByNo(getUser.getUsersid());
            favCoin=mapper.writeValueAsString(list);
        }
        model.addAttribute("favCoin", favCoin);
        
        List<Coin> clist = coinService.list();
        model.addAttribute("clist", mapper.writeValueAsString(clist) );
        
        List<String> clistCode = new ArrayList<String>();
        for(Coin c:clist) {
            clistCode.add("KRW-"+c.getMarket());
        }
        model.addAttribute("clistCode", mapper.writeValueAsString(clistCode) );
        
    }
    
    
  //[21-05-12]?????? - 
    
    
    @RequestMapping("/upbitTest11")
    public void upbitTest11(Model model, HttpSession session) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        UserAccount getUser;
        String favCoin="null";
        System.out.println(session.getAttribute("curUser"));
        
        
        if( session.getAttribute("curUser") !=null ) {
            getUser = mapper.readValue(session.getAttribute("curUser").toString(), UserAccount.class);
            List<String> list = favoriteCoinService.listByNo(getUser.getUsersid());
            favCoin=mapper.writeValueAsString(list);
        }
        model.addAttribute("favCoin", favCoin);
        
        List<Coin> clist = coinService.list();
        model.addAttribute("clist", mapper.writeValueAsString(clist) );
        
        List<String> clistCode = new ArrayList<String>();
        for(Coin c:clist) {
            clistCode.add("KRW-"+c.getMarket());
        }
        model.addAttribute("clistCode", mapper.writeValueAsString(clistCode) );
        
    }
    
    // upbitTest11 = ????????? ???????????????
    @RequestMapping("/reactTest1")
    public void reactTest1(){
        
    }
    
    @RequestMapping("/upbitTest10")
    public void upbitTest10(Model model, HttpSession session) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        UserAccount getUser;
        String favCoin="null";
        System.out.println(session.getAttribute("curUser"));
        
        
        if( session.getAttribute("curUser") !=null ) {
            getUser = mapper.readValue(session.getAttribute("curUser").toString(), UserAccount.class);
            List<String> list = favoriteCoinService.listByNo(getUser.getUsersid());
            favCoin=mapper.writeValueAsString(list);
        }
        model.addAttribute("favCoin", favCoin);
        
        List<Coin> clist = coinService.list();
        model.addAttribute("clist", mapper.writeValueAsString(clist) );
        
        List<String> clistCode = new ArrayList<String>();
        for(Coin c:clist) {
            clistCode.add("KRW-"+c.getMarket());
        }
        model.addAttribute("clistCode", mapper.writeValueAsString(clistCode) );
        
    }
    
    
    
    
    //[21-05-11]?????? - 
    @RequestMapping("/upbitTest9")
    public void upbitTest9(Model model, HttpSession session) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        UserAccount getUser;
        String favCoin="null";
        System.out.println(session.getAttribute("curUser"));
        
        
        if( session.getAttribute("curUser") !=null ) {
            getUser = mapper.readValue(session.getAttribute("curUser").toString(), UserAccount.class);
            List<String> list = favoriteCoinService.listByNo(getUser.getUsersid());
            favCoin=mapper.writeValueAsString(list);
        }
        model.addAttribute("favCoin", favCoin);
        
        List<Coin> clist = coinService.list();
        model.addAttribute("clist", mapper.writeValueAsString(clist) );
        
        List<String> clistCode = new ArrayList<String>();
        for(Coin c:clist) {
            clistCode.add("KRW-"+c.getMarket());
        }
        model.addAttribute("clistCode", mapper.writeValueAsString(clistCode) );
        
    }
    
    @RequestMapping(value = "favInsert.do", method = RequestMethod.POST)
    @ResponseBody
    public int favInsertdo(@RequestBody FavoriteCoin favoriteCoin) {
        System.out.println("favcoin=");
        System.out.println(favoriteCoin);
        return favoriteCoinService.insert(favoriteCoin);
    }
    
    
    //[21-05-10]?????? - 
    @RequestMapping("/upbitTest8")
    public void upbitTest8(Model model, HttpSession session) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        UserAccount getUser;
        String favCoin="null";
        System.out.println(session.getAttribute("curUser"));
        
        
        if( session.getAttribute("curUser") !=null ) {
            getUser = mapper.readValue(session.getAttribute("curUser").toString(), UserAccount.class);
            List<String> list = favoriteCoinService.listByNo(getUser.getUsersid());
            favCoin=mapper.writeValueAsString(list);
        }
        model.addAttribute("favCoin", favCoin);
        
        List<Coin> clist = coinService.list();
        model.addAttribute("clist", mapper.writeValueAsString(clist) );
    }
    
    @RequestMapping("/login")
    public void login() {
        
    }
    @RequestMapping(value = "/signOut.do", method = RequestMethod.POST)
    public String sighOutdo(HttpSession session) {
        session.setAttribute("curUser", null);
        return "redirect:"+location;
    }
    
    @RequestMapping(value = "/signIn.do", method = RequestMethod.POST)
    public String signIndo(UserAccount user, HttpSession session) throws JsonProcessingException {
        UserAccount getUser = userAccountService.get(user);
        
        if( getUser.getPw().equals(user.getPw()) ){
            System.out.println("??????");
        }
        getUser.setPw(null);
        
        ObjectMapper mapper = new ObjectMapper();
        
        session.setAttribute("curUser", mapper.writeValueAsString(getUser));
        return "redirect:"+location;
    }
    
    
    //[21-05-09] ??????????????? ???????????? JSON????????????
    //??????????????? ??????????????? ???????????? ????????????
    @ResponseBody
    public List<Coin> testGetdo() {
        URL url;
        List<Coin> clist= new ArrayList<Coin>();
        try {
            url = new URL("https://api.upbit.com/v1/market/all?isDetails=false");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            
            //[21-05-09] 200=????????????
            if(con.getResponseCode() == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String readline=reader.readLine();
                ObjectMapper mapper = new ObjectMapper();
                clist = mapper.readValue(readline, new TypeReference<List<Coin>>(){ });
                System.out.println(clist);
                for(Coin c:clist) {
                    String tmpName=c.getMarket().toString().substring(0, 3);
                    if(tmpName.equals("KRW")) {
                        String subs=c.getMarket().toString().substring(4, c.getMarket().toString().length());
                        c.setMarket(subs);
                        coinService.insert(c);
                    }
                }
                reader.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clist;
    }
    
    
    
    //[21-05-07]?????? - 
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
        //???????????? ?????? ??????
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
    
    
    //[21-05-06]?????? - ????????????, ????????? ????????? ?????? / ????????? ????????? ????????? ??????????????? ??????(??????) / ?????????????????? ?????????????????? ??????
    @RequestMapping("/upbitTest6")
    public void upbitTest6(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        model.addAttribute("favCoin", favCoin);
    }
    
    //[21-05-05]?????? - infoToggle??? coinList??? ?????? ???????????? ??????????????? ??????.
    @RequestMapping("/upbitTest5")
    public void upbitTest5(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        model.addAttribute("favCoin", favCoin);
    }
    
    //[21-05-05]?????? - ?????? ??? infoToggle??? ????????? ???????????? ???????????? ??????????????? ????????? ???????????? ??????
    //                CSS??? ?????????????????? ?????? ??????????????? jsp??? CSS??? globalCSS_Test5_before??? ???????????????
    @RequestMapping("/upbitTest4")
    public void upbitTest4(Model model) throws JsonProcessingException {
        List<String> list = new ArrayList<String>(favoriteCoinService.listByNo(1));
        
        ObjectMapper mapper = new ObjectMapper();
        String favCoin=mapper.writeValueAsString(list);
        
        model.addAttribute("favCoin", favCoin);
    }
    
    
    //[21-05-04]??????
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
    
    //[21-05-03]??????
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
