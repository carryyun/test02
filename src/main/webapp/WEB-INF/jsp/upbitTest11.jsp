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
<link href="/resources/yun/cms/css/globalCSS.css" rel="stylesheet"> 
<link href="/resources/yun/cms/css/bootstrap.css" rel="stylesheet"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>


<body>
<div id="reactRoot" style="background: #fff">
		
</div>

<!-- <%@include file="header.jsp"%> -->
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
									
									<!-- <div class="col-md-12 d-flex flex-wrap">
										<span class="col-md-4">종가</span>
										<span class="col-md-8 text-right" style="text-align: right">1,000,000</span>
									</div>
									<div class="col-md-12 d-flex flex-wrap">
										<span class="col-md-4"></span>
										<span class="col-md-8 text-right" style="text-align: right">+ 50%</span>
									</div>
									<div class="col-md-12 d-flex flex-wrap">
										<span class="col-md-4">기타</span>
										<span class="col-md-8 text-right" style="text-align: right">텍스트</span>
									</div> -->
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
									
									<div class="col-md-12">
										<div id="depthChart">
										</div>
									</div>
								</div>
								
								<div class="col-md-1 mb-10 p-10 greyPane fs-20 text-center">
									<span>옵</span><br/>
									<span>션</span><br/>
									<span> <i id="favoriteIcon" class="far fa-star"></i> </span><br/>
									<!-- 채우기없는 별 far fa-star 채워진 별 fas fa-star -->
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
				<div class="row pl-10 pr-10 position-relative" id="coinListAll">
				</div>
				<div class="row pl-10 pr-10 position-relative" id="coinList">
				</div>
			</div>
		</div>
		
		<!-- [21-05-09] 사용자가 즐겨찾기에 넣을 수 있도록 전체코인 리스트를 출력 (추가해야할지 말아야할지)-->
		<div class="row mt-10 justify-content-around darkBluePane">
			
		</div>
	</div>	
	
	<!-- [21-05-04] 리스트에 추가할 아이템 복제용 -->
	<div id="hiddenitemCode" style="display: none;">
		<div id="coinN" class="col-md-12 coinItem" onclick="itemClick(this)">
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

<%-- <%@include file="footer.jsp" %> --%>

<!-- 차트에 필요한js -->
<script src="https://code.highcharts.com/stock/highstock.js"></script>
<script src="https://code.highcharts.com/stock/modules/data.js"></script>
<script src="https://code.highcharts.com/stock/modules/drag-panes.js"></script>
<!-- 차트를 그림저장, 인쇄 시켜주는모듈 -->
<!-- <script src="https://code.highcharts.com/stock/modules/exporting.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

<script crossorigin src="https://unpkg.com/react@17/umd/react.development.js"></script>
<script crossorigin src="https://unpkg.com/react-dom@17/umd/react-dom.development.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>

<script type="text/babel">

let result = window.babelTest("hi");
console.log(result);

class Welcome extends React.Component {
	render() {
		return <h1>Hello, {this.props.name}</h1>;
	}
}
const ele7 = <Welcome name="sola" />;
ReactDOM.render(
	ele7,
	document.getElementById('reactRoot')
);

/* <div><a className="removeItemBtn fs-11" href="#"><i className="fas fa-trash-alt"></i></a>
				</div>  */

class Listitem extends React.Component {
	state = {
		number : 0,
	}

	testClick = () => {
		this.setState({
			number : this.state.number + 1
		})

		console.log(this.state.number);

	}

	render(){
		const sty = {
			display : 'block'
		};
		
		return (
			<div style={sty} className="col-md-12 coinItem" onClick={this.testClick} >
				
				<div className="row" id="itemToggle">
					<div className="col-md-3">
						<span className="marketName">{this.props.marketName}</span><br/>
						<span className="marketPrice">{this.props.marketPrice}</span>
					</div>
					<div id="coinItemRight" className="col-md-9 d-flex-wrap">
						<div id="barWrap-item" className="col-md-12 d-inline-block">
							<div id="barBid-item">
							</div>
						</div>
						
						<div className="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" className="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" className="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" className="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" className="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div className="abc"></div>
					
			</div>

		);

	}		

}

const element = <Listitem marketName="솔라" marketPrice="100000" />;

const Itemsadd = ({value}) =>(
	<span>
		<h1>{value}</h1>
	</span>
)
const ArrEle = () => {
	const arrTest = ${clistCode};

	return(
		<div>
			{arrTest.map( (name,index) => (
				<Itemsadd key={index} value={name} />
			))}
		</div>
	);

}

const Ele10 = () => {
	const [curColor, setColor] = React.useState('white');

	const colorBlue = () => {
		setColor('blue');
	}
	const colorRed = () => {
		setColor('red');
	}

	return(
		<div>
			<h1 style={{color:curColor}}>테스트</h1>
			<button onClick={colorBlue}>블루</button>
			<button onClick={colorRed}>레드</button>
		</div>
	);
}


const Ele11 = () => {
	const dataArr = ${clistCode};
	const sty = {
		display: 'block',
	}
	return(
		<div>
		{dataArr.map( (name,index) => (
			<div key={index} style={sty} className="col-md-12 coinItem">
				
				<div className="row" id="itemToggle">
					<div className="col-md-3">
						<span className="marketName">{name.substr(4,name.length)}</span><br/>
						<span className="marketPrice">{index}</span>
					</div>
					<div id="coinItemRight" className="col-md-9 d-flex-wrap">
						<div id="barWrap-item" className="col-md-12 d-inline-block">
							<div id="barBid-item">
							</div>
						</div>
						
						<div className="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" className="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" className="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" className="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" className="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div className="abc"></div>
					
			</div>
		))}
		</div>

	)
}

const Ele12 = () => {
	const dataArr = Array.from(coinDataMap.values());
	const sty = {
		display: 'block',
	}
	return(
		<div>
		{dataArr.map( (obj,index) => (
			<div key={index} style={sty} className="col-md-12 coinItem">
				
				<div className="row" id="itemToggle">
					<div className="col-md-3">
						<span className="marketName">{obj.code.substr(4,obj.code.length)}</span><br/>
						<span className="marketPrice">{_.first(obj.tradeArr).price}</span>
					</div>
					<div id="coinItemRight" className="col-md-9 d-flex-wrap">
						<div id="barWrap-item" className="col-md-12 d-inline-block">
							<div id="barBid-item">

							</div>
						</div>
						
						<div className="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" className="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" className="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" className="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" className="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div className="abc"></div>
					
			</div>
		))}
		</div>

	)
}

const Ele13 = data => {
	
	const dataArr = Array.from(data.data.values());
	// useState로 바꿔야하는가? 

	const sty = {
		display: 'block',
	}
	return(
		<div>
		{dataArr.map( obj => (
			<div key={obj.code} style={sty} className="col-md-12 coinItem">
				
				<div className="row" id="itemToggle">
					<div className="col-md-3">
						<span className="marketName">{obj.code.substr(4,obj.code.length)}</span><br/>
						<span className="marketPrice">{_.first(obj.tradeArr).price}</span>
					</div>
					<div id="coinItemRight" className="col-md-9 d-flex-wrap">
						<div id="barWrap-item" className="col-md-12 d-inline-block">
							<div id="barBid-item">

							</div>
						</div>
						
						<div className="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" className="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" className="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" className="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" className="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div className="abc"></div>
					
			</div>
		))}
		</div>

	)
}
const Ele15 = data => {
	// 배열로 넘어온 값을 처리할 방법? const [name, setName] = useState(); 
	const [code, setCode] = React.useState('');
	const dataArr = Array.from(data.data.values());
	
	React.useEffect(() => {
		
  	});

	const sty = {
		display: 'block',
	}
	return(
		<div>
		{dataArr.map( obj => (
			<div key={obj.code} style={sty} className="col-md-12 coinItem">
				
				<div className="row" id="itemToggle">
					<div className="col-md-3">
						<span className="marketName">{setCode( obj.code.substr(4,obj.code.length) ) }{code}</span><br/>
						<span className="marketPrice">{_.first(obj.tradeArr).price}</span>
					</div>
					<div id="coinItemRight" className="col-md-9 d-flex-wrap">
						<div id="barWrap-item" className="col-md-12 d-inline-block">
							<div id="barBid-item">

							</div>
						</div>
						
						<div className="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" className="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" className="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" className="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" className="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div className="abc"></div>
					
			</div>
		))}
		</div>

	)
}
const Ele14 = data => {
	//실패
	// 배열로 넘어온 값을 처리할 방법? const [name, setName] = useState(); 
	const [datamap, setDatamap] = React.useState(data.data);
	window.setDatamap = setDatamap;
	
	const dataArr = Array.from(datamap.values());
	
	React.useEffect(() => {
		console.log(datamap);
  	});

	const sty = {
		display: 'block',
	}
	return(
		<div>
		{dataArr.map( obj => (
			<div key={obj.code} style={sty} className="col-md-12 coinItem">
				
				<div className="row" id="itemToggle">
					<div className="col-md-3">
						<span className="marketName"> {obj.code.substr(4,obj.code.length)}</span><br/>
						<span className="marketPrice">{_.first(obj.tradeArr).price}</span>
					</div>
					<div id="coinItemRight" className="col-md-9 d-flex-wrap">
						<div id="barWrap-item" className="col-md-12 d-inline-block">
							<div id="barBid-item">

							</div>
						</div>
						
						<div className="col-md-12 d-flex flex-wrap nop ">
							<span id="bidVolumeSpan-item" className="col-md-6 text-left nop"></span>
							<span id="askVolumeSpan-item" className="col-md-6 text-right nop"></span>
							<span id="bidVolumePerSpan-item" className="col-md-6 text-left"></span>
							<span id="askVolumePerSpan-item" className="col-md-6 text-right"></span>
						</div>
						
					</div>
				</div>
				<div className="abc"></div>
					
			</div>
		))}
		</div>

	)
}



function ren(dataMap){

	ReactDOM.render(
	<Ele14 data={dataMap} />,
	/* document.getElementById("coinListAll") */
	document.getElementById("coinListAll")
	);
}



</script>

<script type="text/javascript">
function babelTest(a){
	return a;
}

//Ver.9
//0510이전버전: 코인리스트 여러개 출력 / 헤더,풋터 틀잡기 / 리스트의 아이템 클릭시 토글기능[coinList의 내용비움, infoToggle도 분리]
//					코인리스트에 아이템 추가시 중복인지 체크해야함, 코인리스트 infoToggle이 열리더라도 보기좋게 그리드수정, infoToggle 내용보강,
//					코인상세정보 채우기
//[21-05-10] 이번버전 주요사항: 

	
//[21-05-07] 체결내역의 유일성을 검증할 때 사용하는 Array를 Map에 저장하여 코인별로 사용 가능하도록 수정
let idMap=new Map();

//[21-05-04] tableCoinName = 체결테이블의 코인이름을 저장해두기 위한 변수. 수정이 필요할 것 같음 
let tableCoinName="";

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
let listAllCode = ${clistCode};

//[21-05-09] 금액별 거래량필터를 설정하기위한 변수
//[21-05-05] 금액별 거래량필터를 설정하기위한 변수
let volumeFilter=100000;
let priceFilter=1000000;

//[21-05-05] 현재 클릭되어있는 아이템이 무엇인지 적용
let curItem="";

//[21-05-09] 검색기능 전체목록과 즐겨찾기목록중 선택된 곳에서 작동하도록 하기위해 변수로 체크
// true=전체 false 즐겨찾기
let searchSelector=true;

//[21-05-12] 마켓뎁스를 위한 호가정보 저장배열
let bidorder=new Array();
let askorder=new Array();

//[21-05-12] 전체목록, 즐겨찾기 탭을 관리하는 매니저클래스
class TabManager{
	constructor(arr){
		this.tabPages= [ $('#coinListAll'), $('#coinList') ];
	}
	
	showAll(tabIndex){
		let child=this.tabPages[tabIndex].children();
		
		let getFirst=(_.first(Array.from(child)).id).substr(4, _.first(Array.from(child)).id.length );
		let getLast=_.last(Array.from(child)).id.substr(4, _.last(Array.from(child)).id.length );
		
		Array.from(child).forEach(obj => {
			obj.style.display='block';
		} )
	}
	
	search(text,tabIndex){
		let child=this.tabPages[tabIndex].children();
		
		let getFirst=(_.first(Array.from(child)).id).substr(4, _.first(Array.from(child)).id.length );
		let getLast=_.last(Array.from(child)).id.substr(4, _.last(Array.from(child)).id.length );
		
		let input=text.toUpperCase();
		if(input == ""){
			for(let i=getFirst; i<=getLast; i++){
				$('#coin'+i).css('display','block');
			}
			return;
		}
		for(let i=getFirst; i<=getLast; i++){
			let item=$('#coin'+i+" .marketName").html();
			if(item.indexOf(input) != -1){
				$('#coin'+i).css('display','block');
			}else{
				$('#coin'+i).css('display','none');
			}
		}
	}
}
const tabManager = new TabManager();

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
	
	*/
	
	/* var worker = new Worker( '/resources/yun/cms/js/worker.js' );
	worker.postMessage( '워커 실행' );  // 워커에 메시지를 보낸다.
	// 워커로 부터 메시지를 수신한다.
	worker.onmessage = function( e ) {
	    console.log('호출 페이지 - ', e.data );
	}; */
	window.ren(coinDataMap);
	/* tabManager.showAll(0);
	tabManager.search("BT",0); */
}

function openSocket(){
	let socket = new WebSocket("wss://api.upbit.com/websocket/v1");
	socket.binaryType = "arraybuffer";
	return socket;
}
tableCoinName="KRW-BTC";

function getTradeData(){
	let socket = openSocket();
	
	socket.onopen = event =>{
		let msg = [
			{
			ticket : "ANY_TEXT",
			},{
			type : "trade",
			// codes의 형식 : ["KRW-BTC","KRW-XRP","KRW-ETC","KRW-QTUM"]
			codes : listAllCode
			}
		];
		
		socket.send(JSON.stringify(msg));
	};
	
	socket.onmessage = event => {
		
		let enc = new TextDecoder("utf-8");
		let arr = new Uint8Array(event.data);
		let data = JSON.parse(enc.decode(arr));
		//[21-05-11] 들어오는 코인의 데이터를 coinData클래스에 담아주는 함수
		setCoinData(data);
		//[21-05-10] 선택된 코인은 테이블업데이트 해주는 함수에 바로 보내줌
		if(data.code==tableCoinName){
			setInfoData(coinDataMap.get(tableCoinName));
		}
		if(initListName != null){
			if( initListName.indexOf(data.code.substr(4,data.code.length)) != -1 )
				updateItem(coinDataMap.get(data.code),1);
		}
		
		updateItem(coinDataMap.get(data.code),0);
		/* socket.close(); */
		if(window.setDatamap !== undefined){
			/* console.log(typeof window.setDatamap); */
			window.setDatamap(coinDataMap);
		}
			
	}
	// 발견된 문제?
	// 웹소캣으로 계속 데이터를 받으면 속도저하등의 문제는 없는지?
}

//FIXME 전체목록인지 즐겨찾기의 목록인지 구분해서 실행하도록.
function updateItem(coindata, tabIndex){
	if(coindata==null) return;
	let num;
	if(tabIndex==0)
		num = listAll.findIndex( obj => obj.market == coindata.code.substr(4,coindata.code.length) );
	else{
		if(initListName==null) return;
		num = initListName.indexOf(coindata.code.substr(4,coindata.code.length) )+listAll.length;
	}
	let listId = "#coin"+num;
	
	let span=$(listId +' .marketName');	
	span.html(coindata.code.substr(4,coindata.code.length));
	
	let lastTrade = _.last(coindata.tradeArr);
	let span2=$(listId +' .marketPrice');
	span2.html( addComma(lastTrade.price) );
	
	let totalVolume=Number(coindata.totalVolume);
	let bidVolume=Number(coindata.bidVolume);
	let askVolume=Number(coindata.askVolume);
	
	let bar=$(listId +' #barBid-item');
	bar.css('width',((bidVolume/totalVolume)*100)+'%')
	
	let bidSpan=$(listId +' #bidVolumeSpan-item');
	let askSpan=$(listId +' #askVolumeSpan-item');
	let bar2=$(listId+ num +' #barAsk-item');
	
	//[21-05-06] 그래프에 퍼센트 추가.
	let bidPerSpan=$(listId +' #bidVolumePerSpan-item');
	let askPerSpan=$(listId +' #askVolumePerSpan-item');
	let bidPer, askPer;
	bidPer=( (bidVolume/totalVolume)*100 ).toFixed(1)+"%";
	askPer=( (askVolume/totalVolume)*100 ).toFixed(1)+"%";
	
	/* bidPerSpan.html( bidPer );
	askPerSpan.html( askPer ); */
	
	let bid, ask;
	if(lastTrade.price > priceFilter){
		bidPerSpan.html( bidPer );
		askPerSpan.html( askPer );
		//FIXME 코인의 가격이 큰경우 볼륨을 소수점3자리까지 표시하기위해 priceFilter조건을 줬음. askVolume.toFixed(3) bidVolume.toFixed(3)
	}else{
		if( (bidVolume>1000000) ) bid = (bidVolume/1000000).toFixed(2)+"M";
     	else if( (bidVolume>1000) ) bid = addComma( (bidVolume/1000).toFixed(2) )+"K";
     	else bid = addComma( Number(bidVolume).toFixed(2) );
		bidPerSpan.html(bidPer);
     	
     	if( askVolume>1000000 )  ask = (askVolume/1000000).toFixed(2)+"M";
     	else if( askVolume>1000 ) ask = addComma( (askVolume/1000).toFixed(2) )+"K";
     	else ask = addComma( askVolume.toFixed(2) );
     	askPerSpan.html(askPer);
	}
	//[21-05-11] FIXME 거래량과 가격을 그래프 아래로 적어야할 것 같음. 그래프에는 %만 표시 계산된 값은 ask, bid 변수안에 있음
	//			 기존의 마켓코드 자리에는 한글이름을, 가격자리에는 마켓코드를 출력하는것으로 변경할것
}

function setCoinData(data){
	if(data == null) return;
	let idArr=new Array();
	if( idMap.get(data.code) != undefined ) idArr = idMap.get(data.code);
	
	//[21-05-10] *해결필요* codin setInfoData와 반복되는 내용이니 함수로 따로 빼야함.
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
	
	coinDataMap.set(data.code, coindata);
	
}

function setInfoData(coindata){
	if(coindata==null) return;
	let idArr=new Array();
	if( idMap.get(coindata.code) != undefined) idArr= idMap.get(coindata.code);
	
	//[21-05-11] lodash.js 추가 _.last(배열) = 배열의 마지막요소
	//lastTrade = coindata.tradeArr[coindata.tradeArr.length-1];
	lastTrade=_.last(coindata.tradeArr);
	$('#tableCoinName').html(coindata.code.substr(4,coindata.code.length));
	let filter= volumeFilter/lastTrade.price;
	if(lastTrade.volume>=filter){
   		let checkId=lastTrade.id;
   		let volume=lastTrade.volume;
   		let time=lastTrade.time;
   		let askbid=lastTrade.askbid;
   		let price=lastTrade.price;
   		
   		if( idArr.indexOf(checkId) == -1 ){
   			if(idArr.length>200){
   				idArr.shift();
   			}
   			let table;
   			let newRow;
   			if(askbid=='ASK'){
   				table =  document.getElementById('askTable');
   				newRow = table.insertRow(0);
   			}else{
   				table =  document.getElementById('bidTable');
   				newRow = table.insertRow();
   			}
   			newRow.className = askbid.substr(0,3)+'tr';
        	const newCell1 = newRow.insertCell(0);
        	newCell1.className = 'tradeTime';
        	const newCell2 = newRow.insertCell(1);
        	newCell2.className = 'tradePrice';
        	const newCell3 = newRow.insertCell(2);
        	newCell3.className = 'tradeVolume';
        	const newCell4 = newRow.insertCell(3);
        	newCell4.className = 'tradeAskbid';
        	const newCell5 = newRow.insertCell(4);
        	newCell5.className = 'tradeId';
   			
        	newCell1.innerText = time;
        	newCell2.innerText = addComma(price);
        	if(price > priceFilter){
        		newCell3.innerText = Number(volume).toFixed(3);	
        	}else{
        		newCell3.innerText = addComma(Math.floor(volume));
        	}
        	newCell4.innerText = askbid;
        	newCell5.innerText = checkId;
        	idArr.push(checkId);
	      	
        	askTable=document.getElementById('askTable');
        	bidTable=document.getElementById('bidTable');
        	//N(7)줄이 넘어가면 첫번째 행 삭제
        	if(askTable.tBodies[0].rows.length >9){
        		askTable.deleteRow(9);
        	}
        	if(bidTable.tBodies[0].rows.length >9){
        		bidTable.deleteRow(0);
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
	idMap.set(coindata.code,idArr);
}

function itemClick(item){
	//[21-05-05] 현재 선택된 코인이면 스킵하도록함.
	if(curItem==item.id) return;
	
	let selected = document.getElementsByClassName("selectedItem")[0];
	if(selected != null){
		document.getElementsByClassName("selectedItem")[0].className="col-md-12 coinItem";	
	}
	item.className="col-md-12 coinItem selectedItem";
	
	initTable();
	
	//[21-05-04] 재귀함수 호출을 중지시킨 후 선택된 코인의 이름으로 조회 시작
	
	let selectedItem;
	selectedItem="#"+item.id+" .marketName";
	curItem=item.id; //FIXME 쓰이는 변수인지?
	tableCoinName="KRW-"+$(selectedItem).html();
	setInfoText(tableCoinName);
	initChart( tableCoinName.substr(4,tableCoinName.length) );
}

$(function() {
    const wrap =  document.getElementsByClassName('wrap');
    document.body.style.background='#151e2e';
    //체결테이블 초기화 함수
    initTable();
    
	//[21-05-06] 코인의 누적된 거래량을 일정량씩 삭제해주는 함수.
	//burn();
	
	for(let i=0; i<listAll.length;i++){
		// addItem(0);
	}
	if(${sessionScope.curUser != null}){
		if(initListName.length>0){
			initListName.forEach(i => {
		    	// addItem(1); // addItem(tabIndex); 0:전체목록 1:즐겨찾기
		    	// updateItem(coinDataMap.get("KRW-"+i),1);
		    });
		}
	}
	getTradeData();
	//[21-05-06] 코인상세정보에 필요한 코인가격의 세부정보를 가져옴.
	//[21-05-10] 따로 빼야함 웹소캣으로 체결내역이 들어올때마다 실행하게됨.
	setInfoText("KRW-BTC");
	initChart("BTC");
	temp();
	
	initEventListener();
});

function setInfoText(code){
	$('#tableCoinName').html(code.substr(4,code.length));
	
	let options = {method: 'GET'};
	fetch('https://api.upbit.com/v1/ticker?markets='+code, options)
	  .then(response => response.json())
	  .then(response => {
		  response=response[0];
		  document.getElementById('tableCoinOpenValue').innerHTML = addComma(response.opening_price);
		  document.getElementById('tableCoinHighValue').innerHTML = addComma(response.high_price);
		  document.getElementById('tableCoinLowValue').innerHTML = addComma(response.low_price);
	  })
	  .catch(err => console.error(err));	
	
	if(initListName==null) return;
	// #favorite 채우기없는 별 far fa-star 채워진 별 fas fa-star
	if( initListName.indexOf(code.substr(4,code.length)) != -1 ){
		document.getElementById('favoriteIcon').className="fas fa-star";
		// document.getElementById('favoriteIcon').style.color="#321ED6";
	}else{
		document.getElementById('favoriteIcon').className="far fa-star";
		// document.getElementById('favoriteIcon').style.color="#eee";
	}
}

function addItem(tabIndex){
	let tab = tabManager.tabPages[tabIndex];
	let tempItem= $('#hiddenitemCode div#coinN');
	let num = Number(tabManager.tabPages[0].children().length) + Number(tabManager.tabPages[1].children().length);
	let copyItem = tempItem.clone();
	copyItem.attr('id','coin'+num);
	if(num==0){
		copyItem.attr('class','col-md-12 coinItem selectedItem');
		curItem=copyItem[0].id;
	}
	copyItem.css('display','block');
	tab.append(copyItem);
}

function initEventListener(){
	//[21-05-07] 리스트 아이템삭제에 쓰일 휴지통아이콘 visibility toggle기능
	let coinItems = document.getElementsByClassName("coinItem");
	let tab = tabManager.tabPages[1];
	let nodes = document.querySelectorAll("#"+tab[0].id+ " .coinItem");
	for(let item of nodes){
		item.addEventListener("mouseenter", e => {
			$("#"+item.id + " .removeItemBtn").css('visibility','visible');
		});
		item.addEventListener("mouseleave", e => {
			/* event.stopPropagation(); */
			$("#"+item.id + " .removeItemBtn").css('visibility','hidden');
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
		//[21-05-12] 탭 선택상태에 따라 작동할 id를 범위를 명확하게 바꿈. coinList와 coinListAll을 나누느라 사용했던 중복된 코드삭제 		
		let input=$("#searchCoinText").val().toUpperCase();
		if(searchSelector)
			tabManager.search(input,0);
		else
			tabManager.search(input,1);
		
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
	
	//[21-05-11] 즐겨찾기 추가
	let fav = document.getElementById('favoriteIcon')
	fav.addEventListener("click", e => {
		//fas = 채워진별==즐겨찾기상태 , far 비워진 별
		if(${sessionScope.curUser ==null}) {
			console.log("로그인 후 이용가능합니다.");
			return;
		}
		getName= $("#tableCoinName").html();
		if(fav.className=='far fa-star'){
			if(initListName.indexOf( getName ) == -1){
				initListName.push(getName);
				addItem(1);
				fav.className = 'fas fa-star';
				let user = '${sessionScope.curUser}';
				let msg={"usersid":JSON.parse(user).usersid, "coinname":getName};
				$.ajax({
					url:"favInsert.do",
					data: JSON.stringify(msg),
					type: "POST",
					contentType: 'application/json',
					success: function(data){
						console.log(data);
						console.log("추가완료");
					}
				})
			}
		}else{
			fav.className = 'far fa-star';
			let index = initListName.indexOf(getName);
			initListName.splice(index,1);
			removeItem(getName);
		}
	});
} 
function removeItem(item, e){
	let getCoinName;
	if(arguments.length==1){
		getCoinName=item;
		let getList = $('#coinList .marketName');
		let nameList= Array();
		Array.from(getList).forEach( i => {
			if ( i.innerHTML == getCoinName ){
				i.parentNode.parentNode.parentNode.remove();
			}
		})
	}else if(arguments.length==2){
		e.stopPropagation();
		if(!searchSelector){ return; }
		let getId=item.parentNode.parentNode.id;
		getCoinName=$("#"+getId+" .marketName").html();
		
		//[21-05-07] 즐겨찾기 삭제기능
		item.parentNode.parentNode.remove();
	}
	curItem="";
	if (${sessionScope.curUser == null}) return;
	let curUser ='${sessionScope.curUser}';
	let i={"usersid": JSON.parse(curUser).usersid ,"coinname" : getCoinName};
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
		let c = new coinData();
		c=coinDataMap.get("KRW-"+getKey);
		
		c.totalVolume-= (c.totalVolume*0.2);
		c.bidVolume-= (c.bidVolume*0.2);
		coinDataMap.set("KRW-"+getKey,c);
	}
	
	burnTimer = setTimeout(burn,5000);
}
function initTable(){
	//체결테이블 초기화
    // - 값을 -로 넣어둔 이유는 테이블의 모양이 바로 잡혀있도록 하기 위해.
    const initAskTable =  document.getElementById('askTable');
	const initBidTable =  document.getElementById('bidTable');
	for(var i=0; i<9; i++){
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
       	
       	if(initBidTable.tBodies[0].rows.length >9){
       		initBidTable.deleteRow(0);
       	}
       	if(initAskTable.tBodies[0].rows.length >9){
       		initAskTable.deleteRow(0);
       	}
	}
} 
function searchClear(){ $('#searchCoinText').val(""); $('#clearBtn').css('display','none'); }
function addComma(num){	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); }
let dChart;
function temp(){
	let socket2 = openSocket();
	socket2.onopen = event =>{
		let msg = [
			{
			ticket : "ANY_TEXT",
			},{
			type : "orderbook",
			// codes의 형식 : ["KRW-BTC","KRW-XRP","KRW-ETC","KRW-QTUM"]
			codes : ["KRW-XRP"]
			}
		];
		socket2.send(JSON.stringify(msg));
	}
	socket2.onmessage = event => {
		let enc = new TextDecoder("utf-8");
		let arr = new Uint8Array(event.data);
		let data = JSON.parse(enc.decode(arr));
		
		let dataArr = data.orderbook_units;
		Array.from(dataArr).forEach( obj => {
			let setAskData = [obj.ask_price,obj.ask_size];
			askorder.push(setAskData);
			let setBidData = [obj.bid_price,obj.bid_size];
			bidorder.push(setBidData);
		} )
		if(dChart==undefined){
			initDepthChart(); 
		}
		
		//socket2.close();
	}
}
function initDepthChart(){
	dChart = Highcharts.chart('depthChart', {
	    chart: {
	        type: 'area',
	        zoomType: 'xy',
	        height: 120,
	        width: 332,
	        margin: 5
	    },
	    title: {
	        text: null
	    },
	    xAxis: {
	        minPadding: 0,
	        maxPadding: 0,
	        plotLines: [{
	            color: '#888',
	            value: (bidorder[0][0]+askorder[0][0])/2 ,
	            width: 1,
	            label: {
	            	enabled:false,
	                text: null,
	                rotation: 90
	            }
	        }],
	        labels: {
		        enabled:false,
	        },
	        title: {
	            text: null
	        }
	    },
	    yAxis: [{
	        lineWidth: 1,
	        gridLineWidth: 1,
	        title: null,
	        tickWidth: 1,
	        tickLength: 5,
	        tickPosition: 'inside',
	    	labels: {
		        enabled:false,
	            align: 'left',
	            x: 8
	        } 
	    }, {
	        opposite: true,
	        linkedTo: 0,
	        lineWidth: 1,
	        gridLineWidth: 0,
	        title: null,
	        tickWidth: 1,
	        tickLength: 5,
	        tickPosition: 'inside',
	        labels: {
	        	enabled:false,
	            align: 'right',
	            x: -8
	        }
	    }],
	    legend: {
	        enabled: false
	    },
	    plotOptions: {
	        area: {
	            fillOpacity: 0.2,
	            lineWidth: 1,
	            step: 'center'
	        }
	    },
	    tooltip: {
	        headerFormat: '<span style="font-size=8px;">Price: {point.key}</span><br/>'
	        ,valueDecimals: 2
	    },
	    series: [{
	        name: 'Bids',
	        data: bidorder,
	        color: '#03a7a8'
	    }, {
	        name: 'Asks',
	        data: askorder,
	        color: '#fc5857'
	    }]
	});

}

function initChart(coinName){
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
		    	global : { 
			        useUTC : false
			    },
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
        			width:'91%',
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

//[21-05-11] 웹소캣으로 대체후 사용하지않음.
//21-05-03
//여러 코인의 정보를 ajax를 통해 가져와야하므로, 따로 함수를 만들고 async를 false로 설정해 동기식으로 변경.
//- 동기식으로 처리하지 않으면 다른 함수에서 return 받아 사용할 때, undefined이 출력된다.
//이는 비동기식으로 처리할경우 ajax를 통해 값을 받아오기 전에 다음 코드를 진행하기 때문. 
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
</script>

</body>

</html>