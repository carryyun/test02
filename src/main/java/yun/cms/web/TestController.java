package yun.cms.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import yun.cms.DTO.Test;


@Controller
public class TestController {
    
    
    @RequestMapping("/test")
    public void test() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
        System.out.println(t);
        
    }
    
    @RequestMapping("/upbit")
    public void upbit() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
        System.out.println(t);
        
    }
    
    @RequestMapping("/upbitTest")
    public void upbitTest() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
//        System.out.println(t);
        
    }
    
    @RequestMapping("/upbitTest2")
    public void upbitTest2() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
//        System.out.println(t);
        
    }
    
    @RequestMapping("/upbitTest3")
    public void upbitTest3() {
        Test t=new Test();
        t.setName("testT");
        t.setPw("PWT");
//        System.out.println(t);
        
    }
    
}
