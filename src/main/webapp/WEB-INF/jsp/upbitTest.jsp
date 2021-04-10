<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>



<body>
	<table id="askTable" style="border: 1px solid black">
	<thead></thead>
	
	<tbody id="aksTableBody"></tbody>
	</table>
	<table id="bidTable" style="border: 1px solid black">
	<thead></thead>
	
	<tbody id="bidTableBody"></tbody>
	</table>
<script type="text/javascript">
let askTimePrev=0;
let askPricePrev=0;
let askVolumePrev=0;
let bidTimePrev=0;
let bidPricePrev=0;
let bidVolumePrev=0;

let askCheckPrev=true;
let bidCheckPrev=true;

//업비트에서 체결내역을 한개씩 받아오는 방법.
//문제점 = 누락되는 내역이 생김
//다음방법 = 한번에 여러개의 내역을 받아온 뒤 최근 10개의 주문과 비교하여 처리해볼 예정
function setUpbitData(){
	//ASK = 매수 / BID = 매도

	$.ajax({
        	url: "https://api.upbit.com/v1/trades/ticks?count=1&market="+"KRW-BTT",
            dataType: "json"
        }).done(function(markets){
        	// console.log($("#inTable")[0].rows[0]); 행삭제
        	
        	if(markets[0].trade_volume>=100000){
        		
        		/* console.log(markets[0].ask_bid); */
        		
        		//체결시간
        		const time=markets[0].trade_time_utc;
        		//볼륨 소수점 버림처리
        		const volume=Math.floor(markets[0].trade_volume);
        		//가격
        		const price=markets[0].trade_price;
        		//매수매도 구분
        		const askbid=markets[0].ask_bid;
        		
        		if(askbid=='ASK'){
        			askCheckPrev = askTimePrev!=price && askVolumePrev!=volume;
        			/* console.log('ask=' + (String)(askTimePrev==price && askVolumePrev==volume)); 이전거래와 같은거래인지 체크 테스트출력*/
        		}else if(askbid=='BID'){
        			bidCheckPrev = bidTimePrev!=price && bidVolumePrev!=volume;
        			/* console.log('bid=' + (String)(bidTimePrev==price && bidVolumePrev==volume)); 이전거래와 같은거래인지 체크 테스트출력*/
        		}
        		
        		if( (askbid=='ASK') && (askCheckPrev) ){
        			// 이전 체결시간, 볼륨과 비교해 같은 주문인지 확인
        			askTimePrev = time;
        			askPricePrev = price;
        			askVolumePrev = volume;
        			
        			const asktable =  document.getElementById('askTable');
    	        	const asknewRow = asktable.insertRow();
    	        	asknewRow.className = 'ASKtr';
    	        	const asknewCell1 = asknewRow.insertCell(0);
    	        	const asknewCell2 = asknewRow.insertCell(1);
    	        	const asknewCell3 = asknewRow.insertCell(2);
    	        	const asknewCell4 = asknewRow.insertCell(3);
    	        	
    	        	asknewCell1.innerText = time;
    	        	asknewCell2.innerText = price;
    	        	asknewCell3.innerText = volume;
    	        	asknewCell4.innerText = askbid;
    	        	
    	        	//15줄이 넘어가면 첫번째 행 삭제
    	        	if(asktable.tBodies[0].rows.length >15){
    	        		asktable.deleteRow(0);
    	        	}
        			
        		}else if( (askbid=='BID') && (bidCheckPrev) ){
        			// 이전 체결시간, 볼륨과 비교해 같은 주문인지 확인
        			bidTimePrev = time;
        			bidPricePrev = price;
        			bidVolumePrev = volume;
        			
        			const bidtable =  document.getElementById('bidTable');
    	        	const bidnewRow = bidtable.insertRow();
    	        	bidnewRow.className = 'BIDtr';
    	        	const bidnewCell1 = bidnewRow.insertCell(0);
    	        	const bidnewCell2 = bidnewRow.insertCell(1);
    	        	const bidnewCell3 = bidnewRow.insertCell(2);
    	        	const bidnewCell4 = bidnewRow.insertCell(3);
    	        	
    	        	bidnewCell1.innerText = time;
    	        	bidnewCell2.innerText = price;
    	        	bidnewCell3.innerText = volume;
    	        	bidnewCell4.innerText = askbid;
    	        	
    	        	//15줄이 넘어가면 첫번째 행 삭제
    	        	if(bidtable.tBodies[0].rows.length >15){
    	        		bidtable.deleteRow(0);
    	        	}
        		}
        	}
        });
    	/* setTimeout(setUpbitData, 150); */
     
}
$(function() {
    var color = localStorage.getItem("test_upbit_color");
    if( color ) $("body").css("color", color);
    setUpbitData();
});
     /* 
      arr_krw_markets = arr_krw_markets.substring(0, arr_krw_markets.length-1);
      let aaa = arr_krw_markets.substring(0, arr_krw_markets.length-1);
      console.log(aaa);
      //$("#tmp").html( arr_krw_markets );
      $.ajax({
        url: "https://api.upbit.com/v1/ticker?markets=" +"KRW-BTT",
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
    setTimeout(setUpbitData, 13000); */
</script>
</body>

</html>