
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
   
    <meta charset="utf-8">
 
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
 
    <title>데이터불러오기1</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
    function setUpbitData(){
      $.ajax({
        url: "https://api.upbit.com/v1/market/all",
        dataType: "json"
      }).done(function(markets){
        //$("#tmp").html( JSON.stringify(markets) );
        let arr_krw_markets = "";
        let arr_korean_name = [];
        for(var i = 0; i < markets.length;i++){
            if( markets[i].market.indexOf("KRW") > -1 ){
            arr_krw_markets += markets[i].market+(",");
            arr_korean_name.push(markets[i].korean_name);
          }
        }
        arr_krw_markets = arr_krw_markets.substring(0, arr_krw_markets.length-1);
        let aaa = arr_krw_markets.substring(0, arr_krw_markets.length-1);
        console.log(aaa);
        //$("#tmp").html( arr_krw_markets );
        $.ajax({
          url: "https://api.upbit.com/v1/ticker?markets=" +arr_krw_markets,
          dataType: "json"
        }).done(function(tickers){
          $("#table_ticker > tbody > tr").remove();
          //alert($("#table_ticker > tbody > tr").length);
          $("#table_ticker").fadeOut("slow");
 
          for(let i = 0;i < tickers.length;i++){
            let rowHtml = "<tr><td>"+"<a href='candleEx.do?markets="+tickers[i].market+"'>"+arr_korean_name[i].replace().replace()+"</a>"+"</td>";
            //rowHtml += "<td>" + arr_korean_name[i] +"</td>"
            rowHtml += "<td>"+comma(tickers[i].trade_price)+"</td>";
            //전일대비율 출력 및 색 설정
            var compare = comma((tickers[i].signed_change_rate*100).toFixed(2));
            var aaa = new RegExp(/^-/);
            var bbb = aaa.test(compare);
            if(compare == 0.00){
                rowHtml += "<td>" + "<p>"+"<font color=black>" + comma((tickers[i].signed_change_rate*100).toFixed(2))+"%"+"</font>"+"</p>"+"</td>";
            }else {
            switch(bbb){
 
            case true:
            rowHtml += "<td>" + "<p>"+"<font color=blue>" + comma((tickers[i].signed_change_rate*100).toFixed(2))+"%"+"</font>"+"</p>"+"</td>";
            break;
            case false:
                rowHtml += "<td>" + "<p>"+"<font color=red>" + comma((tickers[i].signed_change_rate*100).toFixed(2))+"%"+"</font>"+"</p>"+"</td>";
                break;
            }
            }
            //전일대비율 출력 및 색 설정 끝
            rowHtml += "<td>" + comma((     tickers[i].acc_trade_price_24h>1000000 ? ( tickers[i].acc_trade_price_24h / 1000000 ) : tickers[i].acc_trade_price_24h ).toFixed(0)) + (tickers[i].acc_trade_price_24h>1000000 ? "백만" : "") + "</td>"
            rowHtml += "</tr>";
            $("#table_ticker > tbody:last").append(rowHtml);
            //markets[i].korean_name
          } // end for...
          $("#table_ticker").fadeIn("slow");
        })  //done(function(tickers){
      }) // end done(function(markets){
      .fail(function(){
        //alert("업비트 API 접근 중 에러.")}
        $("#tmp").text( "API 접근 중 에러." );
      })
      setTimeout(setUpbitData, 13000);
    }
    $(function() {
      var color = localStorage.getItem("test_upbit_color");
      if( color ) $("body").css("color", color);
      setUpbitData();
    });
    </script>
    <div id="tmp">
    </div>
    <br>
    <div class="table-overflow"><table id="table_ticker" class="table table-hover text-center">
      <thead>
      <tr>
        <!--td>NO</td-->
        <td>한글명</td>
        <td>현재가</td>
        <td>전일대비</td>
        <td>거래대금</td>
      </tr>
      </thead>
      <tbody>
      </tbody>
    </table></div>
    <br><br><br>
    <div id="tmp2">
    </div>