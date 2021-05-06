<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<!--
[21-05-05]css를 분리시켜둔경우 수정후 바로 적용되지 않을 수 있다. 이는 브라우저 캐시에서 읽기때문이다.
따라서 브라우저가 새로운css라고 인식하도록 뒤에?after같은 문자열을 붙인다 꼭after일 필요는없이 문자가 붙으면 된다. 

배포할때는 적용안되지만 CTRL+SHIF+R을 하면 캐시까지 초기화하는 새로고침이 된다.
-->
<link href="/resources/css/globalCSS.css?abc" rel="stylesheet"> 
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<body>
<%@include file="header.jsp"%>
<div id="wrapbody" class="wrap body">

	<div class="container">
		<input type="text" id="testInput1"> <input type="text" id="testInput2">
		<button onclick="Test(this)">Go!</button> <button onclick="addItem(this)">ADDITEM!</button>
		
		<div class="row" id="coinList">
			
		</div>
		
		<div class="row">
			<div class="col-md-6">
			
			</div>
			<div class="col-md-6">
			
			</div>
		</div>
		
	</div>	
	
	
	<!-- [21-05-04] 리스트에 추가할 아이템 복제용 -->
	<div id="hiddenitemCode" style="display: none;">
		<div id="coinN" class="col-md-3 coinItem" onclick="coinClick(this)">
				<div class="row" id="itemToggle">
					<div class="col-md-3">
						<span class="marketName"></span>
						<span class="marketPrice">10000</span>
					</div>
					<div id="coinItemRight" class="col-md-9 d-flex-wrap">
						<div id="barWrap-item" class="col-md-12 d-inline-block">
							<div id="barBid-item">
							</div>
						</div>
						
						<div class="col-md-12 d-flex nop">
							<span id="bidVolumeSpan-item" class="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" class="col-md-6 text-right nop"></span>
						</div>
						
					</div>
				</div>
				<div class="abc"></div>
			</div>
	</div>
	<!-- [21-05-05] infoToggle분리 -->
	<div class="row" id="infoToggle">
				<div id="infoL" class="col-md-12">
					<div class="row">
					
						<!-- infoDiv의 왼쪽 [테이블]-->
						<div class="col-md-6 d-inline-block">
						
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
						<div class="col-md-6 d-inline-block nolp">
							
							<!-- infoDiv의 오른쪽 [코인이름] -->
							<div class="col-md-12 nop">
								<span id="tableCoinName"></span>
							</div>
							
							<!-- infoDiv의 오른쪽 [그래프] -->
							<div id="barWrap" class="col-md-12 d-inline-block">
								<div id="barBid">
								</div>
								<div id="barAsk" class="d-inline-block">
								</div>
							</div>
							
							<!-- infoDiv의 오른쪽 [거래량] -->
							<div class="col-md-12 d-flex nop">
								<span id="bidVolumeSpan" class="col-md-6 text-left nop"></span>
								<span id="askVolumeSpan" class="col-md-6 text-right nop"></span>
							</div>
							
						</div>
					
					</div>
				
				</div>
		
			</div>
	
	<div class="pushFooter"></div>
</div>
<%@include file="footer.jsp" %>

<script type="text/javascript">

//Ver.4
//0505이전버전 주요사항: 코인리스트 여러개 출력 / 헤더,풋터 틀잡기 / 리스트의 아이템 클릭시 토글기능[coinList의 내용비움, infoToggle도 분리]
//[21-05-05] 이번버전 주요사항: 코인리스트에 아이템 추가시 중복인지 체크해야함, 코인리스트 infoToggle이 열리더라도 보기좋게 그리드수정, infoToggle 내용보강

let arrAskId = new Array();
let arrBidId = new Array();

//21-05-03 코인별로 거래량을 받아서 매수,매도 그래프를 그릴때 사용해볼까함...
let XRPTotalVolume=0;
let XRPBidVolume=0;
let coinMap= new Map();

//[21-05-04] 리스트 체결내역 ID를 저장하기위한 배열과 맵.
//            - 임시로 어레이를 사용했는데 추후 볼륨을 저장한 방식과 동일하게 맵으로 변경해야함.
let arrAskIdList = new Array();
let arrBidIdList = new Array();
let arrIdMap= new Map();

//[21-05-04] tableCoinName = 체결테이블의 코인이름을 저장해두기 위한 변수. 수정이 필요할 것 같음 
//			 tableinterval = 재귀함수를 담아두었다가 종료를 시키기위한 변수
let tableCoinName="ETC";
let tableInterval=200;
let tableTimer="";

//[21-05-04] 컨트롤러에서 받아오는 리스트로 초기화시킴. 갯수에따라 조절하도록 html쪽도 수정해야함
let initListName = ${favCoin};
//[21-05-05] infoToggle을 밖으로 분리시키기위해 처음 상태를 담는 변수
//			 처음상태는 부모노드가 따로 없이 숨겨두므로
//			 코인아이템의 class를 바꾸고, display를 조정하는 등의 현재 작동방식을 스킵하기위해
//			 변수의 초기상태는 false로 한번이라도 작동을 하게되면 이후로는 true상태가 유지되게 설계.
let toggleStat=false;

//[21-05-05] 금액별 거래량필터를 설정하기위한 변수
let volumeFilter=100000;

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

//[21-05-05] 현재 클릭되어있는 아이템이 무엇인지 적용

$(function() {
    const wrap =  document.getElementsByClassName('wrap');
    document.body.style.background='#151e2e';
    
    //체결테이블 초기화 함수
    initTable();
    
	//[21-05-04] setListItem() 삭제 후 새로 만들어진 기능으로 대체
    //처음 설정때문에 쓴 코드. 완성되면 삭제해야함 [21-05-04 완성 다음버전에서 주석까지 삭제할것.]
    let index=1;
	if(initListName.length>0){
		initListName.forEach(i => {
			if(tradeTimerMap.get(i) != 'undefined')
	    	addItem(); // html 넣기.
	    	setItem(i); // 업비트 api 타이머 시작.
	    	addListItem(i, index); // 거래량 타이머 시작
	    	index++;
	    });
	}
    
});

function addItem(){
	var coinList = $('#coinList');
	var tempItem= $('#hiddenitemCode div#coinN');
	var num = Number(coinList.children().length)+1;
	var copyItem = tempItem.clone();
	copyItem.attr('id','coin'+num);
	copyItem.css('display','block');
	coinList.append(copyItem);
}

function Test(item){
	var Cname=$('#testInput1').val().toUpperCase();
	var Cnum=$('#testInput2').val().toUpperCase();
	
	// 코인추가하는 테스트 기능
	if( tradeTimerMap.get(Cname) === undefined ){
		setItem(Cname.toUpperCase());
		addListItem(Cname.toUpperCase(), Cnum);
	}else{
		//[21-05-05] *해결필요* 테스트용 메시지박스 삭제해야함
		alert("중복된 코인입니다.");
	}
	
	//*해결필요* 타이머 멈추는 기능 완성된코드로 옮겨놔야함
	// clearTimeout(timerMap.get('DOGE'));
}


//21-05-03 기존 체결표와 거래량을 아이템 안에 넣어두고, 아이템 클릭하면 크기가 변하도록 하기위해 onClick이벤트.
function coinClick(item){
 	
	//코인 상세정보(infoToggle)가 어디에 출력되는가에 상관없이 초기화부터 시켜줌.
	document.getElementById('infoToggle').style.display="none";
	
	//[21-05-05] 초기상태는 infoToggle을 밖으로 분리시켰기 때문에 coinItem의 크기를 변경 할 필요가 없다. 그 이후로만 실행되도록.
	if(toggleStat){
		//코인 상세정보(infoToggle)를 다시 옮기기전에 이전에 있던 아이템div의 크기를 원래대로 돌리고, display속성도 원래대로 돌림.
		document.getElementById('infoToggle').parentNode.parentNode.className="col-md-3 coinItem";
		document.getElementById('infoToggle').parentNode.parentNode.style.height="50px";
		document.getElementById('infoToggle').parentNode.parentNode.childNodes[1].style.display="flex";
	}else{
		toggleStat=true;
	}

	//코인 상세정보(infoToggle) div를 잘라내서 클릭한 아이템의 div로 붙여넣기함
	let deta = $('#infoToggle').detach();
	$("#" + item.id + " .abc").append(deta);
	
	//아이템 누를때마다 토글처리
	let nodes = document.getElementById(item.id).childNodes;
	if(document.getElementById('infoToggle').style.display == 'none'){
		item.className="col-md-6 coinItem order-first";
		item.style.height="100%";
		nodes[3].style.display="block";
		document.getElementById('infoToggle').style.display="flex";
		nodes[1].style.display="none";
	}
	
	//[21-05-04] 재귀함수 호출을 중지시킨 후 선택된 코인의 이름으로 조회 시작
	initTable();
	clearTimeout(tableTimer);
	//[21-05-04] 클릭한 코인의 코인명을 가져옴
	tableCoinName=$('#'+item.id+" .marketName").html()
	
	tableTimer = setTimeout("setUpbitData(\'"+tableCoinName+"\')", tableInterval);
}

//[21-05-04] 리스트 내 아이템의 그래프를 그려주기 위한 함수
function setItem(coinName){
	coinName=coinName.toUpperCase();
	//[21-05-05] 맵에 coin이라는 객체를 넣는 방식으로 변경. 다음버전에서 삭제할것 *해결필요*
	//[21-05-04] map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
	//let keyNameTotal=coinName+'TotalVolume';
    //let keyNameBid=coinName+'BidVolume';
    
    //[21-05-04] 코인이름을 매개변수로 보내는 함수(getTrade)를 통해 체결내역을 받아온다.
	let arrResult = new Array();
    arrResult=getTrade(coinName);	
	
	//[21-05-05] 업비트API로 불러올 때 에러가 생겨 불러오지 못하면 바로 탈출하도록.
	if(arrResult.length<1) return;
	
	//[21-05-05] 코인의 가격에따라 미리 설정해둔 필터값 이상의 거래만 출력되도록.
	tmpVol= volumeFilter/arrResult[0].trade_price;
	
	//[21-05-05] coin이라는 객체에 정보를 담아서 맵에 넣는방식으로 변경
	let tmpCoin = new coin("",0,0,0);
	if( coinMap.get(coinName) != undefined ){
		tmpCoin = coinMap.get(coinName);
	}
	
	arrResult.forEach(item => {
		
		if(item.trade_volume>=tmpVol){
       		//체결번호, 유일성체크 가능
       		const checkId=item.sequential_id;
       		//볼륨 소수점 버림처리
       		const volume=Math.floor(item.trade_volume);
       		//매수매도 구분
       		const askbid=item.ask_bid;
       		
   			// - 21-05-03 비교방식변경 => 체결내역에 고유한 ID가 있었음 그걸 이용해 비교.
       		if( (askbid=='ASK') && (arrAskIdList.indexOf(checkId) == -1) ){
       			if(arrAskIdList.length>500){
       				arrAskIdList.shift();
       			}
   	        	arrAskIdList.push(checkId);
   	        	
   	      		// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        	//  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
   	        	if(tmpCoin.totalVolume==undefined){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	        	tmpCoin.totalVolume += volume;
   	        	
       		}else if( (askbid=='BID') && (arrBidIdList.indexOf(checkId) == -1) ){
       			if(arrBidIdList.length>500){
       				arrBidIdList.shift();
       			}
   	        	arrBidIdList.push(checkId);
   	        	
   	        	// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        	//  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
   	        	
   	        	if(tmpCoin.totalVolume==undefined){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	        	if(tmpCoin.bidVolume==undefined){
   	        		tmpCoin.bidVolume='0';
   	        	}
   	        	tmpCoin.totalVolume += volume;
   	        	tmpCoin.bidVolume += volume;
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
	//[21-05-05] 아이템의 업비트API 타이머를 담는 맵. => 아이템 삭제시 타이머를 중지시키기 위해 필요.
	tradeTimerMap.set(coinName, setTimeout("setItem(\'"+ coinName +"\')", 1000) );
}

//[21-05-04] 코인리스트 아이템의 값을 넣어주는 함수
function addListItem(coinName, num){
	coinName=coinName.toUpperCase();
	let span=$('#coin'+ num +' .marketName');
	span.html(coinName);
	
	if( coinMap.get(coinName) != undefined && coinMap.get(coinName) != undefined ){
		
		let totalVolume=Number(coinMap.get(coinName).totalVolume);
		let bidVolume=Number(coinMap.get(coinName).bidVolume);
		
		let bar=$('#coin'+ num +' #barBid-item');
		bar.css('width',((bidVolume/totalVolume)*100)+'%')
		
		let bidSpan=$('#coin'+ num +' #bidVolumeSpan-item');
		bidSpan.html((bidVolume/1000).toFixed(2)+"K");
		let bar2=$('#coin'+ num +' #barAsk-item');
		let askSpan=$('#coin'+ num +' #askVolumeSpan-item');
		askSpan.html(((totalVolume-bidVolume)/1000).toFixed(2)+"K");
	}
	
	//[21-05-04] setTimeout을 이용해 재귀함수를 사용할 때,
	//			매개변수를 사용하게 된다면 **** 각 변수마다 따옴표를 **** 씌워줘야한다.
	//			그렇지 않으면 매번 불러올때마다 변수값이 이상하게 추가되어
	//			coinName,num,undefined 이런식으로 매개변수를 넘기게되므로 오류가 발행한다.
	//[21-05-05] 아이템의 정보갱신 타이머를 담는 맵. => 아이템 삭제시 타이머를 중지시키기 위해 필요.
	updateTimerMap.set(coinName, setTimeout('addListItem(\"'+coinName+ '\",\"' +num+'\")', 1000));
	
	// [21-05-05] 기능 추가후 주석처리 다음버전에서 *삭제*.
	// setTimeout('addListItem(\"'+coinName+ '\",\"' +num+'\")', 1000 );
}


//21-05-04 체결테이블의 데이터를 계산하는 내용은 함수로 따로 빼야할 것 같음.
//         -이 함수는 코인의 이름을 매개변수로 받아서 체결량만 계산하는 함수로 수정 할 예정.
//21-05-03 ajax를 통해 값을 받아오는 함수를 새로 만들고, 이 함수에서는 ajax제거.[21-05-03해당작업 완료]
function setUpbitData(coinName){
	coinName= coinName.toUpperCase();
	//ASK = 매수 / BID = 매도 ??? X 아래 설명 다시참고
	//BID가 높은가격 == 위에 가격을 긁었다고 생각하면 이게 빨간색 매수로 표현이 되어야한다.
	//ASK가 낮은가격 == 아래 가격에 던졌다고 생각하면 이게 파란색 매도로 표현이 되어야한다.
	//BID == 호가창에 제시된 매수 할 수 있는 가격
	//ASK == 호가창에 제시된 매도 할 수 있는 가격
	
	//[21-05-05] 맵에 coin이라는 객체를 넣는 방식으로 변경. 다음버전에서 삭제할것 *해결필요*
	//[21-05-04] map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
	//let keyNameTotal=coinName+'TotalVolumeTable';
    //let keyNameBid=coinName+'BidVolumeTable';
    
    //[21-05-05] coin(name, price, bidVolume, totalVolume)
    //			 기존방식= '코인이름BidVolume', '코인이름TotalVolume'이런식으로 맵에 넣어서 사용했었는데,
    //			 coin이라는 객체를 만들고, 거기에 정보를 담은 다음 코인이름을 키값으로, coin객체를 값으로 넣는 방식으로 변경.
    let tmpCoin=new coin("",0,0,0);
    if( coinMap.get(coinName+"Table") != undefined ){
		tmpCoin = coinMap.get(coinName);
	}
    
    //[21-05-04] 테이블의 코인 이름을 수정해줌.
    $('#tableCoinName').html(coinName);
    
	//**********************************
	// 21-05-03 함수 호출시 매개변수로 코인이름 받아오도록 수정해야함 
	//**********************************
	let arrResult = new Array();
	arrResult=getTrade(coinName);

	
	//[21-05-05] 업비트API로 불러올 때 에러가 생겨 불러오지 못하면 바로 탈출하도록.
	if(arrResult.length<1) return;
	
	//[21-05-05] 코인의 가격에따라 미리 설정해둔 필터값 이상의 거래만 출력되도록.
	let tmpVol= volumeFilter/arrResult[0].trade_price;
	arrResult.forEach(item => {
		if(item.trade_volume>=tmpVol){
       		//체결번호, 유일성체크 가능
       		const checkId=item.sequential_id;
       		//체결시간
       		const time=item.trade_time_utc;
       		//볼륨 소수점 버림처리
       		let volume=0;
       		if(Math.floor(item.trade_volume)<=10){
       			volume=(item.trade_volume).toFixed(3);
       		}else{
       			volume=Math.floor(item.trade_volume);
       		}
       		
       		//가격
       		const price=item.trade_price;
       		//매수매도 구분
       		const askbid=item.ask_bid;
       		
       		// 이전 체결시간, 볼륨과 비교해 같은 주문인지 확인
   			// - 21-05-03 비교방식변경 => 체결내역에 고유한 ID가 있었음 그걸 이용해 비교.
       		if( (askbid=='ASK') && (arrAskId.indexOf(checkId) == -1) ){
       			if(arrAskId.length>100){
       				arrAskId.shift();
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
   	        	asknewCell3.innerText = addComma(Math.floor(volume));
   	        	asknewCell4.innerText = askbid;
   	        	asknewCell5.innerText = checkId;
   	        	arrAskId.push(checkId);
   	        	
   	      		// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        	//  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
   	        	if(tmpCoin.totalVolume==undefined || Number(tmpCoin.totalVolume)<0 ){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	      		
   	      		// 체결테이블의 거래량은 따로 계산해야 함 ( 리스트의 아이템과 중복으로 계산 됨 )
   	      		tmpCoin.totalVolume += Math.floor(volume);
   	      		
   	        	//N(7)줄이 넘어가면 첫번째 행 삭제
   	        	if(asktable.tBodies[0].rows.length >7){
   	        		asktable.deleteRow(7);
   	        	}
       			
   	        	
   	      	// 이전 체결시간, 볼륨과 비교해 같은 주문인지 확인
    		// - 21-05-03 비교방식변경 => 체결내역에 고유한 ID가 있었음 그걸 이용해 비교.
       		}else if( (askbid=='BID') && (arrBidId.indexOf(checkId) == -1) ){
       			       			
       			if(arrBidId.length>100){
       				arrBidId.shift();
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
   	        	bidnewCell3.innerText = addComma(volume);
   	        	bidnewCell4.innerText = askbid;
   	        	bidnewCell5.innerText = checkId;
   	        	arrBidId.push(checkId);
   	        	
   	        	// 21-05-04 코인이름에따라 변수명이 달라짐. 하지만 변수선언할 때 이름에 변수를 사용 할 수 없음.
   	        	//  - map을 활용해 변수명대신 키값으로 사용. 키값에는 변수를 사용할 수 있음.
   	        	if(tmpCoin.totalVolume==undefined || Number(tmpCoin.totalVolume)<0){
   	        		tmpCoin.totalVolume='0';
   	        	}
   	        	if(tmpCoin.bidVolume==undefined || Number(tmpCoin.bidVolume)<0){
   	        		tmpCoin.bidVolume='0';
   	        	}
   	        	
   	      		// 체결테이블의 거래량은 따로 계산해야 함 ( 리스트의 아이템과 중복으로 계산 됨 )
   	        	tmpCoin.totalVolume+=Number(Math.floor(volume));
   	        	tmpCoin.bidVolume+=Number(Math.floor(volume));
   	        	
   	        	//N(7)줄이 넘어가면 첫번째 행 삭제
   	        	if(bidtable.tBodies[0].rows.length >7){
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
		
		// 코인 상세정보(infoToggle)의 오른쪽 코인의 그래프 
		var bar=document.getElementById('barBid');
     	bar.style.width=((bidVolume/totalVolume)*100)+'%';
     	var bidspan=document.getElementById('bidVolumeSpan');
     	bidspan.innerText = (bidVolume/1000).toFixed(2)+"K";
     	var bar2=document.getElementById('barAsk');
     	var askspan=document.getElementById('askVolumeSpan');
     	askspan.innerText = ((totalVolume-bidVolume)/1000).toFixed(2)+"K";
	});
	coinMap.set(coinName+'Table',tmpCoin);
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
		  	url: "https://api.upbit.com/v1/trades/ticks?count=10&market=KRW-"+coinName,
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
	for(var i=0; i<7; i++){
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
       	
       	if(initBidTable.tBodies[0].rows.length >7){
       		initBidTable.deleteRow(0);
       	}
       	if(initAskTable.tBodies[0].rows.length >7){
       		initAskTable.deleteRow(0);
       	}
	}
} 

function addComma(num){
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
     
</script>
</body>

</html>