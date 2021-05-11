<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--
[21-05-05]css를 분리시켜둔경우 수정후 바로 적용되지 않을 수 있다. 이는 브라우저 캐시에서 읽기때문이다.
따라서 브라우저가 새로운css라고 인식하도록 뒤에?after같은 문자열을 붙인다 꼭after일 필요는없이 문자가 붙으면 된다. 

배포할때는 적용안되지만 CTRL+SHIF+R을 하면 캐시까지 초기화하는 새로고침이 된다.
-->

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

<!-- 차트에 필요한js -->
<script src="https://code.highcharts.com/stock/highstock.js"></script>
<script src="https://code.highcharts.com/stock/modules/data.js"></script>
<script src="https://code.highcharts.com/stock/modules/drag-panes.js"></script>
<!-- 차트를 그림저장, 인쇄 시켜주는모듈 -->
<!-- <script src="https://code.highcharts.com/stock/modules/exporting.js"></script> -->

<link href="/resources/yun/cms/css/globalCSS.css?a" rel="stylesheet"> 
<link href="/resources/yun/cms/css/bootstrap.css?b" rel="stylesheet"> 
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<body>
<%@include file="header.jsp"%>
<div id="wrapbody" class="wrap body">

	<div class="container">
	
		<div style="display: block;">
			<input type="text" id="testInput1"> <input type="text" id="testInput2">
			<button onclick="Test(this)">Go!</button> <button onclick="addItem(this)">ADDITEM!</button>
		</div>
		
		<div class="row">
			<div class="colmar-md-9 mr-10 darkBluePane p-10">
				<!-- infoToggle을 다시 고정형으로 변경함. ID는 그냥 그대로사용하기로 -->
				<div class="row" id="infoToggle">
					<div id="infoL" class="col-md-12">
						<div class="row">
						
							<!-- infoDiv의 왼쪽 [테이블]-->
							<div class="col-md-4 norp d-inline-block pr-10">
								<table id="bidTable" class="bidTable">
									<thead></thead>
									<tbody id="bidTableBody"></tbody>
								</table>
								<table id="askTable">
									<thead></thead>
									<tbody id="aksTableBody"></tbody>
								</table>
							</div>
							
							<!-- infoDiv의 오른쪽 -->
							<div class="col-md-8 d-flex flex-wrap">
								<div class="colmar-md-3 greyPane mb-10 mr-10 p-10">
									<div class="col-md-6 fs-20">
										<span id="tableCoinName"></span>
									</div>
									<div class="col-md-6 fs-20">
									</div>
									<div class="col-md-12 d-flex flex-wrap">
										<span class="col-md-4" id="tableCoinOpen">Open</span>
										<span class="col-md-8 text-right" id="tableCoinOpenValue"></span>
									</div>
									<div class="col-md-12 d-flex flex-wrap">
										<span class="col-md-4"  id="tableCoinHigh">High</span>
										<span class="col-md-8 text-right" id="tableCoinHighValue"></span>
									</div>
									<div class="col-md-12 d-flex flex-wrap">
										<span class="col-md-4"  id="tableCoinLow">Low</span>
										<span class="col-md-8 text-right" id="tableCoinLowValue"></span>
									</div>
								</div>
								
								<!-- infoDiv의 오른쪽 [그래프], [거래량] -->
								<div class="colmar-md-8 greyPane mb-10 mr-10 p-10">
									<!-- [그래프] -->
									<div id="barWrap" class="col-md-12 d-inline-block">
										<div id="barBid">
										</div>
										<div id="barAsk" class="d-inline-block">
										</div>
									</div>
									<!-- [거래량] -->
									<div class="col-md-12 d-flex position-relative tableVolumeSpan">
										<span id="bidVolumeSpan" class="col-md-6 text-left"></span>
										<span id="askVolumeSpan" class="col-md-6 text-right"></span>
									</div>
								</div>
								
								<div class="col-md-1 mb-10 p-10 greyPane">
									<br/>
									<span>옵</span><br/>
									<span>션</span><br/>
									<span>칸</span><br/>
								</div>
								
								<!-- infoDiv의 오른쪽 [차트] -->
								<div id="chart" class="col-md-12 greyPane">
								</div>
								
							</div>
						
						</div>
					
					</div>
			
				</div>
			</div>
			<!-- 코인리스트 -->
			<div class="col-md-3 p-10 darkBluePane">
				<div class="row">
					<div class="col-md-6 listMenu selectedMenu">
						<span>전체목록</span> 
					</div>
					<div class="col-md-6 listMenu">
						<span>즐겨찾기</span>
					</div>
					<div class="col-md-12 pl-10 pr-10 search">
						<input type="text" id="searchCoinText" class="fs-18 clearInput" placeholder="코인명">
						<a href="#" class="fs-18"><i id="searchIcon" class="fas fa-search"></i></a>
						<a href="#" id="clearBtn" onclick="searchClear()"> <i id="clearBtnIcon" class="fas fa-times position-relative"></i> </a>
					</div>
				</div>
				<div class="row pl-10 pr-10 position-relative" id="coinList">
				</div>
				<div class="row pl-10 pr-10 position-relative" id="coinListAll">
				</div>
			</div>
		</div>
		
		<!-- [21-05-09] 사용자가 즐겨찾기에 넣을 수 있도록 전체코인 리스트를 출력 (추가해야할지 말아야할지)-->
		<div class="row mt-10 justify-content-around darkBluePane">
			<div class="col-md-2 greyPane">
				a
			</div>
			<div class="col-md-2 greyPane">
				a
			</div>
			<div class="col-md-2 greyPane">
				a
			</div>
			<div class="col-md-2 greyPane">
				a
			</div>
			<div class="col-md-2 greyPane">
				a
			</div>
			<style>
				.col-md-2{
					height: 40px;
				}
			</style>
		</div>
	</div>	
	
	<!-- [21-05-04] 리스트에 추가할 아이템 복제용 -->
	<div id="hiddenitemCode" style="display: none;">
		<div id="coinN" class="col-md-12 coinItem" onclick="coinClick(this)">
		<div style="position:absolute; visibility: hidden"><a class="removeItemBtn fs-11" href="#" onclick="removeItem(this, event)"><i class="fas fa-trash-alt"></i></a></div>
				<div class="row" id="itemToggle">
					<div class="col-md-3">
						<span class="marketName"></span><br>
						<span class="marketPrice"></span>
					</div>
					<div id="coinItemRight" class="col-md-9 d-flex-wrap">
						<div id="barWrap-item" class="col-md-12 d-inline-block">
							<div id="barBid-item">
							</div>
						</div>
						
						<div class="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" class="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" class="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" class="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" class="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div class="abc"></div>
			</div>
	</div>
	
	
	<div class="pushFooter"></div>
</div>	
<%@include file="footer.jsp" %>

<script type="text/javascript">
//Ver.9
//0510이전버전: 코인리스트 여러개 출력 / 헤더,풋터 틀잡기 / 리스트의 아이템 클릭시 토글기능[coinList의 내용비움, infoToggle도 분리]
//					코인리스트에 아이템 추가시 중복인지 체크해야함, 코인리스트 infoToggle이 열리더라도 보기좋게 그리드수정, infoToggle 내용보강,
//					코인상세정보 채우기
//[21-05-10] 이번버전 주요사항: 

	
//[21-05-07] 체결내역의 유일성을 검증할 때 사용하는 Array를 Map에 저장하여 코인별로 사용 가능하도록 수정
let askIdMap=new Map();
let bidIdMap=new Map();

//[21-05-04] tableCoinName = 체결테이블의 코인이름을 저장해두기 위한 변수. 수정이 필요할 것 같음 
//			 tableTimer    = 재귀함수를 담아두었다가 종료를 시키기위한 변수
//			 tableinterval = 재귀함수가 실행될 주기
let tableCoinName="";
let tableInterval=200;
let tableTimer="";

//[21-05-04] 컨트롤러에서 받아오는 사용자가 설정해둔 코인의 리스트. 갯수에따라 조절하도록 html쪽도 수정해야함
//[21-05-06] 해결완료 => 받아온 리스트의 길이를 참고해 아이템갯수를 추가함.
let initListName;
if(${favCoin} != 'null'){
	initListName = ${favCoin};
}else{
	initListName = null;
}

//[21-05-09] 업비트의 KRW마켓 전체 목록
let listAll = ${clist};

//[21-05-05] 금액별 거래량필터를 설정하기위한 변수
let volumeFilter=100000;
//[21-05-09] 금액별 거래량필터를 설정하기위한 변수
let priceFilter=1000000;

//[21-05-05] 코인리스트 아이템을 갱신해주는 재귀함수를 담아둘 Map을 추가, 수정과 삭제할 때 해당 함수를 중지시켜야하므로.
//           재귀함수를 담아둘 변수는 array로 결정. Map에 넣는 이유는 코인이름와 매칭시키기 위해서.
//			 tradeTimerMap=아이템의 업비트API 타이머 / updateTimerMap=아이템의 정보를 갱신시키는 타이머
let tradeTimerMap=new Map();
let updateTimerMap=new Map();

//[21-05-05] 리스트의 코인정보를 받는 API함수에서 사용할 코인별 가격을 담을 Map.
//           => 새로 생성하지않고 coinMap을 이용할 수 있을 것 같음
//			 coinMap에 volume만 넣었었지만, price와 volume이 들어있는 객체로 넣는방법
let coin= function(name, price, bidVolume, totalVolume){
	this.name = name;
	this.price = price;
	this.bidVolume = bidVolume;
	this.totalVolume = totalVolume;
}
let coinMap= new Map();

//[21-05-05] 현재 클릭되어있는 아이템이 무엇인지 적용
let curItem="";

//[21-05-09] 검색기능 전체목록과 즐겨찾기목록중 선택된 곳에서 작동하도록 하기위해 변수로 체크
let searchSelector=true;

function tradeData(){
	time="";
	askbid="";
	price="";
	volume="";
}
function coinData(){
		code		="";
		kr_name		="";
		bidVolume	=0;
		askVolume	=0;
		totalVolume	=0;
		
		//tradeData가 들어감
		tradeArr	= new Array();
}
let coinDataMap= new Map();

function Test(item){
	/* 
	var Cname=$('#testInput1').val().toUpperCase();
	var Cnum=$('#testInput2').val().toUpperCase();
	
	
	// 코인추가하는 테스트 기능
	if( tradeTimerMap.get(Cname) === undefined ){
		setItem(Cname.toUpperCase());
		addListItem(Cname.toUpperCase(), Cnum);
	}else{
		//[21-05-05] *해결필요* 테스트용 메시지박스 삭제해야함
		alert("중복된 코인입니다.");
	} */
	// tmp=new coin("",0,0,0);
	
	let tmp=new Array();
	
	getUpbitData("BTC","trade");
	//[21-05-06] 코인상세정보에 필요한 코인가격의 세부정보를 가져옴.
	//[21-05-10] 따로 빼야함 웹소캣으로 체결내역이 들어올때마다 실행하게됨.
	let options = {method: 'GET'};
	fetch('https://api.upbit.com/v1/ticker?markets='+"KRW-BTC", options)
	  .then(response => response.json())
	  .then(response => {
		  response=response[0];
		  document.getElementById('tableCoinOpenValue').innerHTML = addComma(response.opening_price);
		  document.getElementById('tableCoinHighValue').innerHTML = addComma(response.high_price);
		  document.getElementById('tableCoinLowValue').innerHTML = addComma(response.low_price);
	  })
	  .catch(err => console.error(err));	
	
	
	/* var worker = new Worker( '/resources/yun/cms/js/worker.js' );
	worker.postMessage( '워커 실행' );  // 워커에 메시지를 보낸다.
	// 워커로 부터 메시지를 수신한다.
	worker.onmessage = function( e ) {
	    console.log('호출 페이지 - ', e.data );
	    console.log(getTrade("XRP"));
	}; */
}

function openSocket(){
	let socket = new WebSocket("wss://api.upbit.com/websocket/v1");
	socket.binaryType = "arraybuffer";
	return socket;
}

let tt = 1;
function getUpbitData(coinName, reqType){
	let socket = openSocket();
	
	socket.onopen = event =>{
		let msg = [
			{
			ticket : "ANY_TEXT",
			},{
			type : reqType,
			codes : ["KRW-"+coinName]
			}
		];
		socket.send(JSON.stringify(msg));
	};
	
	socket.onmessage = event => {
		var enc = new TextDecoder("utf-8");
		var arr = new Uint8Array(event.data);
		let data = JSON.parse(enc.decode(arr));
		//[21-05-10] 선택된 코인은 테이블업데이트 해주는 함수에 바로 보내줌
		if(data.code=="KRW-"+coinName)
			setInfoData(data);
		else{
			//[21-05-10] 리스트아이템의 데이터를 저장후 맵에 넣어줘야함
		}
		
		// socket.close();

	}
	// 발견된 문제.
	// 체결내역이 10개가 쌓여야 반환이 시작됨 => 요청갯수가 1이어도 거래가 1건이상 진행이 되어야 반환이됨.
	// 실시간으로 계속 정보를 받으며 출력시켜줘야할것같음.
	// 웹소캣으로 계속 데이터를 받으면 속도저하등의 문제는 없는지?
}

function setInfoData(data){
	if(data==null) return;
	
	let askIdArr=new Array();
	let bidIdArr=new Array();
	if( askIdMap.get(data.code) != undefined) askIdArr= askIdMap.get(data.code);
	if( bidIdMap.get(data.code) != undefined) bidIdArr= bidIdMap.get(data.code);
	
	let coindata = new coinData();
	if ( coinDataMap.get(data.code) != undefined ){
		coindata = coinDataMap.get(data.code);
		coindata.totalVolume += data.trade_volume;
	}else{
		coindata.code = data.code;
		coindata.totalVolume = data.trade_volume;
		coindata.askVolume = Number(0);
		coindata.bidVolume = Number(0);
		coindata.tradeArr = new Array();
	}
	if(data.ask_bid == 'ASK')
		coindata.askVolume += data.trade_volume;
	else
		coindata.bidVolume += data.trade_volume;
	let tradedata = new tradeData();
	tradedata.id= data.sequential_id;
	tradedata.price = data.trade_price;
	tradedata.time = data.trade_time;
	tradedata.askbid = data.ask_bid;
	tradedata.volume = data.trade_volume;
	coindata.tradeArr.push(tradedata);
	
	/* coinDataMap.set(data.code, coindata); */
	
	$('#tableCoinName').html(coin.code);
	
	
	let filter= volumeFilter/data.trade_price;
	
	if(data.trade_volume>=filter){
   		let checkId=data.sequential_id;
   		let volume=data.trade_volume;
   		let time=data.trade_time;
   		let askbid=data.ask_bid;
   		let price=data.trade_price;
   		
   		/* if(Math.floor(data.trade_volume)<=10){
   			volume=Number(data.trade_volume);
   		}else{
			volume=Math.floor(data.trade_volume);	
   		} */
   		
		// 체결내역의 고유한 ID를 이용해 중복된 내역인지 비교.
   		if( (askbid=='ASK') && (askIdArr.indexOf(checkId) == -1) ){
   			if(askIdArr.length>200){
   				askIdArr.shift();
   			}
   			
   			const asktable =  document.getElementById('askTable');
        	const asknewRow = asktable.insertRow(0);
        	asknewRow.className = 'ASKtr';
        	const asknewCell1 = asknewRow.insertCell(0);
        	asknewCell1.className = 'tradeTime';
        	const asknewCell2 = asknewRow.insertCell(1);
        	asknewCell2.className = 'tradePrice';
        	const asknewCell3 = asknewRow.insertCell(2);
        	asknewCell3.className = 'tradeVolume';
        	const asknewCell4 = asknewRow.insertCell(3);
        	asknewCell4.className = 'tradeAskbid';
        	const asknewCell5 = asknewRow.insertCell(4);
        	asknewCell5.className = 'tradeId';
        	
        	asknewCell1.innerText = time;
        	asknewCell2.innerText = addComma(price);
        	if(price > priceFilter){
        		asknewCell3.innerText = Number(volume).toFixed(3);	
        	}else{
        		asknewCell3.innerText = addComma(Math.floor(volume));
        	}
        	asknewCell4.innerText = askbid;
        	asknewCell5.innerText = checkId;
        	askIdArr.push(checkId);
	      	
        	//N(7)줄이 넘어가면 첫번째 행 삭제
        	if(asktable.tBodies[0].rows.length >8){
        		asktable.deleteRow(8);
        	}
	        	
	      	// 이전 체결시간, 볼륨과 비교해 같은 주문인지 확인
			// - 21-05-03 비교방식변경 => 체결내역에 고유한 ID가 있었음 그걸 이용해 비교.
   		}else if( (askbid=='BID') && (bidIdArr.indexOf(checkId) == -1) ){
			       			
   			if(bidIdArr.length>200){
   				bidIdArr.shift();
   			}
   			const bidtable =  document.getElementById('bidTable');
        	const bidnewRow = bidtable.insertRow();
        	bidnewRow.className = 'BIDtr';
        	const bidnewCell1 = bidnewRow.insertCell(0);
        	bidnewCell1.className = 'tradeTime';
        	const bidnewCell2 = bidnewRow.insertCell(1);
        	bidnewCell2.className = 'tradePrice';
        	const bidnewCell3 = bidnewRow.insertCell(2);
        	bidnewCell3.className = 'tradeVolume';
        	const bidnewCell4 = bidnewRow.insertCell(3);
        	bidnewCell4.className = 'tradeAskbid';
        	const bidnewCell5 = bidnewRow.insertCell(4);
        	bidnewCell5.className = 'tradeId';
	        	
        	bidnewCell1.innerText = time;
        	bidnewCell2.innerText = addComma(price);
        	if(price > priceFilter){
        		bidnewCell3.innerText = Number(volume).toFixed(3);	
        	}else{
        		bidnewCell3.innerText = addComma(Math.floor(volume));
        	}
	        	
        	bidnewCell4.innerText = askbid;
        	bidnewCell5.innerText = checkId;
        	bidIdArr.push(checkId);
	        	
	        	
        	//N(7)줄이 넘어가면 첫번째 행 삭제
        	if(bidtable.tBodies[0].rows.length >8){
        		bidtable.deleteRow(0);
        	}
   		}
   	}
	
		//[21-05-06] 체결그래프의 단위 세부조정
		//코인 상세정보(infoToggle)의 오른쪽 코인의 그래프 
		totalVolume=coindata.totalVolume;
		askVolume=coindata.askVolume;
		bidVolume=coindata.bidVolume;
		var bar=document.getElementById('barBid');
		var bar2=document.getElementById('barAsk');
     	var bidspan=document.getElementById('bidVolumeSpan');
     	var askspan=document.getElementById('askVolumeSpan');
     	bar.style.width=((bidVolume/totalVolume)*100)+'%';
     	
     	if(price > priceFilter){
     		bidspan.innerText = Number(bidVolume).toFixed(3);
     		askspan.innerText = Number(totalVolume-bidVolume).toFixed(3);
     	}else{
     		if( (bidVolume>1000000) ) bidspan.innerText = (bidVolume/1000000).toFixed(2)+"M";
         	else if( (bidVolume>1000) ) bidspan.innerText = addComma( (bidVolume/1000).toFixed(2) )+"K";
         	else bidspan.innerText = addComma( (bidVolume).toFixed(2) );
     		
     		if( ((totalVolume-bidVolume)>1000000) ) askspan.innerText = ((totalVolume-bidVolume)/1000000).toFixed(2)+"M";
         	else if( ((totalVolume-bidVolume)>1000) ) askspan.innerText = addComma( ((totalVolume-bidVolume)/1000).toFixed(2) )+"K";
         	else askspan.innerText = addComma( ((totalVolume-bidVolume)).toFixed(2) );
     	}
     	
	coinDataMap.set(data.code,coindata);
	
	askIdMap.set(data.code,askIdArr);
	bidIdMap.set(data.code,bidIdArr);
}










$(function() {
    const wrap =  document.getElementsByClassName('wrap');
    document.body.style.background='#151e2e';
    
    //체결테이블 초기화 함수
    initTable();
    
	//[21-05-06] 받아온 리스트의 길이를 참고해 아이템갯수를 추가함.
    let index=1;
	if(${sessionScope.curUser !=null}){
		if(initListName.length>0){
			initListName.forEach(i => {
				if(tradeTimerMap.get(i) != 'undefined'){
					if(index==1){
						initChart(i);
						// tableTimer = setTimeout("setUpbitData(\'"+i+"\')", tableInterval);
					}
			    	addItem(); // html 넣기.
			    	setItem(i); // 업비트 api 타이머 시작.
			    	addListItem(i, index); // 거래량 갱신 타이머 시작
			    	index++;
				}
		    });
		}
	}else{
		//[21-05-09] *해결필요* 임시작성, 비로그인일시 코인상세정보에 BTC로 설정을해둠 => 시작할때 전체목록에 BTC가 선택되어있고,
		//                   선택되어있는 코인의 이름을 받아와 tableCoinName에 저장하는식으로 고쳐야함
		//                   에러뜸 내일(10일) 고칠것
		/* tableCoinName="BTC";
		setTimeout("setUpbitData(\'"+tableCoinName+"\')", tableInterval); */
	}
	
	
	//[21-05-06] 코인의 누적된 거래량을 일정량씩 삭제해주는 함수.
	burn();
	
	initEventListener();
	for(let i=0; i<listAll.length;i++){
		addItemAll();
	}
});

function addItemAll(){
	var coinListAll = $('#coinListAll');
	var tempItem= $('#hiddenitemCode div#coinN');
	var num = Number(coinListAll.children().length)+1;
	let cnt = coinListAll.children().length;
	var copyItem = tempItem.clone();
	copyItem.attr('id','coinAll'+num);
	//리스트의 1번 아이템이면 selectedItem 클래스를 추가로 넣는다. 
	if(num==1){
		copyItem.attr('class','col-md-12 coinItem selectedItem');
		curItem=copyItem[0].id;
	}
	copyItem.css('display','block');
	coinListAll.append(copyItem);
	let name=listAll[cnt].market;
	addListItemAll(name,num);

}

function addListItemAll(coinName, num){
	coinName=coinName.toUpperCase();
	let span=$('#coinAll'+ num +' .marketName');
	span.html(coinName);
	
	if( coinMap.get(coinName) != undefined && coinMap.get(coinName) != undefined ){
		let span2=$('#coinAll'+ num +' .marketPrice');
		span2.html( addComma(coinMap.get(coinName).price) );
		
		let totalVolume=Number(coinMap.get(coinName).totalVolume);
		let bidVolume=Number(coinMap.get(coinName).bidVolume);
		let askVolume=Number(totalVolume-bidVolume);
		
		let bar=$('#coinAll'+ num +' #barBid-item');
		bar.css('width',((bidVolume/totalVolume)*100)+'%')
		
		let bidSpan=$('#coinAll'+ num +' #bidVolumeSpan-item');
		let askSpan=$('#coinAll'+ num +' #askVolumeSpan-item');
		let bar2=$('#coinAll'+ num +' #barAsk-item');
		
		//[21-05-06] 그래프에 퍼센트 추가.
		let bidPerSpan=$('#coinAll'+ num +' #bidVolumePerSpan-item');
		let askPerSpan=$('#coinAll'+ num +' #askVolumePerSpan-item');
		let bidPer, askPer;
		bidPer=( (bidVolume/totalVolume)*100 ).toFixed(1)+"%";
		askPer=( (askVolume/totalVolume)*100 ).toFixed(1)+"%";
		
		bidPerSpan.html( bidPer );
		askPerSpan.html( askPer );
		
		//[21-05-06] 체결그래프의 단위 세부조정
		let bid, ask;
		if(coinMap.get(coinName).price > priceFilter){
			bidSpan.html( bidVolume.toFixed(3) );
			askSpan.html( askVolume.toFixed(3) );
		}else{
			if( (bidVolume>1000000) ) bid = (bidVolume/1000000).toFixed(2)+"M";
	     	else if( (bidVolume>1000) ) bid = addComma( (bidVolume/1000).toFixed(2) )+"K";
	     	else bid = addComma( Number(bidVolume).toFixed(2) );
	     	bidSpan.html(bid + " " + bidPer);
	     	
	     	if( askVolume>1000000 )  ask = (askVolume/1000000).toFixed(2)+"M";
	     	else if( askVolume>1000 ) ask = addComma( (askVolume/1000).toFixed(2) )+"K";
	     	else ask = addComma( askVolume.toFixed(2) );
			askSpan.html(askPer + " " +ask);
		}
	}
	
	//[21-05-04] setTimeout을 이용해 재귀함수를 사용할 때,
	//			매개변수를 사용하게 된다면 **** 각 변수마다 따옴표를 **** 씌워줘야한다.
	//			그렇지 않으면 매번 불러올때마다 변수값이 이상하게 추가되어
	//			coinName,num,undefined 이런식으로 매개변수를 넘기게되므로 오류가 발행한다.
	//[21-05-05] 아이템의 정보갱신 타이머를 담는 맵. => 아이템 삭제시 타이머를 중지시키기 위해 필요.
	updateTimerMap.set(coinName, setTimeout('addListItemAll(\"'+coinName+ '\",\"' +num+'\")', 1000));
}


function initEventListener(){
	//[21-05-07] 리스트 아이템삭제에 쓰일 휴지통아이콘 visibility toggle기능
	let coinItems = document.getElementsByClassName("coinItem");
	for(let item of coinItems){
		item.addEventListener("mouseenter", e => {
			$("#coinList #"+item.id + " .removeItemBtn").css('visibility','visible');
		});
		item.addEventListener("mouseleave", e => {
			/* event.stopPropagation(); */
			$("#coinList #"+item.id + " .removeItemBtn").css('visibility','hidden');
		});
		
	}
	
	//[21-05-06] 코인검색 input을 클릭하면 클리어버튼이 보이고 아웃포커스될때 클리어버튼이 사라지게
	document.getElementById("searchCoinText").addEventListener("focusout", e => {
		  
		if( $("#searchCoinText").val()=="" ){
			$('#clearBtn').css('display','none');
		}
	});
	document.getElementById("searchCoinText").addEventListener("focus", e => {
		  $('#clearBtn').css('display','inline-block');
	});
	
	//[21-05-07] 검색기능 추가
	document.getElementById("searchCoinText").addEventListener("keyup", e => {
		//[21-05-09] searchSelector  true=전체검색, false=즐겨찾기검색
		if(searchSelector){
			let cnt=$('#coinListAll').children().length;
			let input=$("#searchCoinText").val().toUpperCase();
			if(input == ""){
				for(let i=1; i<cnt+1; i++){
					$('#coinListAll #coinAll'+i).css('display','block');
				}
				return;
			}
			for(let i=1; i<cnt+1; i++){
				item=$('#coinListAll #coinAll'+i+" .marketName").html();
				if(item.indexOf(input) != -1){
					$('#coinListAll #coinAll'+i).css('display','block');
				}else{
					$('#coinListAll #coinAll'+i).css('display','none');
				}
			}
		}else{
			let cnt=$('#coinList').children().length;
			let input=$("#searchCoinText").val().toUpperCase();
			if(input == ""){
				for(let i=1; i<cnt+1; i++){
					$('#coin'+i).css('display','block');
				}
				return;
			}
			for(let i=1; i<cnt+1; i++){
				item=$('#coinList #coin'+i+" .marketName").html();
				if(item.indexOf(input) != -1){
					$('#coinList #coin'+i).css('display','block');
				}else{
					$('#coinList #coin'+i).css('display','none');
				}
			}
		}
	});
	
	//[21-05-09] 리스트의 메뉴 클릭이벤트 추가
	let listMenus = document.getElementsByClassName("listMenu");
	listMenus[0].addEventListener("click", e => {
		listMenus[0].className="col-md-6 listMenu selectedMenu";
		listMenus[1].className="col-md-6 listMenu";
		document.getElementById('coinListAll').style.display='block';
		document.getElementById('coinList').style.display='none';
		searchSelector=true;
	});
	listMenus[1].addEventListener("click", e => {
		listMenus[1].className="col-md-6 listMenu selectedMenu";
		listMenus[0].className="col-md-6 listMenu";
		document.getElementById('coinListAll').style.display='none';
		document.getElementById('coinList').style.display='block';
		searchSelector=false;
	});
	
} 

function testInsert(){
	$.ajax({
		url: "testInsert.do",
		type: "POST",
		success: function(data){
			console.log("완료");
		},
		error: function(err){
			console.log(err);
		}
	});
}

function searchClear(){ $('#searchCoinText').val(""); $('#clearBtn').css('display','none'); }

function removeItem(item, e){
	e.stopPropagation();
	
	if(!searchSelector){ return; }
	let getId=item.parentNode.parentNode.id;
	let getCoinName=$('#coinList #'+getId+" .marketName").html();
	
	let i={"usersid":"1" ,"coinname" : getCoinName};
	$.ajax({
		url: "favRemove.do",
		data: JSON.stringify(i),
		dataType:"json",
		contentType: 'application/json',
		type: "POST",
		success: function(data){
			//[21-05-07] *해결필요* 테스트용출력 삭제필요
			console.log("success");
			console.log(data);
        }
	});
	
	//[21-05-07] 삭제기능 임시로 display로 숨기기만 해둠
	item.parentNode.parentNode.remove();
	
	//*해결필요* 타이머 멈추는 기능 완성된코드로 옮겨놔야함[삭제기능]
	clearTimeout(tradeTimerMap.get(getCoinName));
	clearTimeout(updateTimerMap.get(getCoinName));
}

function addItem(){
	var coinList = $('#coinList');
	var tempItem= $('#hiddenitemCode div#coinN');
	var num = Number(coinList.children().length)+1;
	var copyItem = tempItem.clone();
	copyItem.attr('id','coin'+num);
	//리스트의 1번 아이템이면 selectedItem 클래스를 추가로 넣는다. 
/* 	if(num==1){
		copyItem.attr('class','col-md-12 coinItem selectedItem');
	} */
	copyItem.css('display','block');
	coinList.append(copyItem);
}

//[21-05-06] *해결필요* 전체 코인의 현재 누적된 체결볼륨을 일정분량씩 소각시킴.
// 변동성을 더 쉽게 보기위해서.
//[21-05-09] *해결필요* 아이템이 삭제되었는데도 삭제된 아이템에 대해 한번 실행되는 문제가 있음. setTimeout의 작동순서를 확인해봐야할것같음,  이것도 코인별로 타이머를 만들어야할지?
let burnTimer;
function burn(){
	let cnt=$('#coinList .coinItem').length;
	//hidden으로 숨겨둔 하나가 0번으로 잡혀서 i=1부터
	for(let i=1; i<cnt; i++){
		let getKey=$('#coinList #coin'+i+' .marketName').html();
		let c = new coin("",0,0,0);
		c=coinMap.get(getKey);
		
		c.totalVolume-= (c.totalVolume*0.2);
		c.bidVolume-= (c.bidVolume*0.2);
		coinMap.set(getKey,c);
	}
	
	burnTimer = setTimeout(burn,5000);
}

//21-05-03 기존 체결표와 거래량을 아이템 안에 넣어두고, 아이템 클릭하면 크기가 변하도록 하기위해 onClick이벤트.
function coinClick(item){
	//[21-05-05] 현재 선택된 코인이면 스킵하도록함.
	if(curItem==item.id) return;
	
	//[21-05-05] 선택된 아이템을 강조해주는 selectedItem클래스 추가
	if(curItem!="")	document.getElementById(curItem).className="col-md-12 coinItem";
	item.className="col-md-12 coinItem selectedItem";
	
	initTable();
	
	//[21-05-04] 재귀함수 호출을 중지시킨 후 선택된 코인의 이름으로 조회 시작
	clearTimeout(tableTimer);
	
	let selectedItem;
	if((item.id).substr(0,7)=='coinAll')
		selectedItem='#coinListAll #'+item.id+" .marketName";
	else
		selectedItem='#coinList #'+item.id+" .marketName";
	
	tableCoinName=$(selectedItem).html();
	curItem=item.id;
	initChart(tableCoinName);
	clearTimeout(tableTimer);
	
	tableTimer = setTimeout("setUpbitData(\'"+tableCoinName+"\')", tableInterval);
}

//[21-05-04] 리스트 내 아이템의 그래프를 그려주기 위한 함수
function setItem(coinName){
	coinName=coinName.toUpperCase();
    
    //[21-05-04] 코인이름을 매개변수로 보내는 함수(getTrade)를 통해 체결내역을 받아온다.
    //[21-05-10] 업비트의 데이터를 받아오는 함수변경. getUpbitData(코인이름, 내역갯수, 요청타입)
	let arrResult = new Array();
    arrResult=getTrade(coinName);	
	//arrResult = getUpbitData(coinName,10,"trade");
    
	//[21-05-05] 업비트API로 불러올 때 에러가 생겨 불러오지 못하면 바로 탈출하도록.
	if(arrResult.length<1) return;
	
	//[21-05-05] 코인의 가격에따라 미리 설정해둔 필터값 이상의 거래만 출력되도록.
	tmpVol= volumeFilter/arrResult[0].trade_price;
	if(coinName=="BTC") tmpVol=0.001;
	//[21-05-05] coin이라는 객체에 정보를 담아서 맵에 저장
	let tmpCoin = new coin("",0,0,0);
	if( coinMap.get(coinName) != undefined ){
		tmpCoin = coinMap.get(coinName);
	}
	
	//[21-05-07] 코인별 체결내역ID를 Array를 Map에 담아서 관리
	let askIdArr=new Array();
	let bidIdArr=new Array();
	if( askIdMap.get(coinName) != undefined ) askIdArr = askIdMap.get(coinName);
	if( bidIdMap.get(coinName) != undefined ) bidIdArr = bidIdMap.get(coinName);
	
	arrResult.forEach(item => {
		
		if(item.trade_volume>=tmpVol){
       		//체결번호, 유일성체크 가능
       		const checkId=item.sequential_id;
       		//볼륨 소수점 버림처리
       		let volume;
       		if(Math.floor(item.trade_volume) <= 10 ){
     			volume=Number(item.trade_volume);
       		}else{
       			volume=Math.floor(item.trade_volume);	
       		}
       		//매수매도 구분
       		const askbid=item.ask_bid;
       		//코인가격
       		tmpCoin.price=item.trade_price;
       		tmpCoin.name=coinName;
   			// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        //  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음. 값에는 tmpCoin을 저장시킴 
       		if( (askbid=='ASK') && (askIdArr.indexOf(checkId) == -1) ){
       			if(askIdArr.length>500){
       				askIdArr.shift();
       			}
       			askIdArr.push(checkId);
   	      		
   	        	if(tmpCoin.totalVolume==undefined){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	        	tmpCoin.totalVolume += Number(volume);
   	        	
       		}else if( (askbid=='BID') && (bidIdArr.indexOf(checkId) == -1) ){
       			if(bidIdArr.length>500){
       				bidIdArr.shift();
       			}
       			bidIdArr.push(checkId);
   	        	
   	        	if(tmpCoin.totalVolume==undefined){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	        	if(tmpCoin.bidVolume==undefined){
   	        		tmpCoin.bidVolume='0';
   	        	}
   	        	tmpCoin.totalVolume += Number(volume);
   	        	tmpCoin.bidVolume += Number(volume);
       		}
       	}
		
		if(tmpCoin.totalVolume==undefined){
			tmpCoin.totalVolume='0';
       	}
       	if(tmpCoin.bidVolume==undefined){
       		tmpCoin.bidVolume='0';
       	}
	});
	coinMap.set(coinName,tmpCoin);
	
	//[21-05-07] 체결내역ID의 저장방식의 변경으로 동일한 Array를 사용하던것에서 체결ID가 담긴Array를 코인별로 Map에 저장
	askIdMap.set(coinName,askIdArr);
	bidIdMap.set(coinName,bidIdArr);
	
	//[21-05-05] 아이템의 업비트API 타이머를 담는 맵. => 아이템 삭제시 타이머를 중지시키기 위해 필요.
	tradeTimerMap.set(coinName, setTimeout("setItem(\'"+ coinName +"\')", 1000) );
}
//[21-05-04] 코인리스트 아이템의 값을 넣어주는 함수
function addListItem(coinName, num){
	coinName=coinName.toUpperCase();
	let span=$('#coin'+ num +' .marketName');
	span.html(coinName);
	
	if( coinMap.get(coinName) != undefined && coinMap.get(coinName) != undefined ){
		
		let span2=$('#coin'+ num +' .marketPrice');
		span2.html( addComma(coinMap.get(coinName).price) );
		
		let totalVolume=Number(coinMap.get(coinName).totalVolume);
		let bidVolume=Number(coinMap.get(coinName).bidVolume);
		let askVolume=Number(totalVolume-bidVolume);
		
		let bar=$('#coin'+ num +' #barBid-item');
		bar.css('width',((bidVolume/totalVolume)*100)+'%')
		
		let bidSpan=$('#coin'+ num +' #bidVolumeSpan-item');
		let askSpan=$('#coin'+ num +' #askVolumeSpan-item');
		let bar2=$('#coin'+ num +' #barAsk-item');
		
		//[21-05-06] 그래프에 퍼센트 추가.
		let bidPerSpan=$('#coin'+ num +' #bidVolumePerSpan-item');
		let askPerSpan=$('#coin'+ num +' #askVolumePerSpan-item');
		let bidPer, askPer;
		bidPer=( (bidVolume/totalVolume)*100 ).toFixed(1)+"%";
		askPer=( (askVolume/totalVolume)*100 ).toFixed(1)+"%";
		
		bidPerSpan.html( bidPer );
		askPerSpan.html( askPer );
		
		//[21-05-06] 체결그래프의 단위 세부조정
		let bid, ask;
		if(coinMap.get(coinName).price > priceFilter){
			bidSpan.html( bidVolume.toFixed(3) );
			askSpan.html( askVolume.toFixed(3) );
		}else{
			if( (bidVolume>1000000) ) bid = (bidVolume/1000000).toFixed(2)+"M";
	     	else if( (bidVolume>1000) ) bid = addComma( (bidVolume/1000).toFixed(2) )+"K";
	     	else bid = addComma( Number(bidVolume).toFixed(2) );
	     	bidSpan.html(bid + " " + bidPer);
	     	
	     	if( askVolume>1000000 )  ask = (askVolume/1000000).toFixed(2)+"M";
	     	else if( askVolume>1000 ) ask = addComma( (askVolume/1000).toFixed(2) )+"K";
	     	else ask = addComma( askVolume.toFixed(2) );
			askSpan.html(askPer + " " +ask);
		}
	}
	
	//[21-05-04] setTimeout을 이용해 재귀함수를 사용할 때,
	//			매개변수를 사용하게 된다면 **** 각 변수마다 따옴표를 **** 씌워줘야한다.
	//			그렇지 않으면 매번 불러올때마다 변수값이 이상하게 추가되어
	//			coinName,num,undefined 이런식으로 매개변수를 넘기게되므로 오류가 발행한다.
	//[21-05-05] 아이템의 정보갱신 타이머를 담는 맵. => 아이템 삭제시 타이머를 중지시키기 위해 필요.
	updateTimerMap.set(coinName, setTimeout('addListItem(\"'+coinName+ '\",\"' +num+'\")', 1000));
}



//21-05-04 체결테이블의 데이터를 계산하는 내용은 함수로 따로 빼야할 것 같음.
//         -이 함수는 코인의 이름을 매개변수로 받아서 체결량만 계산하는 함수로 수정 할 예정.
//21-05-03 ajax를 통해 값을 받아오는 함수를 새로 만들고, 이 함수에서는 ajax제거.[21-05-03해당작업 완료]
function setUpbitData(coinName){
	coinName= coinName.toUpperCase();
	//BID가 높은가격 == 위에 가격을 긁었다고 생각하면 이게 빨간색 매수로 표현이 되어야한다.
	//ASK가 낮은가격 == 아래 가격에 던졌다고 생각하면 이게 파란색 매도로 표현이 되어야한다.
    
    //[21-05-04] 테이블의 코인 이름을 수정해줌.
    $('#tableCoinName').html(coinName);
    
    //[21-05-10] 업비트의 데이터를 받아오는 함수변경. getUpbitData(코인이름, 내역갯수, 요청타입)
	//getTrade = 업비트에서 체결내역 가져오는 API를 작성해둔 함수
	let arrResult = new Array();
	arrResult=getTrade(coinName);
/* 	console.log("arrResult");
	console.log(arrResult); */
	//arrResult=getUpbitData(coinName,7,"trade");
/* 	console.log("NewResult");
	console.log(getUpbitData(coinName,7,"trade")); */
	
	
	
	
	//[21-05-05] 업비트API로 불러올 때 에러가 생겨 불러오지 못하면 바로 탈출하도록.
	if(arrResult.length<1) return;
	
	//[21-05-05] 코인의 가격에따라 미리 설정해둔 필터값 이상의 거래만 출력되도록.
	let tmpVol= volumeFilter/arrResult[0].trade_price;
	
	//[21-05-07] 체결ID를 모두 동일한 Array에 보관했었으나, 코인별 Array를 Map에 담아서 보관하도록 수정
	let askIdArr=new Array();
	let bidIdArr=new Array();
	if( askIdMap.get(coinName+'Table') != undefined) askIdArr= askIdMap.get(coinName+'Table');
	if( bidIdMap.get(coinName+'Table') != undefined) bidIdArr= bidIdMap.get(coinName+'Table');
	
	//[21-05-05] coin(name, price, bidVolume, totalVolume)
    //			 기존방식= '코인이름BidVolume', '코인이름TotalVolume'이런식으로 맵에 넣어서 사용했었는데,
    //			 coin이라는 객체를 만들고, 거기에 정보를 담은 다음 코인이름을 키값으로, coin객체를 값으로 넣는 방식으로 변경.
    let tmpCoin;
    if( coinMap.get(coinName+"Table") != undefined ){
		tmpCoin = coinMap.get(coinName+"Table");
	}else{
		tmpCoin=new coin(coinName,0,0,0);
	}
	
	arrResult.forEach(item => {
		if(item.trade_volume>=tmpVol){
       		//체결번호, 유일성체크 가능
       		let checkId=item.sequential_id;
       		//체결시간
       		let time=item.trade_time_utc; //[21-05-10]
       		//let time=item.trade_time;
       		//볼륨 소수점 버림처리
       		let volume=0;
       		if(Math.floor(item.trade_volume)<=10){
       			volume=Number(item.trade_volume);
       		}else{
   				volume=Math.floor(item.trade_volume);	
       		}
       		//가격
       		let price=item.trade_price;
       		tmpCoin.price=price;
       		tmpCoin.name=coinName;
       		//매수매도 구분
       		let askbid=item.ask_bid;
       		
   			// 체결내역의 고유한 ID를 이용해 중복된 내역인지 비교.
       		if( (askbid=='ASK') && (askIdArr.indexOf(checkId) == -1) ){
       			if(askIdArr.length>500){
       				askIdArr.shift();
       			}
       			
       			const asktable =  document.getElementById('askTable');
   	        	const asknewRow = asktable.insertRow(0);
   	        	asknewRow.className = 'ASKtr';
   	        	const asknewCell1 = asknewRow.insertCell(0);
   	        	asknewCell1.className = 'tradeTime';
   	        	const asknewCell2 = asknewRow.insertCell(1);
   	        	asknewCell2.className = 'tradePrice';
   	        	const asknewCell3 = asknewRow.insertCell(2);
   	        	asknewCell3.className = 'tradeVolume';
   	        	const asknewCell4 = asknewRow.insertCell(3);
   	        	asknewCell4.className = 'tradeAskbid';
   	        	const asknewCell5 = asknewRow.insertCell(4);
   	        	asknewCell5.className = 'tradeId';
   	        	
   	        	asknewCell1.innerText = time;
   	        	asknewCell2.innerText = addComma(price);
   	        	if(price > priceFilter){
   	        		asknewCell3.innerText = Number(volume).toFixed(3);	
   	        	}else{
   	        		asknewCell3.innerText = addComma(Math.floor(volume));
   	        	}
   	        	
   	        	asknewCell4.innerText = askbid;
   	        	asknewCell5.innerText = checkId;
   	        	askIdArr.push(checkId);
   	        	
   	      		// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        	//  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
   	        	if(tmpCoin.totalVolume==undefined || Number(tmpCoin.totalVolume)<0 ){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	      		
   	      		// 체결테이블의 거래량은 따로 계산해야 함 ( 리스트의 아이템과 중복으로 계산 됨 )
   	      		if(price > priceFilter){
   	      			tmpCoin.totalVolume += volume;
   	      		}else{
   	      			tmpCoin.totalVolume += Math.floor(volume);	
   	      		}
   	      		
   	      		
   	        	//N(7)줄이 넘어가면 첫번째 행 삭제
   	        	if(asktable.tBodies[0].rows.length >8){
   	        		asktable.deleteRow(8);
   	        	}
       			
   	        	
   	      	// 이전 체결시간, 볼륨과 비교해 같은 주문인지 확인
    		// - 21-05-03 비교방식변경 => 체결내역에 고유한 ID가 있었음 그걸 이용해 비교.
       		}else if( (askbid=='BID') && (bidIdArr.indexOf(checkId) == -1) ){
       			       			
       			if(bidIdArr.length>500){
       				bidIdArr.shift();
       			}
       			
       			const bidtable =  document.getElementById('bidTable');
   	        	const bidnewRow = bidtable.insertRow();
   	        	bidnewRow.className = 'BIDtr';
   	        	const bidnewCell1 = bidnewRow.insertCell(0);
   	        	bidnewCell1.className = 'tradeTime';
   	        	const bidnewCell2 = bidnewRow.insertCell(1);
   	        	bidnewCell2.className = 'tradePrice';
   	        	const bidnewCell3 = bidnewRow.insertCell(2);
   	        	bidnewCell3.className = 'tradeVolume';
   	        	const bidnewCell4 = bidnewRow.insertCell(3);
   	        	bidnewCell4.className = 'tradeAskbid';
   	        	const bidnewCell5 = bidnewRow.insertCell(4);
   	        	bidnewCell5.className = 'tradeId';
   	        	bidnewCell1.innerText = time;
   	        	bidnewCell2.innerText = addComma(price);
   	        	if(price > priceFilter){
   	        		bidnewCell3.innerText = Number(volume).toFixed(3);	
   	        	}else{
   	        		bidnewCell3.innerText = addComma(Math.floor(volume));
   	        	}
   	        	
   	        	bidnewCell4.innerText = askbid;
   	        	bidnewCell5.innerText = checkId;
   	        	bidIdArr.push(checkId);
   	        	
   	        	// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        	//  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
   	        	if(tmpCoin.totalVolume==undefined || Number(tmpCoin.totalVolume)<0){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	        	if(tmpCoin.bidVolume==undefined || Number(tmpCoin.bidVolume)<0){
   	        		tmpCoin.bidVolume='0';
   	        	}
   	        	
   	      		// 체결테이블의 거래량은 따로 계산해야 함 ( 리스트의 아이템과 중복으로 계산 됨 )
   	      		if(price > priceFilter){
	   	      		tmpCoin.totalVolume+=Number(volume);
	   	        	tmpCoin.bidVolume+=Number(volume);
   	      		}else{
	   	      		tmpCoin.totalVolume+=Math.floor(volume);
	   	        	tmpCoin.bidVolume+=Math.floor(volume);
   	      		}
   	        	
   	        	
   	        	//N(7)줄이 넘어가면 첫번째 행 삭제
   	        	if(bidtable.tBodies[0].rows.length >8){
   	        		bidtable.deleteRow(0);
   	        	}
       		}
       	}
		
		if(tmpCoin.totalVolume==undefined){
			tmpCoin.totalVolume='0';
       	}
       	if(tmpCoin.bidVolume==undefined){
       		tmpCoin.bidVolume='0';
       	}
		
		let totalVolume=Number(tmpCoin.totalVolume);
		let bidVolume=Number(tmpCoin.bidVolume);
		
		//[21-05-06] 체결그래프의 단위 세부조정
		//코인 상세정보(infoToggle)의 오른쪽 코인의 그래프 
		var bar=document.getElementById('barBid');
		var bar2=document.getElementById('barAsk');
     	var bidspan=document.getElementById('bidVolumeSpan');
     	var askspan=document.getElementById('askVolumeSpan');
     	bar.style.width=((bidVolume/totalVolume)*100)+'%';
     	
     	if(arrResult[0].trade_price > priceFilter){
     		bidspan.innerText = Number(bidVolume).toFixed(3);
     		askspan.innerText = Number(totalVolume-bidVolume).toFixed(3);
     	}else{
     		if( (bidVolume>1000000) ) bidspan.innerText = (bidVolume/1000000).toFixed(2)+"M";
         	else if( (bidVolume>1000) ) bidspan.innerText = addComma( (bidVolume/1000).toFixed(2) )+"K";
         	else bidspan.innerText = addComma( (bidVolume).toFixed(2) );
     		
     		if( ((totalVolume-bidVolume)>1000000) ) askspan.innerText = ((totalVolume-bidVolume)/1000000).toFixed(2)+"M";
         	else if( ((totalVolume-bidVolume)>1000) ) askspan.innerText = addComma( ((totalVolume-bidVolume)/1000).toFixed(2) )+"K";
         	else askspan.innerText = addComma( ((totalVolume-bidVolume)).toFixed(2) );
     	}
     	
	});
	coinMap.set(coinName+'Table',tmpCoin);
	
	//[21-05-07] 체결내역ID의 저장방식의 변경으로 동일한 Array를 사용하던것에서 체결ID가 담긴Array를 코인별로 Map에 저장함
	askIdMap.set(coinName+'Table',askIdArr);
	bidIdMap.set(coinName+'Table',bidIdArr);
	
	//[21-05-06] 코인상세정보에 필요한 코인가격의 세부정보를 가져옴.
	let options = {method: 'GET'};
	fetch('https://api.upbit.com/v1/ticker?markets=KRW-'+coinName, options)
	  .then(response => response.json())
	  .then(response => {
		  response=response[0];
		  document.getElementById('tableCoinOpenValue').innerHTML = addComma(response.opening_price);
		  document.getElementById('tableCoinHighValue').innerHTML = addComma(response.high_price);
		  document.getElementById('tableCoinLowValue').innerHTML = addComma(response.low_price);
	  })
	  .catch(err => console.error(err));
	// 재귀 , 인터벌 300
   	tableTimer=setTimeout("setUpbitData(\'"+coinName+"\')", tableInterval);
}

//21-05-03
//여러 코인의 정보를 ajax를 통해 가져와야하므로, 따로 함수를 만들고 async를 false로 설정해 동기식으로 변경.
//- 동기식으로 처리하지 않으면 다른 함수에서 return 받아 사용할 때, undefined이 출력된다.
// 이는 비동기식으로 처리할경우 ajax를 통해 값을 받아오기 전에 다음 코드를 진행하기 때문. 
function getTrade(coinName){
	coinName=coinName.toUpperCase();
	var tempArr = new Array();
	
	try{
		$.ajax({
		  	url: "https://api.upbit.com/v1/trades/ticks?count=7&market=KRW-"+coinName,
		  	async: false,
		    dataType: "json"
		}).done(function(result){
	  		tempArr=result;
  		});
	}catch (err) {
		console.log(err);
	}finally{
		return tempArr;	
	}
	
	
	return tempArr;
}

function initTable(){
	//체결테이블 초기화
    // - 값을 -로 넣어둔 이유는 테이블의 모양이 바로 잡혀있도록 하기 위해.
    const initAskTable =  document.getElementById('askTable');
	const initBidTable =  document.getElementById('bidTable');
	for(var i=0; i<8; i++){
		const initAskRow = initAskTable.insertRow();
		initAskRow.className = 'initASKtr';
		const initAskNewCell1 = initAskRow.insertCell(0);
       	initAskNewCell1.innerText = '-';
       	const initAskNewCell2 = initAskRow.insertCell(1);
       	initAskNewCell2.innerText = '-';
       	const initAskNewCell3 = initAskRow.insertCell(2);
       	initAskNewCell3.innerText = '-';
       	
       	const initBidRow = initBidTable.insertRow();
		initBidRow.className = 'initBIDtr';
		const initBidNewCell1 = initBidRow.insertCell(0);
       	initBidNewCell1.innerText = '-';
       	const initBidNewCell2 = initBidRow.insertCell(1);
       	initBidNewCell2.innerText = '-';
       	const initBidNewCell3 = initBidRow.insertCell(2);
       	initBidNewCell3.innerText = '-';
       	
       	if(initBidTable.tBodies[0].rows.length >8){
       		initBidTable.deleteRow(0);
       	}
       	if(initAskTable.tBodies[0].rows.length >8){
       		initAskTable.deleteRow(0);
       	}
	}
} 

function addComma(num){
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function initChart(coinName){
	Highcharts.setOptions({
	    global : { 
	        useUTC : false
	    }
	    ,xAxis : {
		      type: 'datetime',
		      dateTimeLabelFormats: { // don't display the dummy year
		    	 millisecond: '%H:%M',
		    	 second: '%H:%M',
		    	 minute: '%H:%M',
		    	 hour: '%H:%M',
		    	 day: '%e. %b',
	    	     week: '%e. %b',
		         month: '%e. %b',
		         year: '%b'
		      }
		}
	    
	}); 

	let chartData = "";
	const options = {method: 'GET'};
	fetch('https://api.upbit.com/v1/candles/minutes/1?market=KRW-'+coinName+'&count=200', options)
	  .then(response => response.json())
	  .then(response => {
		  chartData= response;
		  let marketName=chartData[0].market;	 
		  
		    // 가격정보와 볼륨을 나눠서 저장하는부분이지만, 볼륨이 없는 차트를 사용해서 가격정보만 나눔.
		    var ohlc = [];
		    dataLength = chartData.length;
		    // 순서 - timestamp, open, high, low, close
		    // 업비트는 최근거부터 넘겨주기때문에 for문을 반대로 돌려서 넣어야함 
		    for ( let i=dataLength-1; i >= 0; i-- ) {
	    		ohlc.push([
		        	chartData[i].timestamp, // the date
		            chartData[i].opening_price, // open
		            chartData[i].high_price, // high
		            chartData[i].low_price, // low
		            chartData[i].trade_price // close
		        ]);
		    }
		    // create the chart
		    Highcharts.stockChart('chart', {
		    	chart: {
		            marginLeft: 20,
		            marginRight: 20,
		            height: 350,
		            backgroundColor: '#1a2436'
		        },
		        xAxis: {
		        	//축에 맞춰 캔들을 그림
        			tickmarkPlacement: 'on',
        			//x좌표의 넓이조절
        			width:'91%'
		        },
		        yAxis: {
		            labels: {
		                align: 'left',
		                x: -30,
		                y: 0
		            }
		        },
		        rangeSelector: {
		            buttons: [{
		                type: 'minute',
		                count: 10,
		                text: '10m'
		            },{
		                type: 'hour',
		                count: 1,
		                text: '1h'
		            },{
		                type: 'all',
		                count: 1,
		                text: 'All'
		            }],
		            selected: 2,
		            inputEnabled: false
		        },
		        plotOptions: {
	                candlestick: {
	                    downColor: '#0966c6',
	                    upColor: '#c34042'
	                }
	            },
		        series: [{
		            name: marketName,
		            type: 'candlestick',
		            data: ohlc,
		            
		            tooltip: {
		            	headerFormat: '{point.x:%m:%d %H:%M}'
		            },
	                borderColor: '#dddddd'
		        }],
		        //툴팁을 좌상단에 고정시킴
		        tooltip: {
		            shape: 'square',
		            headerShape: 'callout',
		            borderWidth: 0,
		            shadow: false,
		            positioner: function (width, height, point) {
		                var chart = this.chart,
		                    position;

		                if (point.isHeader) {
		                    position = {
		                        x: Math.max(
		                            // Left side limit
		                            chart.plotLeft,
		                            Math.min(
		                                point.plotX + chart.plotLeft - width / 2,
		                                // Right side limit
		                                chart.chartWidth - width - chart.marginRight
		                            )
		                        ),
		                        y: point.plotY
		                    };
		                } else {
		                    position = {
		                        x: point.series.chart.plotLeft,
		                        y: point.series.yAxis.top - chart.plotTop
		                    };
		                }

		                return position;
		            }
		        },
		    });
	  }).catch(err => console.error(err));
}

</script>
</body>

</html>