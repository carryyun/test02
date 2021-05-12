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
<link href="/resources/yun/cms/css/globalCSS.css?a" rel="stylesheet"> 
<link href="/resources/yun/cms/css/bootstrap.css?b" rel="stylesheet"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 차트에 필요한js -->
<script src="https://code.highcharts.com/stock/highstock.js"></script>
<script src="https://code.highcharts.com/stock/modules/data.js"></script>
<script src="https://code.highcharts.com/stock/modules/drag-panes.js"></script>
<!-- 차트를 그림저장, 인쇄 시켜주는모듈 -->
<!-- <script src="https://code.highcharts.com/stock/modules/exporting.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

<script crossorigin src="https://unpkg.com/react@17/umd/react.development.js"></script>
<script crossorigin src="https://unpkg.com/react-dom@17/umd/react-dom.development.js"></script>
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
</head>


<body>
<div id="root">

</div>




<script src="/resources/yun/cms/js/reactTest.js" type="text/bable"></script>
<script type="text/babel">
const name = '솔라가드';
const element = <h1>Hello, {name}</h1>;

function formatName(user){
	return user.firstName + ' ' + user.lastName;
}
const user = { 
	firstName : '솔라',
	lastName : '가드'
};
const ele = (
	<h1>
	hello, {formatName(user)}!
	</h1>
);

function getGreeting(user){
	if(user){
		return <h1>hello, {formatName(user)}! </h1>;
	}
	return <h1>hello, Stranger.</h1>;
}
const ele2 = (
	<h2>
		ele2
	{getGreeting(user)}
	</h2>
	
);

const ele3 = (
	<div>
		<h1>Hello!</h1>
		<h2>Good to see you here.</h2>
	</div>

);

const ele4 = React.createElement(
	'h1',
	{className: 'greeting'},
	'Hello, world!'
);

const ele5 = <h1>Hello, world</h1>;


function tick(){
	const ele6 = (
		<div>
			<h1>Hello,world</h1>
			<h2>It is {new Date().toLocaleTimeString()}.</h2>
		</div>
	);
	ReactDOM.render( ele6 , document.getElementById("root"));

	setInterval(tick, 1000);
}

class Welcome extends React.Component {
	render() {
		return <h1>Hello, {this.props.name}</h1>;
	}
}

const ele7 = <Welcome name="sola" />;


function App(){
	return (
	<div>
		<Welcome name="thf" />
		<Welcome name="fk" />
		<Welcome name="rkem" />
	</div>
	);
}


function Comment(props) {
	return (
		<div className="Comment">
			<div className="UserInfo">
				<img className="Avatar"
					src={props.author.avatarUrl}
					alt={props.autor.name}
				/>
				<div className="UserInfo-name">
					{props.author.name}
				</div>
			</div>
			<div className="Comment-text">
				{props.text}
			</div>
			<div className="Comment-data">
				{formatDate(props.date)}
			</div>
		</div>
	);
}

function Avatar(props) {
	return(
		<img className="Avartar"
			src={props.user.avatarUrl}
			alt={props.user.name}
		/>
	);

}

ReactDOM.render(
	<App />,
	document.getElementById('root')
);

</script>

</body>

</html>