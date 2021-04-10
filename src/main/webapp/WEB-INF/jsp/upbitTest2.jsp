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

//Ver.2
//이전버전: 업비트에서 체결내역을 한개씩 받아오는 방법. => 문제점: 누락되는 내역이 생김
//이번버전에서 해결해야할 주요사항: 한번에 여러개의 내역을 받아온 뒤 최근 10개의 주문과 비교하여 처리해볼 예정

function setUpbitData(){
	//ASK = 매수 / BID = 매도 ??? X 아래 설명 다시참고
	
	//BID가 높은가격 == 위에 가격을 긁었다고 생각하면 이게 빨간색 매수로 표현이 되어야한다.
	//ASK가 낮은가격 == 아래 가격에 던졌다고 생각하면 이게 파란색 매도로 표현이 되어야한다.
	//BID == 호가창에 제시된 매수 할 수 있는 가격
	//ASK == 호가창에 제시된 매도 할 수 있는 가격
	let arrAskPrev = new Array(10);
	let arrAskPrev = new Array(10);
	
	$.ajax({
    	url: "https://api.upbit.com/v1/trades/ticks?count=10&market="+"KRW-BTT",
        dataType: "json"
    }).done(function(markets){
    	arrAskPrev=markets;
    	console.log(arrAskPrev);
    	
    });
	
	$.ajax({
        	url: "https://api.upbit.com/v1/trades/ticks?count=1&market="+"KRW-BTT",
            dataType: "json"
        }).done(function(markets){
        	
        	if(markets[0].trade_volume>=100000){
        		
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
     
</script>
</body>

</html>